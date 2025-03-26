with
    refacao_parte as (
        select * from {{ ref("int_workflow_apontamentos__tipo_refacao_parte") }}
    ),
    refacao_produto as (
        select * from {{ ref("int_workflow_apontamentos__tipo_refacao_produto") }}
    ),
    tarefa as (select * from {{ ref("int_workflow_apontamentos__tipo_tarefa") }}),
    pbi as (select * from {{ ref("stg_dpxdb_workflow__productionbatchitem") }}),
    poi as (select * from {{ ref("stg_dpxdb_workflow__productionorderitem") }}),
    po as (select * from {{ ref("stg_dpxdb_workflow__productionorder") }}),
    part as (select * from {{ ref("stg_dpxdb_workflow__part") }}),
    product as (select * from {{ ref("stg_dpxdb_workflow__product") }}),
    so as (select * from {{ ref("stg_dpxdb_digipix__salesorder") }}),
    u as (select * from {{ ref("stg_dpxdb_digipix__user") }}),
    tpoi as (select * from {{ ref("stg_ttps_ttps__productionorderitem") }}),
    a as (
        select *
        from refacao_parte
        union all
        select *
        from refacao_produto
        union all
        select *
        from tarefa
    ),
    workflow_apointamentos as (
        select
            po.originalsystemreference as id_pedido,
            so.approvaldate as dt_liberacao,
            so.customerproductiondate as dt_producao,
            so.internalproductiondate as dt_producao_int,
            tpoi.numorderitem,
            poi.originalsystemreference as id_pedido_item,
            a.tipo_registro,
            a.id_registro,
            a.productionbatchitemid,
            a.responsavel,
            a.tarefa,
            a.qtd,
            a.tarefa_status,
            a.tarefa_status_anterior,
            part.name as parte,
            product.name as produto,
            a.dt_inicio,
            a.dt_fim,
            a.dt_ult_atualizacao,
            cast('1900-01-01' as datetime) as dt_tarefa_anterior,
            u.name as atualizado_por
        from a
        inner join pbi on pbi.productionbatchitemid = a.productionbatchitemid
        inner join poi on poi.productionorderitemid = pbi.productionorderitemid
        inner join po on po.productionorderid = poi.productionorderid
        inner join
            tpoi
            on tpoi.productionorderitemid = cast(poi.originalsystemreference as INT64)
            and tpoi.productionorderid = po.originalsystemreference
            inner join so on cast( so.originalsystemreference as INT64) =po.originalsystemreference 
            left join part on part.partid = a.partid
        left join product on product.productid = a.productid
        left join u on u.userid = a.userid

    )

select *
from workflow_apointamentos
