CREATE OR REPLACE FUNCTION createDrivingDistanceTable() RETURNS void AS $$
DECLARE
	sql text; -- pour les requetes
	tmpRow record;

BEGIN

	CREATE TABLE points_atteignables_paris (
		eqtId integer,
		closestId integer,
		reachedId integer,
		cost float,
		geom geometry(LINESTRING,4326)
	);
	
	FOR tmpRow IN
		SELECT * FROM equipement_paris WHERE est_ouvert = 't'
	LOOP
		INSERT INTO points_atteignables_paris
		SELECT tmpRow.gid, tmpRow.closestVertexID, dd.id1, dd.cost, ST_Makeline(tmpRow.geom,vertices.the_geom)
		FROM (SELECT * FROM pgr_drivingdistance('select id, source, target, cost from reseau_route', tmpRow.closestVertexID,400,false,false)) as dd,
			reseau_route_vertices_pgr vertices
		WHERE vertices.id = dd.id1;
	END LOOP;

END;
$$ LANGUAGE plpgsql;