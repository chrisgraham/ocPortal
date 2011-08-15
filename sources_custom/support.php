<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2010

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/*
support.php contains further support functions, which are shared between the installer and the main installation (i.e. global.php and global2.php are not used by the installer, and the installer emulates these functions functionality via minikernel.php).
*/

/**
 * Used to log activities
 *
 * @param  string		Language string code
 * @param  string		Label 1
 * @param  string		Label 2
 * @param  string		Label 3
 * @param  string		Page link 1
 * @param  string		Page link 2
 * @param  string		Page link 3
 * @param  string		Addon that caused the event
 * @param  BINARY		Whether this post should be public or friends-only
 * @return AUTO_LINK	ID of the row in the main_activities table
 */
function say_activity($a_language_string_code='',$a_label_1='',$a_label_2='',$a_label_3='',$a_pagelink_1='',$a_pagelink_2='',$a_pagelink_3='',$a_addon='', $a_is_public=0)
{
	require_code('main_activities_submission');

	if ((get_db_type()=='xml') && (get_param_integer('keep_testing_logging',0)!=1)) return;

	$stored_id=0;
	$a_member_id=get_member();

	$go=array(
		'a_language_string_code'=>$a_language_string_code,
		'a_label_1'=>$a_label_1,
		'a_label_2'=>$a_label_2,
		'a_label_3'=>$a_label_3,
		'a_is_public'=>$a_is_public
	);

	// Check if this has been posted previously (within the last 10 minutes) to
	// stop spamming but allow generalised repeat status messages.
	$test=$GLOBALS['SITE_DB']->query_select('main_activities',array('a_language_string_code','a_label_1','a_label_2','a_label_3','a_is_public'),NULL,'WHERE a_time>'.(time()-600),1);
	if ((!array_key_exists(0,$test)) || ($test[0]!=$go))
	{
		// Log the activity
		$row=$go+array(
			'a_member_id'=>$a_member_id,
			'a_pagelink_1'=>$a_pagelink_1,
			'a_pagelink_2'=>$a_pagelink_2,
			'a_pagelink_3'=>$a_pagelink_3,
			'a_time'=>time(),
			'a_addon'=>$a_addon,
			'a_is_public'=>$a_is_public
		);
		$stored_id=$GLOBALS['SITE_DB']->query_insert('main_activities',$row,true);

		// Update the latest activity file
		log_newest_activity($stored_id,1000);
		
		// Facebook integration
		if ((addon_installed('facebook')) && (is_file(get_file_base().'/sources_custom/facebook_connect.php')) && ($a_is_public==1))
		{
			require_code('facebook_publish');
			require_code('facebook_connect');
			$cookie=get_facebook_cookie();
			if (!is_null($cookie)) // Logged into Facebook
			{
				require_lang('main_activities');
				
				$guest_id=intval($GLOBALS['FORUM_DRIVER']->get_guest_id());
				$link_1=($row['a_pagelink_1']=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_1'],true);
				$link_2=($row['a_pagelink_2']=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_2'],true);
				$link_3=($row['a_pagelink_3']=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_3'],true);
				$tempcode=do_lang_tempcode($row['a_language_string_code'],comcode_to_tempcode(escape_html($row['a_label_1']),$guest_id,false,NULL),comcode_to_tempcode(escape_html($row['a_label_2']),$guest_id,false,NULL),array(comcode_to_tempcode(escape_html($row['a_label_3']),$guest_id,false,NULL),escape_html($link_1->evaluate()),escape_html($link_2->evaluate()),escape_html($link_3->evaluate())));

				publish_to_FB($tempcode->evaluate(),'',$link_1->evaluate(),$cookie['uid']);
			}
		}
	}
	else
		return -1;

	return $stored_id;
}

/**
 * Convert a page link into a tempcode.
 *
 * @param  string			The page link
 * @param  boolean		Whether the link is for putting out externally to the site (so no keep_* parameters)
 * @return array			tempcode url
 */
function pagelink_to_tempcode($pagelink,$external=false)
{
	list($zone,$map,$hash)=page_link_decode($pagelink);

	$value=build_url($map,$zone,array(),false,false,$external,$hash);
	return make_string_tempcode(escape_html($value));
}
