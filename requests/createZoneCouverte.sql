
alter table zone_couverte_paris rename to zone_couverte_paris_init

create table zone_couverte_pc
(
  eqtid integer,
  closestid integer,
  geom geometry(POLYGON,4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE zone_couverte_pc
  OWNER TO postgres;

truncate table zone_couverte_pc;

insert into zone_couverte_pc
select pap.eqtid, pap.closestid, st_convexhull(st_collect(array_agg(v.the_geom))) as geom
from points_atteignables_pc pap, reseau_route_pc_vertices_pgr v
where pap.reachedid = v.id
group by eqtid, closestid
having count(*) > 2;

--select * from zone_couverte_paris;

update zone_couverte_pc
set geom =
	(select
	  case
	    when st_within(e.geom,zone_couverte_pc.geom) then zone_couverte_pc.geom
	    else st_snap(zone_couverte_pc.geom,e.geom,400)
	  end
	from equipements_pc e
	where zone_couverte_pc.eqtid = e.gid)