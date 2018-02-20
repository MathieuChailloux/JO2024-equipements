-- array_agg

select * from pointsToPolygon()

select * from zone_couverte_paris

SELECT distinct eqtid, reachedid FROM points_atteignables_paris

select eqtid, closestid, count(*)
from points_atteignables_paris
group by eqtid, closestid
order by count


/*create table tmp_table
(
  eqtid integer,
  closestid integer,
  geom geometry(POLYGON,4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tmp_table
  OWNER TO postgres;

truncate table tmp_table;

insert into tmp_table
select pap.eqtid, pap.closestid, st_convexhull(st_collect(array_agg(v.the_geom))) as geom
from points_atteignables_paris pap, reseau_route_vertices_pgr v
where pap.reachedid = v.id
group by eqtid, closestid
having count(*) > 2;
--order by count

select * from tmp_table;

update tmp_table
set geom =
	(select
	  case
	    when st_within(e.geom,tmp_table.geom) then tmp_table.geom
	    else st_snap(tmp_table.geom,e.geom,400)
	  end
	from equipement_paris e
	where tmp_table.eqtid = e.gid)
	



select * from points_atteignables_paris limit 10

SELECT eqtid, closestid, count(*) FROM points_atteignables_paris group by eqtid, closestid having count(*) > 2*/