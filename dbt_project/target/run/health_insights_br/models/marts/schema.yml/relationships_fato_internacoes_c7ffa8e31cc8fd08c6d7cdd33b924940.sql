
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select sk_paciente as from_field
    from `workspace`.`health_insights_br`.`fato_internacoes`
    where sk_paciente is not null
),

parent as (
    select sk_paciente as to_field
    from `workspace`.`health_insights_br`.`dim_paciente`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test