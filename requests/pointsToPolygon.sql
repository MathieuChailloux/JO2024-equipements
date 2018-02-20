CREATE OR REPLACE FUNCTION pointsToPolygon() RETURNS void AS $$
DECLARE
	sql text; -- pour les requetes
	pap_sql text; -- pour les requetes
	tmpRow record;

BEGIN

	CREATE TABLE zone_couverte_paris (
		eqtId integer,
		--closestId integer,
		geom geometry(POLYGON,4326)
	);
	
	FOR tmpRow IN
		SELECT eqtid FROM points_atteignables_paris group by eqtid having count(*) > 2
	LOOP
		pap_sql='select vertices.id::integer as id, st_x(vertices.the_geom)::float as x, st_y(vertices.the_geom)::float as y from points_atteignables_paris pap, reseau_route_vertices_pgr vertices where pap.eqtid = ' || tmpRow.eqtid || ' and pap.reachedid = vertices.id';
		INSERT INTO zone_couverte_paris
		VALUES (tmpRow.eqtid, --reachedPointsTable.closestid,
			st_setsrid(pgr_pointsaspolygon(pap_sql),4326));
		/*FROM (select pap.eqtid as eqtid, pap.closestid as closestid, vertices.id as vid, vertices.the_geom as vgeom
			from points_atteignables_paris pap, reseau_route_vertices_pgr vertices
			where pap.reachedid = vertices.id
			and pap.eqtid = tmpRow.eqtid) as reachedPointsTable
		LIMIT 1;*/
	END LOOP;

END;
$$ LANGUAGE plpgsql;