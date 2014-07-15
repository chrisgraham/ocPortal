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

// activity_feed addon's implementation of activity syndication. Which in turn implements syndication hooks for further syndication (i.e. it's a syndication API built on top of a syndication API, as we don't want to provide lots of implementation code in ocPortal itself when no default use case is shipped).

class Activity_activities
{
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
	 * @param  boolean		Whether to push this out as a site event if user requested
	 * @param  ?MEMBER		Member also 'intimately' involved, such as a content submitter who is a friend (NULL: none)
	 * @return ?AUTO_LINK	ID of the row in the activities table (NULL: N/A)
	 */
	function syndicate_described_activity($a_language_string_code='',$a_label_1='',$a_label_2='',$a_label_3='',$a_pagelink_1='',$a_pagelink_2='',$a_pagelink_3='',$a_addon='',$a_is_public=1,$a_member_id=NULL,$sitewide_too=false,$also_involving=NULL)
	{
		require_code('activities_submission');

		ocp_profile_start_for('syndicate_described_activity');
		$ret=activities_addon_syndicate_described_activity($a_language_string_code,$a_label_1,$a_label_2,$a_label_3,$a_pagelink_1,$a_pagelink_2,$a_pagelink_3,$a_addon,$a_is_public,$a_member_id,$sitewide_too,$also_involving);
		ocp_profile_end_for('syndicate_described_activity',is_null($ret)?'':('#'.strval($ret)));
		return $ret;
	}

	/**
	 * Detect whether we have external site-wide syndication support somewhere.
	 *
	 * @return boolean		Whether we do
	 */
	function has_external_site_wide_syndication()
	{
		$dests=find_all_hooks('systems','syndication');
		foreach (array_keys($dests) as $hook)
		{
			require_code('hooks/systems/syndication/'.$hook);
			$ob=object_factory('Hook_Syndication_'.$hook);
			if (($ob->is_available()) && ($ob->auth_is_set_site()))
				return true;
		}
		return false;
	}

	/**
	 * Get syndication field UI.
	 *
	 * @return tempcode		Syndication fields (or empty)
	 */
	function get_syndication_option_fields()
	{
		$fields=new ocp_tempcode();
		if ((has_specific_permission(get_member(),'syndicate_site_activity')) && (has_external_site_wide_syndication()))
		{
			require_lang('activities');

			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('TITLE'=>do_lang_tempcode('SYNDICATION'))));
			$fields->attach(form_input_tick(do_lang_tempcode('SYNDICATE_THIS'),do_lang_tempcode('DESCRIPTION_SYNDICATE_THIS'),'syndicate_this',true));
		}
		return $fields;
	}
}
