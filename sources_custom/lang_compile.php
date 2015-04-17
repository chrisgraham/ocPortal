<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

if (!function_exists('init__lang_compile'))
{
	/**
	 * Standard code module initialisation function.
	 */
	function init__lang_compile()
	{
		global $DECACHED_COMCODE_LANG_STRINGS;
		$DECACHED_COMCODE_LANG_STRINGS=false;
	}
}

if (!function_exists('require_lang_compile'))
{
	/**
	 * Load up a language file, compiling it (it's not cached yet).
	 *
	 * @param  ID_TEXT			The language file name
	 * @param  ?LANGUAGE_NAME	The language (NULL: uses the current language)
	 * @param  ?string			The language type (lang_custom, or custom) (NULL: normal priorities are used)
	 * @set    lang_custom custom
	 * @param  PATH				Where we are cacheing too
	 * @param  boolean			Whether to just return if there was a loading error
	 * @return boolean			Whether we FAILED to load
	 */
	function require_lang_compile($codename,$lang,$type,$cache_path,$ignore_errors=false)
	{
		global $LANGUAGE,$REQUIRE_LANG_LOOP,$LANG_LOADED_LANG;

		$desire_cache=(function_exists('get_option')) && ((get_option('is_on_lang_cache',true)=='1') || (get_param_integer('keep_cache',0)==1) || (get_param_integer('cache',0)==1)) && (get_param_integer('keep_cache',NULL)!==0) && (get_param_integer('cache',NULL)!==0);
		if ($desire_cache)
		{
			if ($GLOBALS['IN_MINIKERNEL_VERSION']==0)
			{
				global $DECACHED_COMCODE_LANG_STRINGS;

				// Cleanup language strings
				if (!$DECACHED_COMCODE_LANG_STRINGS)
				{
					$DECACHED_COMCODE_LANG_STRINGS=true;
					$comcode_lang_strings=$GLOBALS['SITE_DB']->query_select('cached_comcode_pages',array('string_index'),array('the_zone'=>'!'),'',NULL,NULL,true);
					if (!is_null($comcode_lang_strings))
					{
						$GLOBALS['SITE_DB']->query_delete('cached_comcode_pages',array('the_zone'=>'!'));
						foreach ($comcode_lang_strings as $comcode_lang_string)
						{
							delete_lang($comcode_lang_string['string_index']);
						}
					}
				}
			}

			$load_target=array();
		} else
		{
			$load_target=&$LANGUAGE[$lang];
		}

		global $FILE_ARRAY;
		if ((@is_array($FILE_ARRAY)) && (file_array_exists('lang/'.$lang.'/'.$codename.'.ini')))
		{
			$lang_file='lang/'.$lang.'/'.$codename.'.ini';
			$file=file_array_get($lang_file);
			_get_lang_file_map($file,$load_target,NULL,true);
			$bad=true;
		}
		else
		{
			$bad=true;
			$dirty=false;

			// Load originals
			$lang_file=get_file_base().'/lang/'.$lang.'/'.filter_naughty($codename).'.ini';
			if (file_exists($lang_file)) // Non-custom, Proper language
			{
				_get_lang_file_map($lang_file,$load_target,NULL,false);
				$bad=false;
			}

			// Load overrides now if they are there
			if ($type!='lang')
			{
				$lang_file=get_custom_file_base().'/lang_custom/'.$lang.'/'.$codename.'.ini';
				if ((!file_exists($lang_file)) && (get_file_base()!=get_custom_file_base())) $lang_file=get_file_base().'/lang_custom/'.$lang.'/'.$codename.'.ini';
				if (!file_exists($lang_file))
				{
					$lang_file=get_custom_file_base().'/lang_custom/'.$lang.'/'.$codename.'.po';
					if (!file_exists($lang_file))
						$lang_file=get_file_base().'/lang_custom/'.$lang.'/'.$codename.'-'.strtolower($lang).'.po';
				}
			}
			if (($type!='lang') && (file_exists($lang_file)))
			{
				_get_lang_file_map($lang_file,$load_target,NULL,false);
				$bad=false;
				$dirty=true; // Tainted from the official pack, so can't store server wide
			}

			// NB: Merge op doesn't happen in require_lang. It happens when do_lang fails and then decides it has to force a recursion to do_lang(xx,fallback_lang()) which triggers require_lang(xx,fallback_lang()) when it sees it's not loaded

			if (($bad) && ($lang!=fallback_lang())) // Still some hope
			{
				require_lang($codename,fallback_lang(),$type,$ignore_errors);
				$REQUIRE_LANG_LOOP--;
				$fallback_cache_path=get_custom_file_base().'/lang_cached/'.fallback_lang().'/'.$codename.'.lcd';
				if (file_exists($fallback_cache_path))
				{
					require_code('files');
					$fallback_map=unserialize(file_get_contents($fallback_cache_path));
					$sep='<span class="notranslate">----</span>';
					$to_translate='';
					$i=0;
					$from=0;
					$lang_codes=array_keys($fallback_map);
					foreach ($fallback_map as $value)
					{
						if (strlen($to_translate.$sep.$to_translate)>=3000)
						{
							$translated=preg_split('#<span class="notranslate">[^<>]*----[^<>]*</span>#',google_translate($to_translate,$lang));
							foreach ($translated as $j=>$t_value)
							{
								if (strtolower($lang_codes[$from+$j])==$lang_codes[$from+$j]) $t_value=$fallback_map[$lang_codes[$from+$j]];
								if ($lang_codes[$from+$j]=='locale') $t_value=strtolower($lang).'_'.strtoupper($lang);

								$fallback_map[$lang_codes[$from+$j]]=$t_value;
								$load_target[$lang_codes[$from+$j]]=$t_value;
							}
							$from=$i;
							$to_translate='';
						}

						if ($to_translate!='') $to_translate.=$sep;
						$to_translate.=$value;

						$i++;
					}
					$translated=preg_split('#<span class="notranslate">[^<>]*----[^<>]*</span>#',google_translate($to_translate,$lang));

					foreach ($translated as $j=>$t_value)
					{
						if (strtolower($lang_codes[$from+$j])==$lang_codes[$from+$j]) $t_value=$fallback_map[$lang_codes[$from+$j]];
						if ($lang_codes[$from+$j]=='locale') $t_value=strtolower($lang).'_'.strtoupper($lang);

						$fallback_map[$lang_codes[$from+$j]]=$t_value;
						$load_target[$lang_codes[$from+$j]]=$t_value;
					}

					if ((function_exists('ocp_mb_substr')) && ($codename=='dates'))
					{
						foreach (array_keys($fallback_map) as $key)
						{
							if (substr($key,0,3)=='FC_')
							{
								$test=ocp_mb_substr(trim($fallback_map[substr($key,3)]),0,1,true);
								if ($test!==false)
									$fallback_map[$key]=$test;
							}
						}
					}

					$myfile=fopen($cache_path,'wb');
					fwrite($myfile,serialize($fallback_map));
					fclose($myfile);
					fix_permissions($cache_path);
				}

				if (!array_key_exists($lang,$LANG_LOADED_LANG)) $LANG_LOADED_LANG[$lang]=array();
				$LANG_LOADED_LANG[$lang][$codename]=1;
				if (!$bad) $LANGUAGE[$lang]+=$fallback_map;

				return $bad;
			}

			if ($bad) // Out of hope
			{
				if ($ignore_errors) return true;

				if (($codename!='critical_error') || ($lang!=get_site_default_lang()))
				{
					$error_msg=do_lang_tempcode('MISSING_LANG_FILE',escape_html($codename),escape_html($lang));
					if (get_page_name()=='admin_themes')
					{
						warn_exit($error_msg);
					} else
					{
						fatal_exit($error_msg);
					}
				} else
				{
					critical_error('CRIT_LANG');
				}
			}
		}

		if (is_null($GLOBALS['MEM_CACHE']))
		{
			// Cache
			if ($desire_cache)
			{
				$file=@fopen($cache_path,'at'); // Will fail if cache dir missing .. e.g. in quick installer
				if ($file)
				{
					flock($file,LOCK_EX);
					ftruncate($file,0);
					if (fwrite($file,serialize($load_target))>0)
					{
						// Success
						flock($file,LOCK_UN);
						fclose($file);
						require_code('files');
						fix_permissions($cache_path);
					} else
					{
						// Failure
						flock($file,LOCK_UN);
						fclose($file);
						@unlink($cache_path);
					}
				}
			}
		} else
		{
			persistent_cache_set(array('LANG',$lang,$codename),$load_target,!$dirty);
		}

		if ($desire_cache) $LANGUAGE[$lang]+=$load_target;

		return $bad;
	}
}
