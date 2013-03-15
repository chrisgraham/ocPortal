<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		activity_feed
 */

class Hook_Profiles_Tabs_activities
{

	/**
	 * Find whether this hook is active.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @return boolean		Whether this hook is active
	 */
	function is_active($member_id_of,$member_id_viewing)
	{
		return true;
	}

	/**
	 * Standard modular render function for profile tab hooks.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @param  boolean		Whether to leave the tab contents NULL, if tis hook supports it, so that AJAX can load it later
	 * @return array			A triple: The tab title, the tab contents, the suggested tab order
	 */
	function render_tab($member_id_of,$member_id_viewing,$leave_to_ajax_if_possible=false)
	{
		// Need to declare these here as the Tempcode engine can't look as deep, into a loop (I think), as it would need to, to find the block declaring the dependency
		require_lang('activities');
		require_css('activities');
		require_javascript('javascript_activities_state');
		require_javascript('javascript_activities');
		require_javascript('javascript_jquery');
		require_javascript('javascript_base64');

		$GLOBALS['FEED_URL']=find_script('backend').'?mode=activities&filter='.strval($member_id_of);

		require_lang('activities');

		$title=do_lang_tempcode('ACTIVITIES_TITLE');

		$order=70;

		// Allow user to link up things for syndication
		$syndications=array();
		if ($member_id_of==$member_id_viewing)
		{
			$dests=find_all_hooks('systems','syndication');
			foreach (array_keys($dests) as $hook)
			{
				require_code('hooks/systems/syndication/'.$hook);
				$ob=object_factory('Hook_Syndication_'.$hook);
				if ($ob->is_available())
				{
					if (either_param('syndicate_stop__'.$hook,NULL)!==NULL)
					{
						$ob->auth_unset($member_id_of);
					}
					elseif (either_param('syndicate_start__'.$hook,NULL)!==NULL)
					{
						$url_map=array('page'=>'_SELF','type'=>'view','id'=>$member_id_of,'oauth_in_progress'=>1);
						$url_map['syndicate_start__'.$hook]=1;
						$oauth_url=build_url($url_map,'_SELF',NULL,false,false,false,'tab__activities');
						$ob->auth_set($member_id_of,$oauth_url);
					} elseif (($ob->auth_is_set($member_id_of)) && (either_param('oauth_in_progress',NULL)===NULL) && (!$GLOBALS['IS_ACTUALLY_ADMIN']))
					{
						// Do a refresh to make sure the token is updated
						$url_map=array('page'=>'_SELF','type'=>'view','id'=>$member_id_of,'oauth_in_progress'=>1);
						$url_map['syndicate_start__'.$hook]=1;
						$oauth_url=build_url($url_map,'_SELF',NULL,false,false,false,'tab__activities');
						$ob->auth_set($member_id_of,$oauth_url);
 					}

					$syndications[$hook]=array(
						'SYNDICATION_IS_SET'=>$ob->auth_is_set($member_id_of),
						'SYNDICATION_SERVICE_NAME'=>$ob->get_service_name(),
					);
				}
			}
		}

		if ($leave_to_ajax_if_possible) return array($title,NULL,$order);

		$content=do_template('OCF_MEMBER_PROFILE_ACTIVITIES',array('MEMBER_ID'=>strval($member_id_of),'SYNDICATIONS'=>$syndications));

		return array($title,$content,$order);
	}

}


