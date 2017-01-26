<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/
/*EXTRA FUNCTIONS: pg\_.+*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_database_drivers
 */

/**
 * Standard code module initialisation function.
 */
function init__database__postgresql()
{
	global $CACHE_DB;
	$CACHE_DB=array();
}

class Database_Static_postgresql
{

	/**
	 * Get the default user for making db connections (used by the installer as a default).
	 *
	 * @return string			The default user for db connections
	 */
	function db_default_user()
	{
		return 'postgres';
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
		$_fields=preg_replace('#\(\d+\)#','',$_fields);
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
							'AUTO'=>'serial',
							'AUTO_LINK'=>'integer',
							'INTEGER'=>'integer',
							'UINTEGER'=>'bigint',
							'SHORT_INTEGER'=>'smallint',
							'REAL'=>'real',
							'BINARY'=>'smallint',
							'USER'=>'integer',
							'GROUP'=>'integer',
							'TIME'=>'bigint',
							'LONG_TRANS'=>'bigint',
							'SHORT_TRANS'=>'bigint',
							'SHORT_TEXT'=>'text',
							'LONG_TEXT'=>'text',
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
	 * Close the database connections. We don't really need to close them (will close at exit), just disassociate so we can refresh them.
	 */
	function db_close_connections()
	{
		global $CACHE_DB;
		$CACHE_DB=array();
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

		/*if (multi_lang()==0)
		{
			$type_remap['LONG_TRANS']=$type_remap['LONG_TEXT'];
			$type_remap['SHORT_TRANS']=$type_remap['SHORT_TEXT'];
		}*/

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
				$perhaps_null='NULL';
			} else $perhaps_null='NOT NULL';

			$type=$type_remap[$type];

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
	function db_drop_if_exists($table,$db)
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
		return false;
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
	 * Get a database connection. This function shouldn't be used by you, as a connection to the database is established automatically.
	 *
	 * @param  boolean		Whether to create a persistant connection
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
		global $CACHE_DB;
		if (isset($CACHE_DB[$db_name][$db_host]))
		{
			return $CACHE_DB[$db_name][$db_host];
		}

		if (!function_exists('pg_pconnect'))
		{
			$error='The postgreSQL PHP extension not installed (anymore?). You need to contact the system administrator of this server.';
			if ($fail_ok)
			{
				echo $error;
				return NULL;
			}
			critical_error('PASSON',$error);
		}

		$db=$persistent?@pg_pconnect('host='.$db_host.' dbname='.$db_name.' user='.$db_user.' password='.$db_password):@pg_connect('host='.$db_host.' dbname='.$db_name.' user='.$db_user.' password='.$db_password);
		if ($db===false)
		{
			$error='Could not connect to database-server ('.@pg_last_error().')';
			if ($fail_ok)
			{
				echo $error;
				return NULL;
			}
			critical_error('PASSON',$error); //warn_exit(do_lang_tempcode('CONNECT_DB_ERROR'));
		}

		if (!$db) fatal_exit(do_lang('CONNECT_DB_ERROR'));
		$CACHE_DB[$db_name][$db_host]=$db;
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
		return pg_escape_string($string);
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
		if (strtoupper(substr($query,0,7))=='SELECT ')
		{
			if ((!is_null($max)) && (!is_null($start))) $query.=' LIMIT '.strval(intval($max)).' OFFSET '.strval(intval($start));
			elseif (!is_null($max)) $query.=' LIMIT '.strval(intval($max));
			elseif (!is_null($start)) $query.=' OFFSET '.strval(intval($start));
		}

		$results=@pg_query($db,$query);
		if ((($results===false) || ((strtoupper(substr($query,0,7))=='SELECT ') && ($results===true))) && (!$fail_ok))
		{
			$err=pg_last_error($db);
			if (function_exists('ocp_mark_as_escaped')) ocp_mark_as_escaped($err);
			if ((!running_script('upgrader')) && (get_page_name()!='admin_import'))
			{
				if (!function_exists('do_lang') || is_null(do_lang('QUERY_FAILED',NULL,NULL,NULL,NULL,false))) fatal_exit(htmlentities('Query failed: '.$query.' : '.$err));

				fatal_exit(do_lang_tempcode('QUERY_FAILED',escape_html($query),($err)));
			} else
			{
				echo htmlentities('Database query failed: '.$query.' [').($err).htmlentities(']'.'<br />'.chr(10));
				return NULL;
			}
		}

		if ((strtoupper(substr($query,0,7))=='SELECT ') && ($results!==false) && ($results!==true))
		{
			return $this->db_get_query_rows($results);
		}

		if ($get_insert_id)
		{
			if (strtoupper(substr($query,0,7))=='UPDATE ') return NULL;

			// Inefficient :(
			$pos=strpos($query,'(');
			$table_name=substr($query,12,$pos-13);

			$r3=@pg_query($db,'SELECT last_value FROM '.$table_name.'_id_seq');
			if ($r3)
			{
				$seq_array=pg_fetch_row($r3,0);
				return intval($seq_array[0]);
			}
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
		$num_fields=pg_num_fields($results);
		$types=array();
		$names=array();
		for ($x=1;$x<=$num_fields;$x++)
		{
			$types[$x-1]=pg_field_type($results,$x-1);
			$names[$x-1]=strtolower(pg_field_name($results,$x-1));
		}

		$out=array();
		$i=0;
		while (($row=pg_fetch_row($results))!==false)
		{
			$j=0;
			$newrow=array();
			foreach ($row as $v)
			{
				$name=$names[$j];
				$type=strtoupper($types[$j]);

				if ((substr($type,0,3)=='INT') || ($type=='SMALLINT') || ($type=='SERIAL') || ($type=='UINTEGER'))
				{
					if (!is_null($v)) $newrow[$name]=intval($v); else $newrow[$name]=NULL;
				} else $newrow[$name]=$v;

				$j++;
			}

			$out[]=$newrow;

			$i++;
		}
		pg_free_result($results);
		return $out;
	}

}


