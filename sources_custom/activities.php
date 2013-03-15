<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		activity_feed
 */

/*
TODO: Support if JS disabled
TODO: PHP doc comments
*/

function find_activities($viewer_id,$mode,$member_ids)
{
	$proceed_selection=true; //There are some cases in which even glancing at the database is a waste of precious time.

	$is_guest=false; //Can't be doing with overcomplicated SQL breakages. Weed it out.
	$guest_id=$GLOBALS['FORUM_DRIVER']->get_guest_id();
	if ($guest_id==$viewer_id)
		$is_guest=true;

	if (addon_installed('chat'))
	{
		if (!$is_guest) //If not a guest, get all blocks
		{
			//Grabbing who you're blocked-by
			$blocked_by=$GLOBALS['SITE_DB']->query_select('chat_blocking', array('member_blocker'), array('member_blocked'=>$viewer_id));

			if (count($blocked_by)>0)
			{
				if (count($blocked_by)>1)
				{
					collapse_1d_complexity('member_blocker', $blocked_by);
					$blocked_by=implode(',',$blocked_by);
				}
				else
				{
					$blocked_by=current($blocked_by);
					$blocked_by=$blocked_by['member_blocker'];
				}
			}
			else
				$blocked_by='';

			//Grabbing who you've blocked
			$blocking=$GLOBALS['SITE_DB']->query_select('chat_blocking', array('member_blocked'), array('member_blocker'=>$viewer_id));

			if (count($blocking)>0)
			{
				if (count($blocking)>1)
				{
					collapse_1d_complexity('member_blocked', $blocking);
					$blocking=implode(',',$blocking);
				}
				else
				{
					$blocking=current($blocking);
					$blocking=$blocking['member_blocked']; //If it's pointing to anything other than the only possible item, PHP needs fixing.
				}
			}
			else
				$blocking='';
		}
	}
	else
	{
		$blocking='';
		$blocked_by='';
	}

	switch ($mode)
	{
		case 'some_members': //This is used to view one's own activity (eg. on a profile)
			$whereville='';
			foreach ($member_ids as $member_id)
			{
				if ($whereville!='') $whereville.=' AND ';
				$_whereville='';
				$_whereville.='(';
				$_whereville.='a_member_id='.strval($member_id);
				$_whereville.=' OR ';
				$_whereville.='(';
				$_whereville.='a_also_involving='.strval($member_id);
				if (addon_installed('chat'))
				{
					$_whereville.=' AND a_member_id IN (SELECT member_liked FROM '.get_table_prefix().'chat_friends WHERE member_likes='.strval(get_member()).')';
				}
				$_whereville.=')';
				$_whereville.=')';

				// If the chat addon is installed then there may be 'friends-only'
				// posts, which we may need to filter out. Otherwise we don't need
				// to care.
				if (($member_id!=$viewer_id) && addon_installed('chat'))
				{
					$view_private=NULL;        //Set to default denial level and only bother asking for perms if not a guest.
					if ((!$is_guest))
					{
						if (strlen($blocked_by)>0) //On the basis that you've sought this view out, your blocking them doesn't hide their messages.
							$friends_check_where='(member_likes='.strval($member_id).' AND member_liked='.strval($viewer_id).' AND member_likes NOT IN('.$blocked_by.'))';
						else
							$friends_check_where='(member_likes='.strval($member_id).' AND member_liked='.strval($viewer_id).')';

						$view_private=$GLOBALS['SITE_DB']->query_value_if_there('SELECT member_likes FROM '.get_table_prefix().'chat_friends WHERE '.$friends_check_where,false,true);
					}

					if (is_null($view_private)) //If not friended by this person, the view is filtered.
						$_whereville='('.$_whereville.' AND a_is_public=1)';
				}

				$whereville.=$_whereville;
			}
	      break;

		case 'friends':
			// "friends" only makes sense if the chat addon is installed
			if (addon_installed('chat') && !$is_guest) //If not a guest, get all reciprocal friendships.
			{
				$like_outgoing=array();
				//Working on the principle that you only want to see people you like on this, only those you like and have not blocked will be selected
				//Exclusions will be based on whether they like and have not blocked you.

				//Select mutual likes you haven't blocked.
				$tables_and_joins ='chat_friends a JOIN '.get_table_prefix().'chat_friends b';
				$tables_and_joins.=' ON (a.member_liked=b.member_likes AND a.member_likes=b.member_liked AND a.member_likes=';
				$tables_and_joins.=strval($viewer_id);

				$extra_not='';
				if (strlen($blocking)>0) //Also setting who gets discarded from outgoing like selection
				{
					$tables_and_joins.=' AND a.member_liked NOT IN('.$blocking.')';
					$extra_not.=' AND member_liked NOT IN('.$blocking.')';
				}

				if (strlen($blocked_by)>0)
				{
					$tables_and_joins.=' AND a.member_liked NOT IN('.$blocked_by.')';
				}

				$tables_and_joins.=')';
				$extra_not.=');';

				$like_mutual=$GLOBALS['SITE_DB']->query_select($tables_and_joins, array('a.member_liked AS liked'));

				if (count($like_mutual)>1) //More than one mutual friend
				{
					$lm_ids='';

					foreach ($like_mutual as $l_m)
					{
						$lm_ids.=','.strval($l_m['liked']);
					}

					$lm_ids=substr($lm_ids, 1);

					$like_outgoing=$GLOBALS['SITE_DB']->query_select('chat_friends', array('member_liked'), NULL, ' WHERE (member_likes='.strval($viewer_id).' AND member_liked NOT IN('.$lm_ids.')'.$extra_not);

					if (count($like_outgoing)>1) //Likes more than one non-mutual friend
					{
						$lo_ids='';
						foreach ($like_outgoing as $l_o)
						{
							$lo_ids.=','.strval($l_o['member_liked']);
						}

						$lo_ids=substr($lo_ids, 1);

						$whereville='(a_member_id IN('.$lm_ids.') OR (a_member_id IN('.$lo_ids.') AND a_is_public=1))';
					}
					elseif (count($like_outgoing)>0) //Likes one non-mutual friend
					{
						$whereville='(a_member_id IN('.$lm_ids.') OR (a_member_id='.strval($like_outgoing[0]['member_liked']).' AND a_is_public=1))';
					}
					else //Only has mutual friends
					{
						$whereville='a_member_id IN('.$lm_ids.')';
					}
				}
				elseif (count($like_mutual)>0) //Has one mutual friend
				{
					$like_outgoing=$GLOBALS['SITE_DB']->query_select('chat_friends', array('member_liked'), NULL, ' WHERE (member_likes='.strval($viewer_id).' AND member_liked!='.strval($like_mutual[0]['liked']).$extra_not);

					if (count($like_outgoing)>1) //Likes more than one non-mutual friend
					{
						$lo_ids='';
						foreach ($like_outgoing as $l_o)
						{
							$lo_ids.=','.strval($l_o['member_liked']);
						}

						$lo_ids=substr($lo_ids, 1);

						$whereville='(a_member_id='.strval($like_mutual[0]['liked']).' OR (a_member_id IN('.$lo_ids.') AND a_is_public=1))';
					}
					elseif (count($like_outgoing)>0) //Likes one non-mutual friend
					{
						$whereville='(a_member_id='.strval($like_mutual[0]['liked']).' OR (a_member_id='.strval($like_outgoing[0]['member_liked']).' AND a_is_public=1))';
					}
					else
					{
						$whereville='a_member_id='.strval($like_mutual[0]['liked']); //Has one mutual friend and no others
					}
				}
				else //Has no mutual friends
				{
					if (!$is_guest)
						$like_outgoing=$GLOBALS['SITE_DB']->query_select('chat_friends', array('member_liked'), NULL, ' WHERE (member_likes='.strval($viewer_id).$extra_not);

					if (count($like_outgoing)>1) //Likes more than one person
					{
						$lo_ids='';
						foreach ($like_outgoing as $l_o)
						{
							$lo_ids.=','.strval($l_o['member_liked']);
						}

						$lo_ids=substr($lo_ids, 1);

						$whereville='(a_member_id IN('.$lo_ids.') AND a_is_public=1)';
					}
					elseif (count($like_outgoing)>0) //Likes one person
						$whereville='(a_member_id='.strval($like_outgoing[0]['member_liked']).' AND a_is_public=1)';
					else //Has no friends, the case with _all_ new members.
						$proceed_selection=false;
				}
			}
			else
				$proceed_selection=false;
			break;

		case 'all': //Frontpage, 100% permissions dependent.
		default:
			$view_private=array();
			if (addon_installed('chat') && !$is_guest)
			{
				$friends_check_where='member_liked='.strval($viewer_id);
				if (strlen($blocked_by)>0)
					$friends_check_where='('.$friends_check_where.' AND member_likes NOT IN ('.$blocked_by.'))';

				$view_private=$GLOBALS['SITE_DB']->query_select('chat_friends', array('member_likes'), NULL, ' WHERE '.$friends_check_where.';');
				$view_private[]=array('member_likes'=>$viewer_id);
			}

			if (count($view_private)>1)
			{
				$vp='';

				foreach($view_private as $v_p)
				{
					$vp.=','.$v_p['member_likes'];
				}

				$vp=substr($vp, 1);

				$whereville='(a_member_id IN('.$vp.') OR (a_is_public=1 AND a_member_id!='.strval($guest_id).'))';
			}
			elseif (count($view_private)>0)
			{
				$view_private=current($view_private);
				$whereville='(a_member_id='.strval($view_private['member_likes']).' OR (a_is_public=1 AND a_member_id<>'.strval($guest_id).'))';
			}
			else
			{
				$whereville='(a_is_public=1 AND a_member_id!='.strval($guest_id).')';
			}
	      break;
	}

	return array($proceed_selection,$whereville);
}

