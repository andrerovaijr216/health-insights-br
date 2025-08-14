-- models/marts/dim_paciente.sql
select
    -- Usando o ID da internação como chave única para o paciente nesta análise
    id_internacao as sk_paciente,

    sexo_paciente,
    idade_paciente,
    uf_paciente,
    municipio_residencia_paciente

from `workspace`.`health_insights_br`.`stg_sih_internacoes`