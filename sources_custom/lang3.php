<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('parse_translated_text'))
{
	/**
	 * get_translated_tempcode was asked for a lang entry that had not been parsed into Tempcode yet.
	 *
	 * @param  integer			The id
	 * @param  ?object			The database connection to use (NULL: standard site connection)
	 * @param  ?LANGUAGE_NAME	The language (NULL: uses the current language)
	 * @param  boolean			Whether to force it to the specified language
	 * @param  boolean			Whether to force as_admin, even if the lang string isn't stored against an admin (designed for comcode page cacheing)
	 * @return ?tempcode			The parsed comcode (NULL: the text couldn't be looked up)
	 */
	function parse_translated_text($entry,$connection,$lang,$force,$as_admin)
	{
		global $SEARCH__CONTENT_BITS;
		global $LAX_COMCODE;

		$nql_backup=$GLOBALS['NO_QUERY_LIMIT'];
		$GLOBALS['NO_QUERY_LIMIT']=true;

		$result=$connection->query_select('translate',array('text_original','source_user'),array('id'=>$entry,'language'=>$lang),'',1);
		$result=array_key_exists(0,$result)?$result[0]:NULL;

		if (is_null($result))
		{
			if ($force)
			{
				$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
				return NULL;
			}

			$result=$connection->query_value_null_ok('translate','text_parsed',array('id'=>$entry,'language'=>get_site_default_lang()));
			if (is_null($result)) $result=$connection->query_value_null_ok('translate','text_parsed',array('id'=>$entry));

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
				_lang_remap($entry,is_null($result)?'':$result['text_original'],$connection,true,NULL,$result['source_user'],$as_admin,false,true);
				if (!is_null($SEARCH__CONTENT_BITS))
				{
					$ret=comcode_to_tempcode($result['text_original'],$result['source_user'],$as_admin,60,NULL,$connection,false,false,false,false,false,$SEARCH__CONTENT_BITS);
					$LAX_COMCODE=$temp;
					$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
					return $ret;
				}
				$LAX_COMCODE=$temp;
				$ret=get_translated_tempcode($entry,$connection,$lang);
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

			global $LAX_COMCODE;
			$temp=$LAX_COMCODE;
			$LAX_COMCODE=true;
			_lang_remap($entry,$result['text_original'],$connection,true,NULL,$result['source_user'],$as_admin,false,true);
			if (!is_null($SEARCH__CONTENT_BITS))
			{
				$ret=comcode_to_tempcode($result['text_original'],$result['source_user'],$as_admin,60,NULL,$connection,false,false,false,false,false,$SEARCH__CONTENT_BITS);
				$LAX_COMCODE=$temp;
				$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
				return $ret;
			}
			$LAX_COMCODE=$temp;
			$ret=get_translated_tempcode($entry,$connection,$lang);
			$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;
			return $ret;
		}
	}
}
