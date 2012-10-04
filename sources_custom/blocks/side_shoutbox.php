<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		chat
 */

class Block_side_shoutbox
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
		$info['version']=3;
		$info['locked']=false;
		$info['parameters']=array('param','max');
		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_lang('chat');
		require_css('chat');

		require_javascript('javascript_text_ghosts');
		require_javascript('javascript_shake');
		require_javascript('javascript_shoutbox');
		require_javascript('javascript_ajax');

		$room_id=array_key_exists('param',$map)?intval($map['param']):NULL;
		$num_messages=array_key_exists('max',$map)?intval($map['max']):5;

		if (is_null($room_id))
		{
			$room_id=$GLOBALS['SITE_DB']->query_value_null_ok('chat_rooms','MIN(id)',array('is_im'=>0/*,'room_language'=>user_lang()*/));
			if (is_null($room_id)) return new ocp_tempcode();
		}

		$room_check=$GLOBALS['SITE_DB']->query_select('chat_rooms',array('*'),array('id'=>$room_id),'',1);
		if (!array_key_exists(0,$room_check)) return new ocp_tempcode();
		require_code('chat');
		if (!check_chatroom_access($room_check[0],true))
		{
			global $DO_NOT_CACHE_THIS; // We don't cache against access, so we have a problem and can't cache
			$DO_NOT_CACHE_THIS=true;

			return new ocp_tempcode();
		}

		$content=NULL;
		if (get_value('no_frames')==='1')
		{
			require_code('chat_shoutbox');
			$content=shoutbox_script(true,$room_id);
		}

		$last_message_id=$GLOBALS['SITE_DB']->query_value('chat_messages','MAX(id)',array('room_id'=>$room_id));
		if (is_null($last_message_id)) $last_message_id=-1;

		return do_template('BLOCK_SIDE_SHOUTBOX_IFRAME',array('LAST_MESSAGE_ID'=>strval($last_message_id),'CONTENT'=>$content,'ROOM_ID'=>strval($room_id),'NUM_MESSAGES'=>strval($num_messages)));
	}

}


