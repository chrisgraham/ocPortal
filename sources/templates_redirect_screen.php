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
 * @package		core_abstract_interfaces
 */

/**
 * Redirect the user - transparently, storing a message that will be shown on their destination page.
 *
 * @param  tempcode		Title to display on redirect page
 * @param  mixed			Destination URL (may be Tempcode)
 * @param  ?mixed			Message to show (may be Tempcode) (NULL: standard redirection message)
 * @param  boolean		For intermediary hops, don't mark so as to read status messages - save them up for the next hop (which will not be intermediary)
 * @param  ID_TEXT		Code of message type to show
 * @set    warn inform fatal
 * @return tempcode		Redirection message (likely to not actually be seen due to instant redirection)
 */
function _redirect_screen($title,$url,$text,$intermediary_hop=false,$msg_type='inform')
{
	if (is_object($url)) $url=$url->evaluate();

	if (is_null($text)) $text=do_lang_tempcode('_REDIRECTING');

	global $FORCE_META_REFRESH,$ATTACHED_MESSAGES_RAW;
	$special_page_type=get_param('special_page_type','view');
	if (($special_page_type=='view') && (!headers_sent()) && (!$FORCE_META_REFRESH))
	{
		foreach ($ATTACHED_MESSAGES_RAW as $message)
		{
			$GLOBALS['SITE_DB']->query_insert('messages_to_render',array(
				'r_session_id'=>get_session_id(),
				'r_message'=>is_object($message[0])?$message[0]->evaluate():escape_html($message[0]),
				'r_type'=>$message[1],
				'r_time'=>time(),
			));
		}
		$_message=is_object($text)?$text->evaluate():escape_html($text);
		if ($_message!='' && $_message!=do_lang('_REDIRECTING'))
		{
			$GLOBALS['SITE_DB']->query_insert('messages_to_render',array(
				'r_session_id'=>get_session_id(),
				'r_message'=>$_message,
				'r_type'=>$msg_type,
				'r_time'=>time(),
			));
		}

		if (!$intermediary_hop)
		{
			$hash_pos=strpos($url,'#');
			if ($hash_pos!==false)
			{
				$hash_bit=substr($url,$hash_pos);
				$url=substr($url,0,$hash_pos);
			} else $hash_bit='';
			$url.=((strpos($url,'?')===false)?'?':'&').'redirected=1'.$hash_bit;
		}
	}

	require_code('site2');
	assign_refresh($url,0.0);
	return do_template('REDIRECT_SCREEN',array('_GUID'=>'44ce3d1ffc6536b299ed0944e8ca7253','URL'=>$url,'TITLE'=>$title,'TEXT'=>$text));
}
