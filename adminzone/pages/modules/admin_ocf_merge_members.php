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
 * Module page class.
 */
class Module_admin_ocf_merge_members
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
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('misc'=>'MERGE_MEMBERS');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		set_helper_panel_pic('pagepics/mergemembers');
		set_helper_panel_tutorial('tut_adv_members');

		if (get_forum_type()!='ocf') warn_exit(do_lang_tempcode('NO_OCF')); else ocf_require_all_forum_stuff();

		$type=get_param('type','misc');

		if ($type=='misc') return $this->gui();
		if ($type=='actual') return $this->actual();

		return new ocp_tempcode();
	}

	/**
	 * The UI for choosing members to merge.
	 *
	 * @return tempcode		The UI
	 */
	function gui()
	{
		$title=get_screen_title('MERGE_MEMBERS');

		breadcrumb_set_parents(array(array('_SEARCH:admin_ocf_join:menu',do_lang_tempcode('MEMBERS'))));

		$fields=new ocp_tempcode();

		require_code('form_templates');

		$fields->attach(form_input_username(do_lang_tempcode('FROM'),do_lang_tempcode('DESCRIPTION_MEMBER_FROM'),'from','',true));
		$fields->attach(form_input_username(do_lang_tempcode('TO'),do_lang_tempcode('DESCRIPTION_MEMBER_TO'),'to','',true));

		if ($GLOBALS['SITE_DB']->connection_write!=$GLOBALS['SITE_DB']->connection_write)
		{
			$fields->attach(form_input_tick(do_lang_tempcode('MERGING_ON_MSN'),do_lang_tempcode('DESCRIPTION_MERGING_ON_MSN'),'keep',true));
		}

		$submit_name=do_lang_tempcode('MERGE_MEMBERS');
		$post_url=build_url(array('page'=>'_SELF','type'=>'actual'),'_SELF');
		$text=do_lang_tempcode('MERGE_MEMBERS_TEXT');
		return do_template('FORM_SCREEN',array('_GUID'=>'6f6b18d90bbe9550303ab41be0a26dcb','SKIP_VALIDATION'=>true,'TITLE'=>$title,'URL'=>$post_url,'FIELDS'=>$fields,'HIDDEN'=>'','TEXT'=>$text,'SUBMIT_NAME'=>$submit_name));
	}

	/**
	 * The actualiser for merging members.
	 *
	 * @return tempcode		The UI
	 */
	function actual()
	{
		$title=get_screen_title('MERGE_MEMBERS');

		$to_username=post_param('to');
		$to_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($to_username);
		if ((is_null($to_id)) || (is_guest($to_id))) warn_exit(do_lang_tempcode('_MEMBER_NO_EXIST',$to_username));
		$from_username=post_param('from');
		$from_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($from_username);

		if (is_guest($from_id)) warn_exit(do_lang_tempcode('INTERNAL_ERROR'));

		if ((is_null($from_id)) || (is_guest($from_id))) warn_exit(do_lang_tempcode('_MEMBER_NO_EXIST',$from_username));

		if ($to_id==$from_id) warn_exit(do_lang_tempcode('MERGE_SAME'));

		$meta=$GLOBALS['SITE_DB']->query('SELECT m_table,m_name FROM '.get_table_prefix().'db_meta WHERE '.db_string_equal_to('m_type','MEMBER').' OR '.db_string_equal_to('m_type','?MEMBER').' OR '.db_string_equal_to('m_type','*MEMBER'));
		foreach ($meta as $m)
		{
			$db=(substr($m['m_table'],0,2)=='f_')?$GLOBALS['FORUM_DB']:$GLOBALS['SITE_DB'];
			$db->query_update($m['m_table'],array($m['m_name']=>$to_id),array($m['m_name']=>$from_id),'',NULL,NULL,false,true);
		}

		$GLOBALS['FORUM_DB']->query_update('f_posts',array('p_poster_name_if_guest'=>$to_username),array('p_poster'=>$from_id));

		$new_post_count=$GLOBALS['FORUM_DRIVER']->get_member_row_field($from_id,'m_cache_num_posts')+$GLOBALS['FORUM_DRIVER']->get_member_row_field($to_id,'m_cache_num_posts');
		$GLOBALS['FORUM_DB']->query_update('f_members',array('m_cache_num_posts'=>$new_post_count),array('id'=>$to_id),'',1);

		require_code('ocf_members_action');
		require_code('ocf_members_action2');

		$fields=ocf_get_custom_fields_member($from_id);
		foreach ($fields as $key=>$val)
		{
			if ($val!='') ocf_set_custom_field($to_id,$key,$val);
		}

		if (post_param_integer('keep',0)!=1)
			ocf_delete_member($from_id);

		// Cache emptying ...
		ocf_require_all_forum_stuff();

		require_code('ocf_posts_action');
		require_code('ocf_posts_action2');
		require_code('ocf_topics_action2');
		require_code('ocf_forums_action2');

		// Members
		ocf_force_update_member_post_count($to_id);
		$num_warnings=$GLOBALS['FORUM_DB']->query_select_value('f_warnings','COUNT(*)',array('w_member_id'=>$to_id));
		$GLOBALS['FORUM_DB']->query_update('f_members',array('m_cache_warnings'=>$num_warnings),array('id'=>$to_id),'',1);

		// Topics and posts
		require_code('ocf_topics_action');
		$topics=$GLOBALS['FORUM_DB']->query_select('f_topics',array('id','t_forum_id'),array('t_cache_first_member_id'=>$from_id));
		foreach ($topics as $topic)
			ocf_force_update_topic_cacheing($topic['id'],NULL,true,true);
		$topics=$GLOBALS['FORUM_DB']->query_select('f_topics',array('id','t_forum_id'),array('t_cache_last_member_id'=>$from_id));
		foreach ($topics as $topic)
			ocf_force_update_topic_cacheing($topic['id'],NULL,true,true);

		// Forums
		require_code('ocf_posts_action2');
		$forums=$GLOBALS['FORUM_DB']->query_select('f_forums',array('id'),array('f_cache_last_member_id'=>$from_id));
		foreach ($forums as $forum)
			ocf_force_update_forum_cacheing($forum['id']);

		// ---

		log_it('MERGE_MEMBERS',$from_username,$to_username);

		breadcrumb_set_parents(array(array('_SEARCH:admin_ocf_join:menu',do_lang_tempcode('MEMBERS')),array('_SELF:_SELF:misc',do_lang_tempcode('MERGE_MEMBERS'))));
		breadcrumb_set_self(do_lang_tempcode('DONE'));

		$username=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($to_id);
		return inform_screen($title,do_lang_tempcode('MERGED_MEMBERS',$username));
	}

}


