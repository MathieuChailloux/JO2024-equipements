create table classification (
	eqt_fam character varying(255),
	eqt_type character varying(255),
	classif_type integer
);

copy classification from 'D:IGAST_MChailloux/ProjetAnalyseSpatiale/Work/classif.csv' delimiter ';' csv;