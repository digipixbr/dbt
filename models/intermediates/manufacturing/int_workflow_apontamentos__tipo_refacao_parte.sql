with
    pbita as (
        select * from {{ ref("stg_dpxdb_workflow__productionbatchitem_taskactual") }}
    ),
    rr as (select * from {{ ref("stg_dpxdb_workflow__refacaorequest") }}),
    rar as (select * from {{ ref("stg_dpxdb_workflow__refacaoapprovalreason") }}),
    rrp as (select * from {{ ref("stg_dpxdb_workflow__refacaorequest_part") }}),

    tarefas as (
        select
            'Refacao Parte' as tipo_registro,
            rr.refacaorequestid as id_registro,
            rr.productionbatchitemid,
            rar.name as responsavel,
            'Solicitação de refação' as tarefa,
            1 as qtd,
            '' as tarefa_status,
            '' as tarefa_status_anterior,
            rrp.partid,
            pbita.productid,
            rr.insertdate as dt_inicio,
            rr.approvaldate as dt_fim,
            rr.updatedate as dt_ult_atualizacao,
            rr.updateuserid as userid

        from rr
        inner join rrp on rrp.refacaorequestid = rr.refacaorequestid
        inner join
            pbita
            on pbita.productionbatchitemid = rr.productionbatchitemid
            and pbita.partid = rrp.partid
        inner join rar on rar.refacaoapprovalreasonid = rr.refacaoapprovalreasonid
        where
            rr.approvaldate between {{ dbt_date.today() }} -5 and {{ dbt_date.today() }}
            and rr.refacaorequeststatusid = 2
    )

select *
from tarefas
