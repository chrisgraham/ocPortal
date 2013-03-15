<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unvalidated
 */

/**
 * Module page class.
 */
class Module_admin_unvalidated
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('!'=>'UNVALIDATED_RESOURCES');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_lang('unvalidated');

		$GLOBALS['HELPER_PANEL_PIC']='pagepics/unvalidated';
		$GLOBALS['HELPER_PANEL_TUTORIAL']='tut_censor';

		$_title=get_screen_title('UNVALIDATED_RESOURCES');

		$out=new ocp_tempcode();
		require_code('form_templates');

		$_hooks=find_all_hooks('modules','admin_unvalidated');
		foreach (array_keys($_hooks) as $hook)
		{
			require_code('hooks/modules/admin_unvalidated/'.filter_naughty_harsh($hook));
			$object=object_factory('Hook_unvalidated_'.filter_naughty_harsh($hook),true);
			if (is_null($object)) continue;
			$info=$object->info();
			if (is_null($info)) continue;

			$identifier_select=is_array($info['db_identifier'])?implode(',',$info['db_identifier']):$info['db_identifier'];
			$db=array_key_exists('db',$info)?$info['db']:$GLOBALS['SITE_DB'];
			$rows=$db->query('SELECT '.$identifier_select.(array_key_exists('db_title',$info)?(','.$info['db_title']):'').' FROM '.$db->get_table_prefix().$info['db_table'].' WHERE '.$info['db_validated'].'=0',100);
			$content=new ocp_tempcode();
			foreach ($rows as $row)
			{
				if (is_array($info['db_identifier']))
				{
					$id='';
					foreach ($info['db_identifier'] as $_id)
					{
						if ($id!='') $id.=':';
						$id.=$row[$_id];
					}
				} else
				{
					$id=$row[$info['db_identifier']];
				}
				if (array_key_exists('db_title',$info))
				{
					$title=$row[$info['db_title']];
					if ($info['db_title_dereference']) $title=get_translated_text($title,$db); // May actually be comcode (can't be certain), but in which case it will be shown as source
				} else $title='#'.(is_integer($id)?strval($id):$id);
				if ($title=='') $title='#'.strval($id);
				$content->attach(form_input_list_entry(is_integer($id)?strval($id):$id,false,strip_comcode($title)));
			}

			if (array_key_exists('uses_workflow',$info) && $info['uses_workflow'])
			{
				// Content that uses a workflow is validated via its view screen
				$post_url=build_url(array('page'=>$info['view_module'],'type'=>$info['view_type'],'validated'=>1/*,'redirect'=>get_self_url(true)*/),get_module_zone($info['view_module']),NULL,false,true);
			} else
			{
				// Content which isn't in a workflow is validated via its edit screen
				$post_url=build_url(array('page'=>$info['edit_module'],'type'=>$info['edit_type'],'validated'=>1/*,'redirect'=>get_self_url(true)*/),get_module_zone($info['edit_module']),NULL,false,true);
			}
			$fields=form_input_list(do_lang_tempcode('EDIT'),do_lang_tempcode('DESCRIPTION_EDIT'),$info['edit_identifier'],$content);

			if (!$content->is_empty())
			{
				// Could debate whether to include "'TARGET'=>'_blank',". However it does redirect back, so it's a nice linear process like this. If it was new window it could be more efficient, but also would confuse people with a lot of new windows opening and not closing.
				$content=do_template('FORM',array('_GUID'=>'0abb28f6b8543396c90c8c4395b7e7d4','GET'=>true,'HIDDEN'=>'','SUBMIT_NAME'=>do_lang_tempcode('EDIT'),'FIELDS'=>$fields,'URL'=>$post_url,'TEXT'=>''));
			}

			$out->attach(do_template('UNVALIDATED_SECTION',array('_GUID'=>'044f99ca3c101f90b35fc4b64977b1c7','TITLE'=>$info['title'],'CONTENT'=>$content)));
		}

		return do_template('UNVALIDATED_SCREEN',array('_GUID'=>'fd41829ff0848f23d1f428a840eeb72a','TITLE'=>$_title,'SECTIONS'=>$out));
	}

}


