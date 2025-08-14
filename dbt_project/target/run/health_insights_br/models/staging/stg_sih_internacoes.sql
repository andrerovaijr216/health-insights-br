
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select
    -- IDs e Chaves
    N_AIH as id_internacao,

    -- Datas
    to_date(DT_INTER, 'yyyyMMdd') as data_internacao,
    ANO_CMPT as ano_competencia,
    MES_CMPT as mes_competencia,

    -- Demografia do Paciente
    SEXO as sexo_paciente,
    IDADE as idade_paciente,
    UF_ZI as uf_paciente,
    MUNIC_RES as municipio_residencia_paciente,

    -- Informações Clínicas
    DIAG_PRINC as cid_diagnostico_principal,

    -- Valores
    VAL_TOT as valor_total_internacao

from `workspace`.`health_insights_br`.`bronze_internacoes_sih`
  
  
      
    ) dbt_internal_test