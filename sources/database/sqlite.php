<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/*EXTRA FUNCTIONS: sqlite\_.+*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_database_drivers
 */

/*
SQLite is a great little (but very inefficient) DB.
You just copy a DLL into the path, and choose a filename as a database name.
No need for presetting up, or usernames or passwords.
*/

/**
 * Database Driver.
 * @package		core_database_drivers
 */
class Database_Static_sqlite
{

	var $cache_db=array();

	/**
	 * Get the default user for making db connections (used by the installer as a default).
	 *
	 * @return string			The default user for db connections
	 */
	function db_default_user()
	{
		return '';
	}

	/**
	 * Get the default password for making db connections (used by the installer as a default).
	 *
	 * @return string			The default password for db connections
	 */
	function db_default_password()
	{
		return '';
	}

	/**
	 * Create a table index.
	 *
	 * @param  ID_TEXT		The name of the table to create the index on
	 * @param  ID_TEXT		The index name (not really important at all)
	 * @param  string			Part of the SQL query: a comma-separated list of fields to use on the index
	 * @param  array			The DB connection to make on
	 */
	function db_create_index($table_name,$index_name,$_fields,$db)
	{
		if ($index_name[0]=='#') return;
		$this->db_query('CREATE INDEX index'.$index_name.'_'.strval(mt_rand(0,10000)).' ON '.$table_name.'('.$_fields.')',$db);
	}

	/**
	 * Change the primary key of a table.
	 *
	 * @param  ID_TEXT		The name of the table to create the index on
	 * @param  array			A list of fields to put in the new key
	 * @param  array			The DB connection to make on
	 */
	function db_change_primary_key($table_name,$new_key,$db)
	{
		$this->db_query('ALTER TABLE '.$table_name.' DROP PRIMARY KEY',$db);
		$this->db_query('ALTER TABLE '.$table_name.' ADD PRIMARY KEY ('.implode(',',$new_key).')',$db);
	}

	/**
	 * Get the ID of the first row in an auto-increment table (used whenever we need to reference the first).
	 *
	 * @return integer			First ID used
	 */
	function db_get_first_id()
	{
		return 1;
	}

	/**
	 * Get a map of ocPortal field types, to actual mySQL types.
	 *
	 * @return array			The map
	 */
	function db_get_type_remap()
	{
		$type_remap=array(
			'AUTO'=>'integer',
			'AUTO_LINK'=>'integer',
			'INTEGER'=>'integer',
			'UINTEGER'=>'bigint',
			'SHORT_INTEGER'=>'smallint unsigned',
			'REAL'=>'real',
			'BINARY'=>'bit',
			'MEMBER'=>'integer',
			'GROUP'=>'integer',
			'TIME'=>'integer',
			'LONG_TRANS'=>'integer',
			'SHORT_TRANS'=>'integer',
			'SHORT_TEXT'=>'text',
			'LONG_TEXT'=>'longtext',
			'ID_TEXT'=>'varchar(80)',
			'MINIID_TEXT'=>'varchar(40)',
			'IP'=>'varchar(40)',
			'LANGUAGE_NAME'=>'varchar(5)',
			'URLPATH'=>'varchar(255)',
			'MD5'=>'varchar(33)'
		);
		return $type_remap;
	}

