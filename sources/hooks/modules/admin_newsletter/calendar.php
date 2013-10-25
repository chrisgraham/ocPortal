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
 * @package		calendar
 */

class Hook_whats_news_calendar
{

	/**
	 * Standard modular run function for newsletter hooks.
	 *
	 * @return ?array				Tuple of result details: HTML list of all types that can be choosed, title for selection list (NULL: disabled)
	 */
	function choose_categories()
	{
		if (!addon_installed('calendar')) return NULL;

		require_lang('calendar');

		require_code('calendar');
		return array(nice_get_event_types(),do_lang('CALENDAR'));
	}

	/**
	 * Standard modular run function for newsletter hooks.
	 *
	 * @param  TIME				The time that the entries found must be newer than
	 * @param  LANGUAGE_NAME	The language the entries found must be in
	 * @param  string				Category filter to apply
	 * @return array				Tuple of result details
	 */
	function run($cutoff_time,$lang,$filter)
	{
		if (!addon_installed('calendar')) return array();

		require_lang('calendar');

		$max=intval(get_option('max_newsletter_whatsnew'));

		$new=new ocp_tempcode();

		require_code('ocfiltering');
		$or_list=ocfilter_to_sqlfragment($filter,'e_type');

		$privacy_join='';
		$privacy_where='';
		if (addon_installed('content_privacy'))
		{
			require_code('content_privacy');
			list($privacy_join,$privacy_where)=get_privacy_where_clause('event','e',$GLOBALS['FORUM_DRIVER']->get_guest_id());
		}

		$rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'calendar_events e '.$privacy_where.' WHERE e_add_date>'.strval($cutoff_time).' AND e_member_calendar IS NULL AND ('.$or_list.')'.$privacy_where.' ORDER BY e_add_date DESC',$max);
		if (count($rows)==$max) return array();

		foreach ($rows as $row)
		{
			$id=$row['id'];
			$_url=build_url(array('page'=>'calendar','type'=>'view','id'=>$row['id']),get_module_zone('calendar'),NULL,false,false,true);
			$url=$_url->evaluate();
			$name=get_translated_text($row['e_title'],NULL,$lang);
			$description=get_translated_text($row['e_content'],NULL,$lang);
			$member_id=(is_guest($row['e_submitter']))?NULL:strval($row['e_submitter']);
			$new->attach(do_template('NEWSLETTER_NEW_RESOURCE_FCOMCODE',array('_GUID'=>'654cafa75ec9f9b8e0e0fb666f28fb37','MEMBER_ID'=>$member_id,'URL'=>$url,'NAME'=>$name,'DESCRIPTION'=>$description,'CONTENT_TYPE'=>'event','CONTENT_ID'=>strval($id))));
		}

		return array($new,do_lang('CALENDAR','','','',$lang));
	}

}


