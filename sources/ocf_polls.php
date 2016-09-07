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
 * @package		core_ocf
 */

/**
 * Find whether a member can alter a poll owned by a certain member in a certain forum.
 *
 * @param  AUTO_LINK	The forum.
 * @param  MEMBER		The poll owner.
 * @param  ?MEMBER	The member we are checking for (NULL: current member).
 * @return boolean	The answer.
 */
function ocf_may_edit_poll_by($forum_id,$poll_owner,$member_id=NULL)
{
	if (is_null($member_id)) $member_id=get_member();

	if (has_specific_permission($member_id,'edit_midrange_content','topics',array('forums',$forum_id))) return true;

	if ((has_specific_permission($member_id,'edit_own_polls','topics',array('forums',$forum_id))) && ($member_id==$poll_owner)) return true;

	return false;
}

/**
 * Find whether a member may attach a poll to a detailed topic.
 *
 * @param  AUTO_LINK The topic.
 * @param  ?MEMBER	The topic owner (NULL: ask the DB for it).
 * @param  ?boolean  Whether the topic already has a poll (NULL: ask the DB for it).
 * @param  ?MEMBER	The forum the topic is in (NULL: ask the DB for it).
 * @param  ?MEMBER	The member we are checking for (NULL: current member).
 * @return boolean	The answer.
 */
function ocf_may_attach_poll($topic_id,$topic_owner=NULL,$has_poll_already=NULL,$forum_id=NULL,$member_id=NULL)
{
	if (is_null($topic_owner))
	{
		$topic_info=$GLOBALS['FORUM_DB']->query_select('f_topics',array('*'),array('id'=>$topic_id),'',1);
		if (!array_key_exists(0,$topic_info)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		$topic_owner=$topic_info[0]['t_cache_first_member_id'];
		$has_poll_already=!is_null($topic_info[0]['t_poll_id']);
		$forum_id=$topic_info[0]['t_forum_id'];
	}

	if (is_null($member_id)) $member_id=get_member();
	if ($has_poll_already) return false;

	if (($topic_owner==$member_id) && (!is_guest($member_id))) return true;
	if (ocf_may_moderate_forum($forum_id,$member_id)) return true;

	return false;
}

/**
 * Find whether a member can delete a poll owned by a certain member in a certain forum.
 *
 * @param  AUTO_LINK The forum.
 * @param  MEMBER		The poll owner.
 * @param  ?MEMBER	The member we are checking for (NULL: current member).
 * @return boolean	The answer.
 */
function ocf_may_delete_poll_by($forum_id,$poll_owner,$member_id=NULL)
{
	if (is_null($member_id)) $member_id=get_member();

	if (has_specific_permission($member_id,'delete_midrange_content','topics',array('forums',$forum_id))) return true;

	if ((has_specific_permission($member_id,'delete_own_midrange_content','topics',array('forums',$forum_id))) && ($member_id==$poll_owner)) return true;

	return false;
}

/**
 * Find a map of results relating to a certain poll.
 *
 * @param  AUTO_LINK The poll.
 * @param  boolean	Whether we must record that the current member is requesting the results, blocking future voting for them.
 * @return array 		The map of results.
 */
function ocf_poll_get_results($poll_id,$request_results=true)
{
	$poll_info=$GLOBALS['FORUM_DB']->query_select('f_polls',array('*'),array('id'=>$poll_id),'',1);
	if (!array_key_exists(0,$poll_info)) warn_exit(do_lang_tempcode('_MISSING_RESOURCE','poll#'.strval($poll_id)));

	$_answers=$GLOBALS['FORUM_DB']->query_select('f_poll_answers',array('*'),array('pa_poll_id'=>$poll_id),'ORDER BY id');
	$answers=array();
	foreach ($_answers as $_answer)
	{
		$answer=array();

		$answer['answer']=$_answer['pa_answer'];
		$answer['id']=$_answer['id'];
		if ((($request_results) || ($poll_info[0]['po_is_open']==0)) && ($poll_info[0]['po_is_private']==0)) // We usually will show the results for a closed poll, but not one still private
			$answer['num_votes']=$_answer['pa_cache_num_votes'];

		$answers[]=$answer;
	}

	if ($request_results)
	{
		// Forfeighting this by viewing results?
		$test=$GLOBALS['FORUM_DB']->query_value_null_ok('f_poll_votes','pv_answer_id',array('pv_poll_id'=>$poll_id,'pv_member_id'=>get_member()));
		if (is_null($test))
		{
			$forfeight=!has_specific_permission(get_member(),'view_poll_results_before_voting');
			if ($forfeight)
			{
				$GLOBALS['FORUM_DB']->query_insert('f_poll_votes',array(
					'pv_poll_id'=>$poll_id,
					'pv_member_id'=>get_member(),
					'pv_answer_id'=>-1
				));
			}
		}
	}

	$out=array(
		'is_private'=>$poll_info[0]['po_is_private'],
		'id'=>$poll_info[0]['id'],
		'question'=>$poll_info[0]['po_question'],
		'minimum_selections'=>$poll_info[0]['po_minimum_selections'],
		'maximum_selections'=>$poll_info[0]['po_maximum_selections'],
		'requires_reply'=>$poll_info[0]['po_requires_reply'],
		'is_open'=>$poll_info[0]['po_is_open'],
		'answers'=>$answers,
		'total_votes'=>$poll_info[0]['po_cache_total_votes']
	);

	return $out;
}


