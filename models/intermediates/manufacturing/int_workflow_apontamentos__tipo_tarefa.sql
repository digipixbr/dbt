with
    pbita as (
        select * from {{ ref("stg_dpxdb_workflow__productionbatchitem_taskactual") }}
    ),
    pbits as (
        select * from {{ ref("stg_dpxdb_workflow__productionbatchitem_taskstatus") }}
    ),
    pbits_r as (
        select * from {{ ref("stg_dpxdb_workflow__productionbatchitem_taskstatus") }}
    ),
    pbitar as (
        select *
        from {{ ref("stg_dpxdb_workflow__productionbatchitem_taskactual_resource") }}
    ),
    t as (select * from {{ ref("stg_dpxdb_workflow__task") }}),
    rp as (select * from {{ ref("stg_dpxdb_workflow__resourcepeople") }}),

    tarefas as (
        select
            'Tarefa' as tipo_registro,
            pbita.productionbatchitem_taskactualid as id_registro,
            pbita.productionbatchitemid,
            rp.name as responsavel,
            t.name as tarefa,
            1 as qtd,
            pbits.name as tarefa_status,
            pbits_r.name as tarefa_status_anterior,
            pbita.partid,
            pbita.productid,
            pbita.datestart as dt_inicio,
            pbita.dateend as dt_fim,
            pbita.updatedate as dt_ult_atualizacao,
            pbita.updateuserid as userid

        from pbita
        inner join
            pbits
            on pbits.productionbatchitem_taskstatusid
            = pbita.productionbatchitem_taskstatusid
        left join
            pbits_r
            on pbits_r.productionbatchitem_taskstatusid
            = pbita.previousrefacaorequestproductionbatchitem_taskstatusid
        inner join
            pbitar
            on pbitar.productionbatchitem_taskactualid
            = pbita.productionbatchitem_taskactualid
        inner join t on t.taskid = pbita.taskid
        inner join rp on rp.resourceid = pbitar.resourceid
        where
            pbita.updatedate
            between {{ dbt_date.today() }} -5 and {{ dbt_date.today() }}
    )

select *
from tarefas
