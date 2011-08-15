		CREATE TABLE ocp6_occlechat
		(
			id integer auto_increment NULL,
			c_message longtext NOT NULL,
			c_url varchar(255) NOT NULL,
			c_incoming tinyint(1) NOT NULL,
			c_timestamp integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

