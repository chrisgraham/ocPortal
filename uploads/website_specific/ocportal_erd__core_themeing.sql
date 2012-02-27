		CREATE TABLE ocp_theme_images
		(
			id varchar(255) NULL,
			theme varchar(40) NULL,
			path varchar(255) NOT NULL,
			lang varchar(5) NULL,
			PRIMARY KEY (id,theme,lang)
		) TYPE=InnoDB;

