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
 * @package		points
 */

/**
 * Module page class.
 */
class Module_points
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=6;
		$info['locked']=true;
		$info['update_require_upgrade']=1;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('chargelog');
		$GLOBALS['SITE_DB']->drop_if_exists('gifts');

		delete_config_option('points_joining');
		delete_config_option('points_posting');
		delete_config_option('points_rating');
		delete_config_option('points_voting');
		delete_config_option('points_per_day');
		delete_config_option('points_per_daily_visit');
		delete_config_option('points_if_liked');
		delete_config_option('points_show_personal_stats_points_left');
		delete_config_option('points_show_personal_stats_points_used');
		delete_config_option('points_show_personal_stats_gift_points_left');
		delete_config_option('points_show_personal_stats_gift_points_used');
		delete_config_option('points_show_personal_stats_total_points');
		delete_config_option('points_show_personal_profile_link');

		delete_specific_permission('give_points_self');
		delete_specific_permission('have_negative_gift_points');
		delete_specific_permission('give_negative_points');
		delete_specific_permission('view_charge_log');
		delete_specific_permission('use_points');
		delete_specific_permission('trace_anonymous_gifts');

		delete_menu_item_simple('_SEARCH:points:type=member:id={$USER_OVERIDE}');
		delete_menu_item_simple('_SEARCH:points:type=member');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((is_null($upgrade_from)) || ($upgrade_from<3))
		{
			add_specific_permission('POINTS','use_points',true);
		}

		if (is_null($upgrade_from))
		{
			$GLOBALS['SITE_DB']->create_table('chargelog',array(
				'id'=>'*AUTO',
				'user_id'=>'USER',
				'amount'=>'INTEGER',
				'reason'=>'SHORT_TRANS',	// Comcode
				'date_and_time'=>'TIME'
			));

			$GLOBALS['SITE_DB']->create_table('gifts',array(
				'id'=>'*AUTO',
				'date_and_time'=>'TIME',
				'amount'=>'INTEGER',
				'gift_from'=>'USER',
				'gift_to'=>'USER',
				'reason'=>'SHORT_TRANS',	// Comcode
				'anonymous'=>'BINARY'
			));
			$GLOBALS['SITE_DB']->create_index('gifts','giftsgiven',array('gift_from'));
			$GLOBALS['SITE_DB']->create_index('gifts','giftsreceived',array('gift_to'));

			add_config_option('JOINING','points_joining','integer','return \'40\';','POINTS','COUNT_POINTS_GIVEN');
			add_config_option('MAKE_POST','points_posting','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN');
			add_config_option('RATING','points_rating','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN');
			add_config_option('VOTING','points_voting','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN');

			add_specific_permission('POINTS','give_points_self',false);
			add_specific_permission('POINTS','have_negative_gift_points',false);
			add_specific_permission('POINTS','give_negative_points',false);
			add_specific_permission('POINTS','view_charge_log',false);
		}

		if ((!is_null($upgrade_from)) && ($upgrade_from<5))
		{
			delete_config_option('is_on_points');
		}

		if ((!is_null($upgrade_from)) && ($upgrade_from<6))
		{
			delete_config_option('points_show_personal_profile_link');
		}

		if ((is_null($upgrade_from)) || ($upgrade_from<7))
		{
			add_config_option('POINTS_IF_LIKED','points_if_liked','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN');
		}

		if ((is_null($upgrade_from)) || ($upgrade_from<5))
		{
			add_config_option('COUNT_POINTS_LEFT','points_show_personal_stats_points_left','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK');
			add_config_option('COUNT_POINTS_USED','points_show_personal_stats_points_used','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK');
			add_config_option('COUNT_GIFT_POINTS_LEFT','points_show_personal_stats_gift_points_left','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK');
			add_config_option('COUNT_GIFT_POINTS_USED','points_show_personal_stats_gift_points_used','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK');
			add_config_option('COUNT_POINTS_EVER','points_show_personal_stats_total_points','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK');

			add_specific_permission('POINTS','trace_anonymous_gifts',false);
		}

		if ((is_null($upgrade_from)) || ($upgrade_from<4))
		{
			add_config_option('POINTS_PER_DAY','points_per_day','integer','return \'0\';','POINTS','COUNT_POINTS_GIVEN');
			add_config_option('POINTS_PER_DAILY_VISIT','points_per_daily_visit','integer','return \'0\';','POINTS','COUNT_POINTS_GIVEN');
		}
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		if (get_forum_type()=='ocf') return array();
		$ret=array('browser'=>'BROWSE_POINT_PROFILES','misc'=>'USER_POINT_FIND');
		if (!is_guest()) $ret['member']='POINTS';
		return $ret;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_code('points');
		require_css('points');
		require_lang('points');

		// Work out what we're doing here
		$type=get_param('type','misc');

		if ($type=='_search') return $this->points_search_results();
		if ($type=='give') return $this->do_give();
		if ($type=='member') return $this->points_profile();
		if ($type=='browser') return $this->points_profile(db_get_first_id()+1);
		if ($type=='misc') return $this->points_search_form();

		return new ocp_tempcode();
	}

	/**
	 * The UI to search for a member (with regard to viewing their point profile).
	 *
	 * @return tempcode		The UI
	 */
	function points_search_form()
	{
		$GLOBALS['FEED_URL']=find_script('backend').'?mode=points&filter=';

		$title=get_page_title('USER_POINT_FIND');

		$post_url=build_url(array('page'=>'_SELF','type'=>'_search'),'_SELF',NULL,false,true);
		require_code('form_templates');
		if (!is_guest())
		{
			$username=$GLOBALS['FORUM_DRIVER']->get_username(get_member());
		} else
		{
			$username='';
		}
		$fields=form_input_username(do_lang_tempcode('USERNAME'),'','membername',$username,true,false);
		$submit_name=do_lang_tempcode('SEARCH');
		$text=new ocp_tempcode();
		$text->attach(paragraph(do_lang_tempcode('POINTS_SEARCH_FORM')));
		$text->attach(paragraph(do_lang_tempcode('WILDCARD')));

		return do_template('FORM_SCREEN',array('_GUID'=>'e5ab8d5d599093d1a550cb3b3e56d2bf','GET'=>true,'SKIP_VALIDATION'=>true,'HIDDEN'=>'','TITLE'=>$title,'URL'=>$post_url,'FIELDS'=>$fields,'SUBMIT_NAME'=>$submit_name,'TEXT'=>$text));
	}

	/**
	 * The actualiser for a points profile search.
	 *
	 * @return tempcode		The UI
	 */
	function points_search_results()
	{
		$GLOBALS['FEED_URL']=find_script('backend').'?mode=points&filter=';

		$membername=str_replace('*','%',get_param('membername'));
		if ((substr($membername,0,1)=='%') && ($GLOBALS['FORUM_DRIVER']->get_members()>3000))
			warn_exit(do_lang_tempcode('CANNOT_WILDCARD_START'));
		if ((strpos($membername,'%')!==false) && (strpos($membername,'%')<6) && ($GLOBALS['FORUM_DRIVER']->get_members()>30000))
			warn_exit(do_lang_tempcode('CANNOT_WILDCARD_START'));
		if ((strpos($membername,'%')!==false) && (strpos($membername,'%')<12) && ($GLOBALS['FORUM_DRIVER']->get_members()>300000))
			warn_exit(do_lang_tempcode('CANNOT_WILDCARD_START'));
		$rows=$GLOBALS['FORUM_DRIVER']->get_matching_members($membername,100);
		if (!array_key_exists(0,$rows))
		{
			$title=get_page_title('USER_POINT_FIND');
			return warn_screen($title,do_lang_tempcode('NO_RESULTS'));
		}
	//	if (count($rows)>1)
		{
			$title=get_page_title('USER_POINT_FIND');

			$results=new ocp_tempcode();
			foreach ($rows as $myrow)
			{
				$id=$GLOBALS['FORUM_DRIVER']->pname_id($myrow);
				if (!is_guest($id))
				{
					$url=build_url(array('page'=>'_SELF','type'=>'member','id'=>$id),'_SELF');
					$name=$GLOBALS['FORUM_DRIVER']->pname_name($myrow);

					$results->attach(do_template('POINTS_SEARCH_RESULT',array('_GUID'=>'df240255b2981dcaee38e126622be388','URL'=>$url,'ID'=>strval($id),'NAME'=>$name)));
				}
			}

			$ret=do_template('POINTS_SEARCH_SCREEN',array('_GUID'=>'659af8a012d459db09dad0325a75ac70','TITLE'=>$title,'RESULTS'=>$results));
		}

	//	  $ret=$this->points_profile($GLOBALS['FORUM_DRIVER']->pname_id($rows[0]));

		breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('USER_POINT_FIND'))));

		return $ret;
	}

	/**
	 * The UI for a points profile.
	 *
	 * @param  ?MEMBER		The member the points profile of which is being viewed (NULL: read from GET parameter 'id')
	 * @return tempcode		The UI
	 */
	function points_profile($member_id_of=NULL)
	{
		if (is_null($member_id_of)) $member_id_of=get_param_integer('id',get_member());

		$name=$GLOBALS['FORUM_DRIVER']->get_username($member_id_of);
		if ((is_null($name)) || (is_guest($member_id_of))) warn_exit(do_lang_tempcode('USER_NO_EXIST'));
		$title=get_page_title('_POINTS',true,array(escape_html($name)));

		if (get_forum_type()=='ocf')
		{
			$url=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id_of,true,true);
			if (is_object($url)) $url=$url->evaluate();
			return redirect_screen($title,$url.'#tab__points','');
		}

		$GLOBALS['FEED_URL']=find_script('backend').'?mode=points&filter='.strval($member_id_of);

		breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('USER_POINT_FIND'))));

		// Previous/Next links
		$max_rows=$GLOBALS['FORUM_DRIVER']->get_members();
		$page_num=intval(floor(floatval($member_id_of-1)/1.0))+1;
		$num_pages=intval(ceil(floatval($max_rows)/1.0));
		$tempid=$GLOBALS['FORUM_DRIVER']->get_previous_member($member_id_of);
		if (is_null($tempid)) $previous_link=new ocp_tempcode();
			else $previous_link=build_url(array('page'=>'_SELF','type'=>'member','id'=>$tempid),'_SELF');
		$tempid=$GLOBALS['FORUM_DRIVER']->get_next_member($member_id_of);
		if (is_null($tempid)) $next_link=new ocp_tempcode();
			else $next_link=build_url(array('page'=>'_SELF','type'=>'member','id'=>$tempid),'_SELF');
		$browse=do_template('NEXT_BROWSER_BROWSE_NEXT',array('_GUID'=>'188c059239b39ca8ee70f85b38019490','PREVIOUS_LINK'=>$previous_link,'NEXT_LINK'=>$next_link,'PAGE_NUM'=>integer_format($page_num),'NUM_PAGES'=>integer_format($num_pages)));

		require_code('points3');
		$content=points_profile($member_id_of,get_member());

		return do_template('POINTS_SCREEN',array('TITLE'=>$title,'CONTENT'=>$content,'BROWSE'=>$browse));
	}

	/**
	 * The actualiser for a gift point transaction.
	 *
	 * @return tempcode		The UI
	 */
	function do_give()
	{
		$member_id_of=get_param_integer('id');

		breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('USER_POINT_FIND')),array('_SELF:_SELF:member:id='.strval($member_id_of),do_lang_tempcode('_POINTS',escape_html($GLOBALS['FORUM_DRIVER']->get_username($member_id_of))))));

		$title=get_page_title('POINTS');

		$trans_type=post_param('trans_type','gift');

		$amount=post_param_integer('amount');
		$reason=post_param('reason');

		$worked=false;

		$member_id_viewing=get_member();
		if (($member_id_of==$member_id_viewing) && (!has_specific_permission($member_id_viewing,'give_points_self'))) // No cheating
		{
			$message=do_lang_tempcode('PE_SELF');
		}
		elseif (is_guest($member_id_viewing)) // No cheating
		{
			$message=do_lang_tempcode('MUST_LOGIN');
		} else
		{
			if ($trans_type=='gift')
			{
				$anonymous=post_param_integer('anonymous',0);
				$viewer_gift_points_available=get_gift_points_to_give($member_id_viewing);
				//$viewer_gift_points_used=get_gift_points_used($member_id_viewing);

				if (($viewer_gift_points_available<$amount) && (!has_specific_permission($member_id_viewing,'have_negative_gift_points'))) // Validate we have enough for this, and add to usage
				{
					$message=do_lang_tempcode('PE_LACKING_GIFT_POINTS');
				}
				elseif (($amount<0) && (!has_specific_permission($member_id_viewing,'give_negative_points'))) // Trying to be negative
				{
					$message=do_lang_tempcode('PE_NEGATIVE_GIFT');
				}
				elseif ($reason=='') // Must give a reason
				{
					$message=do_lang_tempcode('IMPROPERLY_FILLED_IN');
				} else
				{
					// Write transfer
					require_code('points2');
					give_points($amount,$member_id_of,$member_id_viewing,$reason,$anonymous==1);

					// Randomised gifts
					if (mt_rand(0,4)==1) // TODO: 4 should be a config option
					{
						$message=do_lang_tempcode('PR_LUCKY');
						$_current_gift=point_info($member_id_viewing);
						$current_gift=array_key_exists('points_gained_given',$_current_gift)?$_current_gift['points_gained_given']:0;
						$GLOBALS['FORUM_DRIVER']->set_custom_field($member_id_viewing,'points_gained_given',$current_gift+25); // TODO: 25 should be a config option
					} else $message=do_lang_tempcode('PR_NORMAL');

					$worked=true;
				}
			}

			if ($trans_type=='refund')
			{
				$trans_type='charge';
				$amount=-$amount;
			}
			if ($trans_type=='charge')
			{
				if (has_actual_page_access($member_id_viewing,'admin_points','adminzone'))
				{
					require_code('points2');
					charge_member($member_id_of,$amount,$reason);
					$left=available_points($member_id_of);

					$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id_of);
					if (is_null($username)) $username=do_lang('UNKNOWN');
					$message=do_lang_tempcode('USER_HAS_BEEN_CHARGED',escape_html($username),escape_html(integer_format($amount)),escape_html(integer_format($left)));

					$worked=true;
				} else
				{
					access_denied('I_ERROR');
				}
			}
		}

		if ($worked)
		{
			// Show it worked / Refresh
			$url=build_url(array('page'=>'_SELF','type'=>'member','id'=>$member_id_of),'_SELF');
			return redirect_screen($title,$url,$message);
		} else return warn_screen($title,$message);
	}

}