function render_activity($row,$use_inside_ocp=true)
{
	$guest_id=$GLOBALS['FORUM_DRIVER']->get_guest_id();

	// Details of member
	$member_id=$row['a_member_id'];
	$member_avatar=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);
	$member_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id,false,$use_inside_ocp);

	$datetime=$row['a_time'];

	$message=new ocp_tempcode();

	$test=do_lang($row['a_language_string_code'],'{1}','{2}','{3}');

	// Convert our parameters and links to Tempcode
	$label=array();
	$link=array();
	for ($i=1;$i<=3;$i++)
	{
		$label[$i]=comcode_to_tempcode($row['a_label_'.strval($i)],$guest_id,false,NULL);
		$link[$i]=($row['a_pagelink_'.strval($i)]=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_'.strval($i)],!$use_inside_ocp);

		if (($row['a_pagelink_'.strval($i)]!='') && (strpos($test,'{'.strval($i+3).'}')===false))
		{
			$label[$i]=hyperlink($link[$i],$label[$i]->evaluate());
		}
	}

	// Render primary language string
	$extra_lang_string_params=array(
		$label[3],
		escape_html($link[1]->evaluate()),
		escape_html($link[2]->evaluate()),
		escape_html($link[3]->evaluate())
	);
	if (!is_null($row['a_also_involving']))
	{
		$_username=$GLOBALS['FORUM_DRIVER']->get_username($row['a_also_involving']);
		$url=$GLOBALS['FORUM_DRIVER']->member_profile_url($row['a_also_involving'],false,$use_inside_ocp);
		$hyperlink=hyperlink($url,$_username,false,true);

		$extra_lang_string_params[]=static_evaluate_tempcode($hyperlink);
	} else
	{
		$extra_lang_string_params[]=do_lang('GUEST');
	}
	$message->attach(do_lang_tempcode($row['a_language_string_code'],
		$label[1],
		$label[2],
		$extra_lang_string_params
	));

	// Lang string may not use all params, so add extras on if were unused
	for ($i=1;$i<=3;$i++)
	{
		if ((strpos($test,'{1}')===false) && (strpos($test,'{2}')===false) && (strpos($test,'{3}')===false) && ($row['a_label_'.strval($i)]!=''))
		{
			if (!$message->is_empty())
				$message->attach(': ');

			$message->attach($label[$i]->evaluate());
		}
	}

	return array($message,$member_avatar,$datetime,$member_url,$row['a_language_string_code'],$row['a_is_public']==1);
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