	/**
	 * Create a new table.
	 *
	 * @param  ID_TEXT		The table name
	 * @param  array			A map of field names to ocPortal field types (with *#? encodings)
	 * @param  array			The DB connection to make on
	 */
	function db_create_table($table_name,$fields,$db)
	{
		$type_remap=$this->db_get_type_remap();

		$_fields='';
		$keys='';
		foreach ($fields as $name=>$type)
		{
			if ($type[0]=='*') // Is a key
			{
				$type=substr($type,1);
				if ($keys!='') $keys.=', ';
				$keys.=$name;
			}

			if ($type[0]=='?') // Is perhaps null
			{
				$type=substr($type,1);
				$perhaps_null='';
			} else $perhaps_null='NOT NULL';

			$type=isset($type_remap[$type])?$type_remap[$type]:$type;

			$_fields.="	  $name $type $perhaps_null,\n";
		}

		$query='CREATE TABLE '.$table_name.' (
		  '.$_fields.'
		  PRIMARY KEY ('.$keys.')
		)';
		$this->db_query($query,$db,NULL,NULL);
	}

	/**
	 * Encode an SQL statement fragment for a conditional to see if two strings are equal.
	 *
	 * @param  ID_TEXT		The attribute
	 * @param  string			The comparison
	 * @return string			The SQL
	 */
	function db_string_equal_to($attribute,$compare)
	{
		return $attribute." LIKE '".$this->db_escape_string($compare)."'";
	}

	/**
	 * Encode an SQL statement fragment for a conditional to see if two strings are not equal.
	 *
	 * @param  ID_TEXT		The attribute
	 * @param  string			The comparison
	 * @return string			The SQL
	 */
	function db_string_not_equal_to($attribute,$compare)
	{
		return $attribute."<>'".$this->db_escape_string($compare)."'";
	}

	/**
	 * This function is internal to the database system, allowing SQL statements to be build up appropriately. Some databases require IS NULL to be used to check for blank strings.
	 *
	 * @return boolean			Whether a blank string IS NULL
	 */
	function db_empty_is_null()
	{
		return false;
	}

	/**
	 * Delete a table.
	 *
	 * @param  ID_TEXT		The table name
	 * @param  array			The DB connection to delete on
	 */
	function db_drop_table_if_exists($table,$db)
	{
		$this->db_query('DROP TABLE '.$table,$db,NULL,NULL,true);
	}

	/**
	 * Determine whether the database is a flat file database, and thus not have a meaningful connect username and password.
	 *
	 * @return boolean			Whether the database is a flat file database
	 */
	function db_is_flat_file_simple()
	{
		return true;
	}

	/**
	 * Encode a LIKE string comparision fragement for the database system. The pattern is a mixture of characters and ? and % wilcard symbols.
	 *
	 * @param  string			The pattern
	 * @return string			The encoded pattern
	 */
	function db_encode_like($pattern)
	{
		return $this->db_escape_string($pattern);
	}

	/**
	 * Close the database connections. We don't really need to close them (will close at exit), just disassociate so we can refresh them.
	 */
	function db_close_connections()
	{
		foreach ($this->cache_db as $db)
		{
			foreach ($db as $_db)
			{
				sqlite_query($_db,'END TRANSACTION');
				sqlite_close($_db);
			}
		}
	}

	/**
	 * Get a database connection. This function shouldn't be used by you, as a connection to the database is established automatically.
	 *
	 * @param  boolean		Whether to create a persistent connection
	 * @param  string			The database name
	 * @param  string			The database host (the server)
	 * @param  string			The database connection username
	 * @param  string			The database connection password
	 * @param  boolean		Whether to on error echo an error and return with a NULL, rather than giving a critical error
	 * @return ?array			A database connection (NULL: failed)
	 */
	function db_get_connection($persistent,$db_name,$db_host,$db_user,$db_password,$fail_ok=false)
	{
		// Potential cacheing
		if (isset($this->cache_db[$db_name][$db_host]))
		{
			return $this->cache_db[$db_name][$db_host];
		}

		if (!function_exists('sqlite_popen'))
		{
			$error='The sqlite PHP extension not installed (anymore?). You need to contact the system administrator of this server.';
			if ($fail_ok)
			{
				echo $error;
				return NULL;
			}
			critical_error('PASSON',$error);
		}

		$error_message='';
		$db=$persistent?@sqlite_popen(get_file_base().'/'.$db_name,0666,$error_message):@sqlite_open(get_file_base().'/'.$db_name,0666,$error_message);
		if ($db===false)
		{
			$error='Could not open database file ('.$error_message.')';
			if ($fail_ok)
			{
				echo $error;
				return NULL;
			}
			critical_error('PASSON',$error); //warn_exit(do_lang_tempcode('CONNECT_DB_ERROR'));
		}
		sqlite_query($db,'BEGIN TRANSACTION');

		if (!$db) fatal_exit(do_lang('CONNECT_DB_ERROR'));
		$this->cache_db[$db_name][$db_host]=$db;
		return $db;
	}

	/**
	 * Find whether full-text-search is present
	 *
	 * @param  array			A DB connection
	 * @return boolean		Whether it is
	 */
	function db_has_full_text($db)
	{
		return false;
	}

	/**
	 * Escape a string so it may be inserted into a query. If SQL statements are being built up and passed using db_query then it is essential that this is used for security reasons. Otherwise, the abstraction layer deals with the situation.
	 *
	 * @param  string			The string
	 * @return string			The escaped string
	 */
	function db_escape_string($string)
	{
		return sqlite_escape_string($string);
	}

	/**
	 * This function is a very basic query executor. It shouldn't usually be used by you, as there are abstracted versions available.
	 *
	 * @param  string			The complete SQL query
	 * @param  array			A DB connection
	 * @param  ?integer		The maximum number of rows to affect (NULL: no limit)
	 * @param  ?integer		The start row to affect (NULL: no specification)
	 * @param  boolean		Whether to output an error on failure
	 * @param  boolean		Whether to get the autoincrement ID created for an insert query
	 * @return ?mixed			The results (NULL: no results), or the insert ID
	 */
	function db_query($query,$db,$max=NULL,$start=NULL,$fail_ok=false,$get_insert_id=false)
	{
		if (substr($query,0,7)=='SELECT')
		{
			if ((!is_null($max)) && (!is_null($start))) $query.=' LIMIT '.strval(intval($start)).','.strval(intval($max));
			elseif (!is_null($max)) $query.=' LIMIT '.strval(intval($max));
			elseif (!is_null($start)) $query.=' LIMIT '.strval(intval($start)).',30000000';
		}

		$results=@sqlite_query($db,$query);
		if ((($results===false) || ((strtoupper(substr($query,0,7))=='SELECT ') || (strtoupper(substr($query,0,8))=='(SELECT ') && ($results===true))) && (!$fail_ok))
		{
			$err=sqlite_last_error($db);
			if (function_exists('ocp_mark_as_escaped')) ocp_mark_as_escaped($err);
			if ((!running_script('upgrader')) && (!get_mass_import_mode()))
			{
				if (!function_exists('do_lang') || is_null(do_lang('QUERY_FAILED',NULL,NULL,NULL,NULL,false))) fatal_exit(htmlentities('Query failed: '.$query.' : '.$err));

				fatal_exit(do_lang_tempcode('QUERY_FAILED',escape_html($query),($err)));
			} else
			{
				echo htmlentities('Database query failed: '.$query.' [').($err).htmlentities(']'.'<br />'."\n");
				return NULL;
			}
		}

		if ((strtoupper(substr($query,0,7))=='SELECT ') || (strtoupper(substr($query,0,8))=='(SELECT ') && ($results!==false) && ($results!==true))
		{
			return $this->db_get_query_rows($results);
		}

		if ($get_insert_id)
		{
			if (strtoupper(substr($query,0,7))=='UPDATE ') return NULL;

			return sqlite_last_insert_rowid($db);
		}

		return NULL;
	}

	/**
	 * Get the rows returned from a SELECT query.
	 *
	 * @param  resource		The query result pointer
	 * @param  ?integer		Whether to start reading from (NULL: irrelevant for this forum driver)
	 * @return array			A list of row maps
	 */
	function db_get_query_rows($results,$start=NULL)
	{
		$out=array();
		while (($row=sqlite_fetch_array($results))!==false)
		{
			$out[]=$row;
		}
		return $out;
	}

}


