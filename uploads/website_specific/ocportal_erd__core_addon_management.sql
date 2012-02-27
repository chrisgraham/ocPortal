		CREATE TABLE ocp_addons
		(
			addon_name varchar(255) NULL,
			addon_author varchar(255) NOT NULL,
			addon_organisation varchar(255) NOT NULL,
			addon_version varchar(255) NOT NULL,
			addon_description longtext NOT NULL,
			addon_install_time integer unsigned NOT NULL,
			PRIMARY KEY (addon_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp_addons_files
		(
			id integer auto_increment NULL,
			addon_name varchar(255) NOT NULL,
			filename varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_addons_dependencies
		(
			id integer auto_increment NULL,
			addon_name varchar(255) NOT NULL,
			addon_name_dependant_upon varchar(255) NOT NULL,
			addon_name_incompatibility tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

