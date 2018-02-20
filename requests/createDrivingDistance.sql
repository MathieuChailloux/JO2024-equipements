CREATE OR REPLACE FUNCTION createDrivingDistanceTable() RETURNS void AS $$
DECLARE
	sql text; -- pour les requetes
	tmpRow record;

BEGIN

	CREATE TABLE points_atteignables_pc (
		eqtId integer,
		closestId integer,
		reachedId integer,
		cost float,
		geom geometry(LINESTRING,4326)
	);
	
	FOR tmpRow IN
		SELECT * FROM equipements_pc WHERE est_ouvert = 't'
	LOOP
		INSERT INTO points_atteignables_pc
		SELECT tmpRow.gid, tmpRow.closestVertexID, dd.id1, dd.cost, ST_Makeline(tmpRow.geom,vertices.the_geom)
		FROM (SELECT * FROM pgr_drivingdistance('select id, source, target, cost from reseau_route_pc', tmpRow.closestVertexID,400,false,false)) as dd,
			reseau_route_pc_vertices_pgr vertices
		WHERE vertices.id = dd.id1;
	END LOOP;

END;
$$ LANGUAGE plpgsql;