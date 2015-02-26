		CREATE TABLE ocp_import_parts_done
		(
			imp_id varchar(255) NULL,
			imp_session integer NULL,
			PRIMARY KEY (imp_id,imp_session)
		) TYPE=InnoDB;

		CREATE TABLE ocp_import_session
		(
			imp_old_base_dir varchar(255) NOT NULL,
			imp_db_name varchar(80) NOT NULL,
			imp_db_user varchar(80) NOT NULL,
			imp_hook varchar(80) NOT NULL,
			imp_db_table_prefix varchar(80) NOT NULL,
			imp_db_host varchar(80) NOT NULL,
			imp_refresh_time integer NOT NULL,
			imp_session integer NULL,
			PRIMARY KEY (imp_session)
		) TYPE=InnoDB;

		CREATE TABLE ocp_import_id_remap
		(
			id_old varchar(80) NULL,
			id_new integer NOT NULL,
			id_type varchar(80) NULL,
			id_session integer NULL,
			PRIMARY KEY (id_old,id_type,id_session)
		) TYPE=InnoDB;

		CREATE TABLE ocp_anything
		(
			id varchar(80) NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;


		CREATE INDEX `import_id_remap.id_old` ON ocp_import_id_remap(id_old);
		ALTER TABLE ocp_import_id_remap ADD FOREIGN KEY `import_id_remap.id_old` (id_old) REFERENCES ocp_anything (id);

		CREATE INDEX `import_id_remap.id_new` ON ocp_import_id_remap(id_new);
		ALTER TABLE ocp_import_id_remap ADD FOREIGN KEY `import_id_remap.id_new` (id_new) REFERENCES ocp_anything (id);
