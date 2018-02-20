alter table equipements add classif_typ_id integer;
alter table equipements add est_ouvert boolean;

update equipements
set classif_typ_id =
	(select classification.classif_type
	from classification
	where classification.eqt_fam = equipements.eqt_fam
	and classification.eqt_type = equipements.eqt_type);

update equipements
set est_ouvert =
	(case
		-- eqt_pro_id = 5 <=> eqt_pro = Etablissement privé commercial
		when eqt_pro_id = 5 then false
		when classif_typ_id = 1 then true
		else false
	end);
	
--select eqt_fam, eqt_type, eqt_pro, classif_typ_id, est_ouvert from equipements

--select UpdateGeometrySRID('public', 'equipements', 'geom', 4326) ;


/*ALTER TABLE equipements
 ALTER COLUMN geom TYPE geometry(Point, 4326) USING ST_Transform(ST_SetSRID(geom,2154),4326) ;*/
