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
 * @package		unvalidated
 */

class Hook_checklist_unvalidated
{

	/**
	 * Standard modular run function.
	 *
	 * @return array		An array of tuples: The task row to show, the number of seconds until it is due (or NULL if not on a timer), the number of things to sort out (or NULL if not on a queue), The name of the config option that controls the schedule (or NULL if no option).
	 */
	function run()
	{
		// Validate/delete submissions
		list($num_unvalidated_1,$num_unvalidated_2)=$this->get_num_unvalidated();
		if ($num_unvalidated_1>=1)
		{
			$status=0;
		} else
		{
			$status=1;
		}
		$_status=($status==0)?do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_0'):do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_1');
		$_url=build_url(array('page'=>'admin_unvalidated'),'adminzone');
		$url=escape_html_tempcode($_url);
		$tpl=do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM',array('_GUID'=>'48f2bc149dca356c8b6bd87092f70d3c','URL'=>'','STATUS'=>$_status,'TASK'=>urlise_lang(do_lang('NAG_VALIDATE'),$url),'INFO'=>do_lang_tempcode('UNVALIDATED_ENTRIES',integer_format($num_unvalidated_1),integer_format($num_unvalidated_2))));
		return array(array($tpl,NULL,$num_unvalidated_1,NULL));
	}

	/**
	 * Get the number of unvalidated items.
	 *
	 * @return array		A pair: Number of major things, number of minor things
	 */
	function get_num_unvalidated()
	{
		$sum=0;
		$sum2=0;

		$_hooks=find_all_hooks('modules','admin_unvalidated');
		foreach (array_keys($_hooks) as $hook)
		{
			require_code('hooks/modules/admin_unvalidated/'.filter_naughty_harsh($hook));
			$object=object_factory('Hook_unvalidated_'.filter_naughty_harsh($hook),true);
			if (is_null($object)) continue;
			$info=$object->info();
			if (is_null($info)) continue;
			$db=array_key_exists('db',$info)?$info['db']:$GLOBALS['SITE_DB'];
			$amount=$db->query_value($info['db_table'],'COUNT(*)',array($info['db_validated']=>0));
			if ((is_null($info)) || ((array_key_exists('is_minor',$info)) && ($info['is_minor']))) $sum2+=$amount; else $sum+=$amount;
		}

		return array($sum,$sum2);
	}

}


