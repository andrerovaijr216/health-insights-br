
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select sk_paciente
from `workspace`.`health_insights_br`.`dim_paciente`
where sk_paciente is null



  
  
      
    ) dbt_internal_test