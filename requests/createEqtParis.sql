select distinct ins_com from equipements order by ins_com;

select * from equipements limit 10
select count(*) from equipements;

\set eqt_table_name 'equipement_paris'

insert into :eqt_table_name
select * from equipements
where ins_com = 'Paris'

select count(*) from :eqt_table_name limit 10

alter table :eqt_table_name add column closestVertexID integer

update :eqt_table_name
set closestVertexID = (select v.id from reseau_route_vertices_pgr v
                       where st_distance(v.the_geom,:eqt_table_name.geom) < 1000
                       order by st_distance(v.the_geom,:eqt_table_name.geom) limit 1)

select * from :eqt_table_name

select * from createDrivingDistanceTable()
