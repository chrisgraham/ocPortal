<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_rich_media
 */

/**
 * Dispatch any pending member mention notifications ("mentions").
 *
 * @param  ID_TEXT		The content type
 * @param  ID_TEXT		The content ID
 * @param  ?MEMBER		The content submitter (NULL: current user)
 */
function dispatch_member_mention_notifications($content_type,$content_id,$submitter=NULL)
{
	global $MEMBER_MENTIONS_IN_COMCODE;
	if (count($MEMBER_MENTIONS_IN_COMCODE)==0) return;

	if (is_null($submitter)) $submitter=get_member();
	$poster_username=$GLOBALS['FORUM_DRIVER']->get_username($submitter);

	require_all_lang(); // TODO: Not in v10

	require_code('notifications');
	require_code('content');
	require_code('feedback');

	foreach (array_unique($MEMBER_MENTIONS_IN_COMCODE) as $member_id)
	{
		if (!may_view_content_behind($member_id,$content_type,$content_id)) continue;

		require_code('hooks/systems/content_meta_aware/'.$content_type);
		$cma_ob=object_factory('Hook_content_meta_aware_'.$content_type);
		$info=$cma_ob->info();
		list($content_title,$submitter_id,$cma_info,,,$content_url_email_safe)=content_get_details($content_type,$content_id);

		if (is_null($content_title)) continue;

		$content_type_label=do_lang($cma_info['content_type_label']);

		// TODO: v10 needs raw username AND display name

		$subject=do_lang('NOTIFICATION_MEMBER_MENTION_SUBJECT',$poster_username,strtolower($content_type_label),array($content_title,$content_url_email_safe->evaluate(),$content_type_label));
		$message=do_lang('NOTIFICATION_MEMBER_MENTION_BODY',comcode_escape($poster_username),comcode_escape(strtolower($content_type_label)),array(comcode_escape($content_title),$content_url_email_safe->evaluate(),comcode_escape($content_type_label)));

		dispatch_notification('member_mention','',$subject,$message,array($member_id),get_member());
	}

	$MEMBER_MENTIONS_IN_COMCODE=array(); // Reset
}
