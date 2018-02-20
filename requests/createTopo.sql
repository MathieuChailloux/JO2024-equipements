create extension pgrouting

\set reseau_table_name 'reseau_route'
\set reseau_vertices_table_name 'reseau_route_vertices_pgr'

create table reseau_route_pc (
	id integer,
	geom geometry(MultiLineString,4326),
	source integer,
	target integer,
	cost float,
	reverse_cost float,
	constraint reseau_route_pc_pkey primary key(id));

--drop table :reseau_table_name
truncate reseau_route_pc
select gid,geom from route_pc where gid = 407857
select * from reseau_route_pc
select gid, ST_Force2D(geom), st_length(ST_Force2D(geom)::geography), st_length(ST_Force2D(geom)::geography) from route_pc
select count(*) from route_pc
select count (distinct gid) from route_pc
select gid, count(*) as cpt from route_pc group by gid order by cpt desc

/* Force to 2D to compare geographies.
	Cast to ::geography to retrieve length in meters (values were very small otherwise). */
insert into reseau_route_pc (id, geom, cost, reverse_cost)
	select gid, ST_Force2D(geom), st_length(ST_Force2D(geom)::geography), st_length(ST_Force2D(geom)::geography) from route_pc;

-- Exploration requests
/*select distinct cost from :reseau_table_name order by cost desc
select distinct st_length(geom) from :reseau_table_name
select * from :reseau_table_name*/



--drop table :reseau_vertices_table_name

/* Tolerance value (0.0001) needed to be small on some launches but not always.
	Analyze graph not necessary. */
select pgr_createTopology('reseau_route_pc',0.001,the_geom:='geom',id:='id',source:='source',target:='target');
select pgr_analyzeGraph('reseau_route_pc',0.001,the_geom:='geom');

create index source_idx on reseau_route_pc("source");
create index target_idx on reseau_route_pc("target");

-- Exploration requests
/*select * from :reseau_vertices_table_name
select *, st_length(geom) from :reseau_table_name limit 10*/


/*select * from pgr_drivingdistance('select id, source, target, cost from :reseau_table_name',10,400,false,false)

create  table tmp_table as (select * from equipements)
alter table tmp_table add column closestVertexID integer

select * from tmp_table

update tmp_table
set closestVertexID = (select v.id from :reseau_vertices_table_name v
                       where st_distance(v.the_geom,tmp_table.geom) < 1000
                       order by st_distance(v.the_geom,tmp_table.geom) limit 1)

select * from createDrivingDistanceTable()
select * from points_atteignables

create table zone_atteignable as
	(select eqtId, closestId, pgr_pointsAsPolygon('select id, st_x(geom) as w, st_y(geom)
                                                  from ' || :reseau_vertices_table_name || ' tmp
                                                  where pa.reachedId')
    from points_atteignables pa
    group by eqtId, closestId)*/

/*create table pointsMoins5mn as
	(select tt.id, dd.id, dd.cost
    from tmp_table tt,
    (select * from pgr_drivingdistance('select id, source, target, cost from :reseau_table_name',tt.id,400,false,false) where a = 3) as dd)

alter table tmp_table add column bufferGeom geometry
update tmp_table
set bufferGeom =
	(select )*/