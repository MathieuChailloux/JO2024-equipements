select distinct ins_com from equipements order by ins_com;

select * from equipements limit 10
select count(*) from equipements;

\set eqt_table_name 'equipement_paris'


create table equipements_pc
as (select e.* from equipements e, departements_pc d
	where st_intersects(e.geom,d.geom))

select count(*) from :eqt_table_name limit 10

alter table equipements_pc add column closestVertexID integer

update equipements_pc
set closestVertexID = (select v.id from reseau_route_pc_vertices_pgr v
                       where st_distance(v.the_geom,equipements_pc.geom) < 1000
                       order by st_distance(v.the_geom,equipements_pc.geom) limit 1)

select * from :eqt_table_name

--select * from createDrivingDistanceTable()
