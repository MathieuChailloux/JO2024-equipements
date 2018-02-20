create table route_pc
as (select distinct r.*
    from route_idf r, departements_pc d
    where st_intersects(r.geom,d.geom))