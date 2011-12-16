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

/**
 * Syndicate human-intended descriptions of activities performed to the internal wall, and external listeners.
 *
 * @param  string			Language string code
 * @param  string			Label 1 (given as a parameter to the language string code)
 * @param  string			Label 2 (given as a parameter to the language string code)
 * @param  string			Label 3 (given as a parameter to the language string code)
 * @param  string			Page link 1
 * @param  string			Page link 2
 * @param  string			Page link 3
 * @param  string			Addon that caused the event
 * @param  BINARY			Whether this post should be public or friends-only
 * @param  ?MEMBER		Member being written for (NULL: current member)
 * @return ?AUTO_LINK	ID of the row in the activities table (NULL: N/A)
 */
function _syndicate_described_activity($a_language_string_code='',$a_label_1='',$a_label_2='',$a_label_3='',$a_pagelink_1='',$a_pagelink_2='',$a_pagelink_3='',$a_addon='',$a_is_public=1,$a_member_id=NULL)
{
	require_code('activities_submission');

	if ((get_db_type()=='xml') && (get_param_integer('keep_testing_logging',0)!=1)) return;

	$stored_id=0;
	if (is_null($a_member_id)) $a_member_id=get_member();
	if (is_guest($a_member_id)) return NULL;

	$go=array(
		'a_language_string_code'=>$a_language_string_code,
		'a_label_1'=>$a_label_1,
		'a_label_2'=>$a_label_2,
		'a_label_3'=>$a_label_3,
		'a_is_public'=>$a_is_public
	);

	// Check if this has been posted previously (within the last 10 minutes) to
	// stop spamming but allow generalised repeat status messages.
	$test=$GLOBALS['SITE_DB']->query_select('activities',array('a_language_string_code','a_label_1','a_label_2','a_label_3','a_is_public'),NULL,'WHERE a_time>'.strval(time()-600),1);
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
		$stored_id=$GLOBALS['SITE_DB']->query_insert('activities',$row,true);

		// Update the latest activity file
		log_newest_activity($stored_id,1000);

		// External places
		if ($a_is_public==1)
		{
			/*$dests=find_all_hooks('systems','syndication');	TODO
			foreach (array_keys($dests) as $hook)
			{
				require_code('hooks/systems/syndication/'.$hook);
				$ob=object_factory('Hook_Syndication_'.$hook);
				$ob->syndicate_user_activity();
			}*/
		}
	}
	else
		return NULL;

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

	return build_url($map,$zone,array(),false,false,$external,$hash);
}
