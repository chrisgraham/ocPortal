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
 * @package		content_reviews
 */

class Hook_checklist_content_reviews
{

	/**
	 * Standard modular run function.
	 *
	 * @return array		An array of tuples: The task row to show, the number of seconds until it is due (or NULL if not on a timer), the number of things to sort out (or NULL if not on a queue), The name of the config option that controls the schedule (or NULL if no option).
	 */
	function run()
	{
		$num_to_review=$GLOBALS['SITE_DB']->query_value_if_there('SELECT COUNT(*) FROM '.get_table_prefix().'content_reviews WHERE next_review_time<='.strval(time()));
		if ($num_to_review>=1)
		{
			$status=0;
		} else
		{
			$status=1;
		}
		require_lang('content_reviews');
		$_status=($status==0)?do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_0'):do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_1');
		$url=build_url(array('page'=>'admin_content_reviews'),'adminzone');
		$tpl=do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM',array('_GUID'=>'c00c54ed0e3095ff0b653a5799b7cd92','URL'=>'',
			'STATUS'=>$_status,
			'TASK'=>urlise_lang(do_lang('NAG_CONTENT_REVIEWS'),$url),
			'INFO'=>do_lang_tempcode('CONTENT_NEEDING_REVIEWING',integer_format($num_to_review)),
		));
		return array(array($tpl,NULL,$num_to_review,NULL));
	}

}


