<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('parse_translated_text'))
{
	/**
	 * get_translated_tempcode was asked for a lang entry that had not been parsed into Tempcode yet.
	 *
	 * @param  ID_TEXT			The table name
	 * @param  array				The database row
	 * @param  ID_TEXT			The field name
	 * @param  ?object			The database connection to use (NULL: standard site connection)
	 * @param  ?LANGUAGE_NAME	The language (NULL: uses the current language)
	 * @param  boolean			Whether to force it to the specified language
	 * @param  boolean			Whether to force as_admin, even if the lang string isn't stored against an admin (designed for Comcode page cacheing)
	 * @return ?tempcode			The parsed Comcode (NULL: the text couldn't be looked up)
	 */
	function parse_translated_text($table,&$row,$field_name,$connection,$lang,$force,$as_admin)
	{
		global $SEARCH__CONTENT_BITS;
		global $LAX_COMCODE;

		$nql_backup=$GLOBALS['NO_QUERY_LIMIT'];
		$GLOBALS['NO_QUERY_LIMIT']=true;

		$entry=$row[$field_name];

		$result=mixed();
		if (multi_lang_content())
		{
			$_result=$connection->query_select('translate',array('text_original','source_user'),array('id'=>$entry,'language'=>$lang),'',1);
			if (array_key_exists(0,$_result)) $result=$_result[0];
		}

		if ((is_null($result)) && (multi_lang_content())) // A missing translation
		{
			if ($force)
			{
				$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
				return NULL;
			}

			$result=$connection->query_select_value_if_there('translate','text_parsed',array('id'=>$entry,'language'=>get_site_default_lang()));
			if (is_null($result)) $result=$connection->query_select_value_if_there('translate','text_parsed',array('id'=>$entry));

			if ((is_null($result)) || ($result==''))
			{
				load_user_stuff();
				require_code('comcode'); // might not have been loaded for a quick-boot
				require_code('permissions');

				$result=$connection->query_select('translate',array('text_original','source_user'),array('id'=>$entry,'language'=>get_site_default_lang()),'',1);
				if (!array_key_exists(0,$result))
				{
					$result=$connection->query_select('translate',array('text_original','source_user'),array('id'=>$entry),'',1);
				}
				$result=array_key_exists(0,$result)?$result[0]:NULL;
				if (!is_null($result))
				{
					$result['text_original']=google_translate($result['text_original'],$lang);
					$result['text_parsed']='';
				}

				$temp=$LAX_COMCODE;
				$LAX_COMCODE=true;
				_lang_remap($field_name,$entry,is_null($result)?'':$result['text_original'],$connection,true,NULL,$result['source_user'],$as_admin,false,true);
				if (!is_null($SEARCH__CONTENT_BITS))
				{
					$ret=comcode_to_tempcode($result['text_original'],$result['source_user'],$as_admin,60,NULL,$connection,false,false,false,false,false,$SEARCH__CONTENT_BITS);
					$LAX_COMCODE=$temp;
					$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
					return $ret;
				}
				$LAX_COMCODE=$temp;
				$ret=get_translated_tempcode($table,$row,$field_name,$connection,$lang);
				$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
				return $ret;
			}

			$connection->text_lookup_cache[$entry]=new ocp_tempcode();
			$connection->text_lookup_cache[$entry]->from_assembly($result);

			$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
			return $connection->text_lookup_cache[$entry];
		} else
		{
			load_user_stuff();
			require_code('comcode'); // might not have been loaded for a quick-boot
			require_code('permissions');

			$temp=$LAX_COMCODE;
			$LAX_COMCODE=true;

			if (multi_lang_content())
			{
				_lang_remap($field_name,$entry,$result['text_original'],$connection,true,NULL,$result['source_user'],$as_admin,false,true);

				if (!is_null($SEARCH__CONTENT_BITS))
				{
					$ret=comcode_to_tempcode($result['text_original'],$result['source_user'],$as_admin,60,NULL,$connection,false,false,false,false,false,$SEARCH__CONTENT_BITS);
					$LAX_COMCODE=$temp;
					$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
					return $ret;
				}
			} else
			{
				$map=_lang_remap($field_name,$entry,$row[$field_name],$connection,true,NULL,$row[$field_name.'__source_user'],$as_admin,false,true);

				$connection->query_update($table,$map,$row,'',1);
				$row=$map+$row;

				if (!is_null($SEARCH__CONTENT_BITS))
				{
					$ret=comcode_to_tempcode($row[$field_name],$row[$field_name.'__source_user'],$as_admin,60,NULL,$connection,false,false,false,false,false,$SEARCH__CONTENT_BITS);
					$LAX_COMCODE=$temp;
					$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
					return $ret;
				}
			}

			$LAX_COMCODE=$temp;
			$ret=get_translated_tempcode($table,$row,$field_name,$connection,$lang);
			$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
			return $ret;
		}
	}
}
