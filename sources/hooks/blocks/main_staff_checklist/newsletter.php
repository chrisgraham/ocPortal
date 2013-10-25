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
 * @package		newsletter
 */

class Hook_checklist_newsletter
{

	/**
	 * Standard modular run function.
	 *
	 * @return array		An array of tuples: The task row to show, the number of seconds until it is due (or NULL if not on a timer), the number of things to sort out (or NULL if not on a queue), The name of the config option that controls the schedule (or NULL if no option).
	 */
	function run()
	{
		if (!addon_installed('newsletter')) return array();

		if (get_option('news_update_time',true)=='') return array();
		$limit_hours=intval(get_option('news_update_time',true));

		$limit_hours=intval($limit_hours/3); // 3 news pieces (+ other stuff) per newsletter seems reasonable

		require_lang('newsletter');

		$date=get_value('newsletter_send_time');

		$seconds_ago=mixed();
		if (!is_null($date))
		{
			$seconds_ago=time()-intval($date);
			$status=($seconds_ago>$limit_hours*60*60)?0:1;
		} else
		{
			$status=0;
		}

		$_status=($status==0)?do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_0'):do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_1');

		require_code('config2');
		$config_url=config_option_url('news_update_time');

		$url=build_url(array('page'=>'admin_newsletter','type'=>'whatsnew'),'adminzone');
		list($info,$seconds_due_in)=staff_checklist_time_ago_and_due($seconds_ago,$limit_hours);
		$tpl=do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM',array('_GUID'=>'fb9483bb05ad90b9f2b7eba0c53996f4','CONFIG_URL'=>$config_url,'URL'=>$url,'STATUS'=>$_status,'TASK'=>do_lang_tempcode('NEWSLETTER_SEND'),'INFO'=>$info));
		return array(array($tpl,$seconds_due_in,NULL,'news_update_time'));
	}

}


