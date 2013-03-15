<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/**
 * An option has dissappeared somehow - find it via searching our code-base for it's install code. It doesn't get returned, just loaded up. This function will produce a fatal error if we cannot find it.
 *
 * @param  ID_TEXT		The name of the value
 */
function find_lost_option($name)
{
	global $OPTIONS;

	// In the dark dark past, we'd bomb out...
	if ((function_exists('find_all_zones')) && (!defined('HIPHOP_PHP')))
	{
		// However times are pleasant, the grass is green, the sun high is the summer sky. Let's perform some voodoo magic...
		$all_zones=find_all_zones();
		$search=array();
		$types=array('modules_custom','modules');
		foreach ($all_zones as $zone)
		{
			foreach ($types as $type)
			{
				$pages=find_all_pages($zone,$type);
				foreach ($pages as $page=>$type2)
				{
					$search[]=zone_black_magic_filterer(get_file_base().'/'.$zone.(($zone!='')?'/':'').'pages/'.$type2.'/'.$page.'.php');
				}
			}
		}
		require_code('zones2');
		require_code('zones3');
		$all_blocks=find_all_blocks();
		foreach ($all_blocks as $block=>$type)
		{
			$search[]=get_file_base().'/'.$type.'/blocks/'.$block.'.php';
		}
		if (file_exists(get_file_base().'/sources_custom/ocf_install.php'))
			$search[]=get_file_base().'/sources_custom/ocf_install.php';
		$search[]=get_file_base().'/sources/ocf_install.php';

		$matches=array();
		foreach ($search as $s)
		{
//			echo $s.'<br />';
			$code=file_get_contents($s);
			if (preg_match('#add_config_option\(\'\w+\',\''.str_replace('#','\#',preg_quote($name)).'\',\'\w+\',\'.+\',\'\w+\',\'\w+\'(,1)?\);#',$code,$matches)>0)
			{
				require_code('database_action');
				$upgrade_from=NULL; // In case referenced in add_config_option line
				eval($matches[0]);

				load_options();
				break;
//				fatal_exit(do_ lang_tempcode('CONFIG_OPTION_FETCHED',escape_html($name)));	 CONFIG_OPTION_FETCHED=A config option ({1}) was missing, but has been hunted down and installed. This is an unexpected inconsistency, please refresh the page, and hopefully it has been permanently corrected.
			}
		}
	}
	if (!array_key_exists($name,$OPTIONS)) fatal_exit(do_lang_tempcode('_MISSING_OPTION',escape_html($name)));
}

/**
 * Set a configuration option with the specified values.
 *
 * @param  ID_TEXT		The name of the value
 * @param  LONG_TEXT		The value
 * @param  ?ID_TEXT		The type of the option. This is normally ommited, but to save a DB lookup, may be passed through (NULL: work out the type)
 * @set    float integer tick line text transline transtext list date forum category usergroup
 * @param  ?LONG_TEXT	The current value of the config option (NULL: unknown). This is just for efficiency for remapping language config options.
 */
function set_option($name,$value,$type=NULL,$current_value=NULL)
{
	global $OPTIONS;

	if (is_null($type))
	{
		global $GET_OPTION_LOOP;
		if ($GET_OPTION_LOOP!=1)
			get_option($name); // Ensure it's installed

		$type=$OPTIONS[$name]['the_type']; //$type=$GLOBALS['SITE_DB']->query_value('config','the_type',array('the_name'=>$name));
	}

	if (($type=='transline') || ($type=='transtext'))
	{
//		$current_value=$GLOBALS['SITE_DB']->query_value('config','config_value',array('the_name'=>$name));

		if ((array_key_exists('c_set',$OPTIONS[$name])) && ($OPTIONS[$name]['c_set']==0))
		{
			$GLOBALS['SITE_DB']->query_update('config',array('config_value'=>strval(insert_lang($value,1)),'c_set'=>1),array('the_name'=>$name),'',1);
		} else
		{
			$current_value=$OPTIONS[$name]['config_value'];
			if (!is_null($current_value)) // Should never happen, but might during upgrading
				lang_remap(intval($current_value),$value);
		}
	} else
	{
		$map=array('config_value'=>$value);
		if (array_key_exists('c_set',$OPTIONS[$name])) $map['c_set']=1;
		$GLOBALS['SITE_DB']->query_update('config',$map,array('the_name'=>$name),'',1);

		$OPTIONS[$name]['config_value']=$value;
	}

	$OPTIONS[$name]['config_value_translated']=$value;

	if (function_exists('log_it'))
	{
		require_lang('config');
		log_it('CONFIGURATION',$name,$value);
	}

	if (function_exists('persistent_cache_delete'))
		persistent_cache_delete('OPTIONS');
}
