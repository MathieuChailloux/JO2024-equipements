create table departements_pc
as (select *
    from departements
    where code_dept = '75' or code_dept = '92'
    or code_dept = '93' or code_dept = '94')