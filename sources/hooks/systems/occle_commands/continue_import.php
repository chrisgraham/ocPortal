<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		import
 */

class Hook_occle_command_continue_import
{
	/**
	 * Standard modular run function for OcCLE hooks.
	 *
	 * @param  array	The options with which the command was called
	 * @param  array	The parameters with which the command was called
	 * @param  object A reference to the OcCLE filesystem object
	 * @return array	Array of stdcommand, stdhtml, stdout, and stderr responses
	 */
	function run($options,$parameters,&$occle_fs)
	{
		require_lang('import');

		if ((array_key_exists('h',$options)) || (!array_key_exists(0,$parameters)) || (array_key_exists('help',$options))) return array('',do_command_help('continue_import',array('h'),array(true,true)),'','');
		else
		{
			require_code('import');

			disable_php_memory_limit();
			set_database_index_maintenance(true);
			set_mass_import_mode();

			$where=mixed();
			if (array_key_exists(1,$parameters))
				$where=array('imp_session'=>$parameters[1]);
			$session=$GLOBALS['SITE_DB']->query_select('import_session',array('*'),$where,'',2);
			if (!array_key_exists(0,$session))
			{
				warn_exit(do_lang_tempcode('MISSING_IMPORT_SESSION'));
			}
			if (array_key_exists(1,$session))
			{
				warn_exit(do_lang_tempcode('TOO_MANY_IMPORT_SESSIONS'));
			}

			set_session_id($session[0]['imp_session']);

			$importer=$session[0]['imp_hook'];
			$old_base_dir=$session[0]['imp_old_base_dir'];
			$db_name=$session[0]['imp_db_name'];
			$db_user=$session[0]['imp_db_user'];
			$db_password=$parameters[0];
			$db_table_prefix=$session[0]['imp_db_table_prefix'];
			$db_host=$session[0]['imp_db_host'];

			load_import_deps();

			require_code('hooks/modules/admin_import/'.filter_naughty_harsh($importer));
			$object=object_factory('Hook_'.filter_naughty_harsh($importer));

			$import_source=is_null($db_name)?NULL:new database_driver($db_name,$db_host,$db_user,$db_password,$db_table_prefix);

			if (get_forum_type()!='ocf')
			{
				require_code('forum/ocf');
				$GLOBALS['OCF_DRIVER']=new forum_driver_ocf();
				$GLOBALS['OCF_DRIVER']->connection=$GLOBALS['SITE_DB'];
				$GLOBALS['OCF_DRIVER']->MEMBER_ROWS_CACHED=array();
			}

			$info=$object->info();
			$_import_list=$info['import'];
			foreach ($_import_list as $import)
			{
				if (is_null($GLOBALS['SITE_DB']->query_select_value_if_there('import_parts_done','imp_session',array('imp_id'=>$import,'imp_session'=>get_session_id()))))
				{
					$function_name='import_'.$import;
					ocf_over_local();
					$func_output=call_user_func_array(array($object,$function_name),array($import_source,$db_table_prefix,$old_base_dir));
					ocf_over_msn();

					$GLOBALS['SITE_DB']->query_insert('import_parts_done',array('imp_id'=>$import,'imp_session'=>get_session_id()));
				}
			}

			log_it('IMPORT');
			post_import_cleanup();
			set_database_index_maintenance(true);
		}

		return array('','',do_lang('SUCCESS'),'');
	}

}

