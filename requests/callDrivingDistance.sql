--select * from pgr_drivingdistance('select id, source, target, cost from :reseau_table_name',10,400,false,false)

\set eqt_table_name 'equipements';
\set reseau_vertices_table_name 'reseau_route_vertices_pgr';
\set pap_table 'points_atteignables_paris'

--create  table tmp_table as (select * from equipements)

--alter table :eqt_table_name add column closestVertexID integer

--select * from tmp_table

/*update :eqt_table_name
set closestVertexID = (select v.id from :reseau_vertices_table_name v
                       where st_distance(v.the_geom,:eqt_table_name.geom) < 1000
                       order by st_distance(v.the_geom,:eqt_table_name.geom) limit 1);*/

alter table points_atteignables_paris rename to points_atteignables_paris_init;

select * from createDrivingDistanceTable()


--select * from points_atteignables_paris limit 10

/*create table zone_atteignable as
	(select eqtId, closestId, pgr_pointsAsPolygon('select id, st_x(geom) as w, st_y(geom)
                                                  from ' || :reseau_vertices_table_name || ' tmp
                                                  where pa.reachedId')
    from points_atteignables pa
    group by eqtId, closestId)*/