select e.*
from equipements_2154 e, arrondissement a
where st_contains(a.geom,e.geom)

select * from equipements_2154

select * from arrondissement

select *
from route r, arrondissement a
where st_within(r.geom,a.geom)
limit 5

create table equipements_2154 as
select * from equipements

select * from equipements_2154 limit 5

