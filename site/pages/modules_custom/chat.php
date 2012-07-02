<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

class Mx_chat extends Module_chat
{

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		if (!has_js()) warn_exit(do_lang_tempcode('MSG_JS_NEEDED'));

		// What action are we going to do?
		$type=get_param('type','misc');

		if (function_exists('set_time_limit')) @set_time_limit(200);

		require_javascript('javascript_xmpp_prototype');
		//require_javascript('javascript_xmpp_extjs2');
		require_javascript('javascript_xmpp_dom-all');
		require_javascript('javascript_xmpp_crypto');
		require_javascript('javascript_xmpp_xmpp4js');

		require_javascript('javascript_ajax');
		require_javascript('javascript_chat');
		require_javascript('javascript_sound');
		require_javascript('javascript_editing');
		require_javascript('javascript_validation');

		require_lang('comcode');
		require_lang('chat');
		require_code('chat');
		require_css('chat');

		if ($type=='room') return $this->chat_room();
		if ($type=='options') return $this->chat_options();
		if ($type=='private') return $this->chat_private();
		if ($type=='_private') return $this->_chat_private();
		if ($type=='download_logs') return $this->chat_download_logs();
		if ($type=='_download_logs') return $this->_chat_download_logs();
		if ($type=='misc') return $this->chat_lobby();
		if ($type=='blocking_interface') return $this->blocking_interface();
		if ($type=='blocking_set') return $this->blocking_set();
		if ($type=='blocking_add') return $this->blocking_add();
		if ($type=='blocking_remove') return $this->blocking_remove();
		if ($type=='buddy_add') return $this->buddy_add();
		if ($type=='buddy_remove') return $this->buddy_remove();
		if ($type=='buddies_list') return $this->buddies_list();
		if ($type=='set_effects') return $this->set_effects();
		if ($type=='_set_effects') return $this->_set_effects();

		return new ocp_tempcode();
	}

	/**
	 * The UI to choose a chat room.
	 *
	 * @return tempcode		The UI
	 */
	function chat_lobby()
	{
		require_javascript('javascript_ajax_people_lists');

		// Starting an IM? The IM will popup by AJAX once the page loads, because it's in the system now
		$enter_im=get_param_integer('enter_im',NULL);
		if (!is_null($enter_im))
		{
			require_code('chat2');
			buddy_add(get_member(),$enter_im);

			$you=$GLOBALS['FORUM_DRIVER']->get_username(get_member());
			$them=$GLOBALS['FORUM_DRIVER']->get_username($enter_im);
			attach_message('Instant messaging has been disabled on this site, but you can arrange with members to connect via XMPP software (create a Private Topic, asking them to use XMPP, and tell them your username is '.escape_html($you).' &ndash; we have auto-added '.escape_html($them).' as an contact in your XMPP software).','warn');
		}

		// Generic stuff: Title, feed URL
		$title=get_page_title('CHAT_LOBBY');

		// Rooms
		$room_url=build_url(array('page'=>'_SELF','type'=>'room','id'=>'room_id'),'_SELF');
		$fields='
			<ul id="rooms"></ul>
		';

		$seteffectslink=hyperlink(build_url(array('page'=>'_SELF','type'=>'set_effects'/*,'redirect'=>get_self_url(true,true)*/),'_SELF'),do_lang_tempcode('CHAT_SET_EFFECTS'),true);

		$buddies=array();
		$buddy_rows=$GLOBALS['SITE_DB']->query_select('chat_buddies',array('*'),array('member_likes'=>get_member()));
		foreach ($buddy_rows as $br)
		{
			$u=$GLOBALS['FORUM_DRIVER']->get_username($br['member_liked']);
			if (!is_null($u))
				$buddies[]=array('USERNAME'=>$u);
		}

		$password_hash=$GLOBALS['FORUM_DRIVER']->get_member_row_field(get_member(),'m_pass_hash_salted');
		return do_template('CHAT_LOBBY_SCREEN',array('_GUID'=>'f82ddfd0dccbd25752dd05a1d87429e2','ROOM_URL'=>$room_url,'BUDDIES'=>$buddies,'PASSWORD_HASH'=>$password_hash,'CHAT_SOUND'=>get_chat_sound_tpl(),'TITLE'=>$title,'ROOMS'=>$fields,'SETEFFECTS_LINK'=>$seteffectslink));
	}

	/**
	 * The UI for a chat room.
	 *
	 * @return tempcode		The UI
	 */
	function chat_room()
	{
		require_javascript('javascript_yahoo_2');
		require_javascript('javascript_colour_picker');
		require_javascript('javascript_posting');
		require_css('colour_picker');

		$prefs=@$_COOKIE['ocp_chat_prefs'];
		$prefs=@explode(';',$prefs);
		//$mode=get_param('mode','');
		$room_id=get_param('id');

		$posting_name=do_lang_tempcode('SEND_MESSAGE');

		$cs_post_url=build_url(array('page'=>'_SELF','type'=>'options','id'=>$room_id),'_SELF');

		$yourname=$GLOBALS['FORUM_DRIVER']->get_username(get_member());

		$debug=(get_param_integer('debug',0)==1)?'block':'none';

		$title=get_page_title('ROOM');

		$seteffectslink=hyperlink(build_url(array('page'=>'_SELF','type'=>'set_effects'/*,'redirect'=>get_self_url(true,true)*/),'_SELF'),do_lang_tempcode('CHAT_SET_EFFECTS'),true);
		$logslink=hyperlink(get_base_url().'/data_custom/jabber-logs/'.strtolower($room_id).'@conference.'.get_domain(),'Chat logs',true);

		$links=array(
			$seteffectslink,
			$logslink,
		);

		breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('CHAT_LOBBY_END_CHAT'))));

		$messages_php=find_script('messages');
		$password_hash=$GLOBALS['FORUM_DRIVER']->get_member_row_field(get_member(),'m_pass_hash_salted');
		return do_template('CHAT_SCREEN',array('_GUID'=>'867a0b050c050c81d33482d131783eb0','MESSAGES_PHP'=>$messages_php,'PASSWORD_HASH'=>$password_hash,'CHAT_SOUND'=>get_chat_sound_tpl(),'ROOM_ID'=>$room_id,'DEBUG'=>$debug,'OPTIONS_URL'=>$cs_post_url,'ROOM_NAME'=>'','YOUR_NAME'=>$yourname,'SUBMIT_VALUE'=>$posting_name,'INTRODUCTION'=>'','TITLE'=>$title,'LINKS'=>$links));
	}

	/**
	 * Save the user's options into a cookie.
	 *
	 * @return tempcode		The UI
	 */
	function chat_options()
	{
		$title=get_page_title('ROOM');

		$value=post_param('text_colour',get_option('chat_default_post_colour')).';'.post_param('font_name',get_option('chat_default_post_font')).';';
		require_code('users_active_actions');
		ocp_setcookie('ocp_chat_prefs',$value);

		$url=build_url(array('page'=>'_SELF','type'=>'room','id'=>get_param('id'),'no_reenter_message'=>1),'_SELF');
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}

}
