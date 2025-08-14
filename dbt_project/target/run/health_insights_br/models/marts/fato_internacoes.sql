
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- models/marts/fato_internacoes.sql
select
    p.sk_paciente,
    s.data_internacao,
    s.ano_competencia,
    s.mes_competencia,
    s.cid_diagnostico_principal,
    s.valor_total_internacao

from `workspace`.`health_insights_br`.`stg_sih_internacoes` as s
left join `workspace`.`health_insights_br`.`dim_paciente` as p
    on s.id_internacao = p.sk_paciente
  
  
      
    ) dbt_internal_test