-- models/marts/fato_internacoes.sql
select
    p.sk_paciente,
    s.data_internacao,
    s.ano_competencia,
    s.mes_competencia,
    s.cid_diagnostico_principal,
    s.valor_total_internacao

from {{ ref('stg_sih_internacoes') }} as s
left join {{ ref('dim_paciente') }} as p
    on s.id_internacao = p.sk_paciente