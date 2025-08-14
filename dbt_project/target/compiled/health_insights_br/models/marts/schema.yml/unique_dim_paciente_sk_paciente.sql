
    
    

select
    sk_paciente as unique_field,
    count(*) as n_records

from `workspace`.`health_insights_br`.`dim_paciente`
where sk_paciente is not null
group by sk_paciente
having count(*) > 1


