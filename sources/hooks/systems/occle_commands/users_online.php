<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		occle
 */

class Hook_occle_command_users_online
{
	/**
	 * Standard modular run function for OcCLE hooks.
	 *
	 * @param  array	The options with which the command was called
	 * @param  array	The parameters with which the command was called
	 * @param  array	A reference to the OcCLE filesystem object
	 * @return array	Array of stdcommand, stdhtml, stdout, and stderr responses
	 */
	function run($options,$parameters,&$occle_fs)
	{
		if ((array_key_exists('h',$options)) || (array_key_exists('help',$options))) return array('',do_command_help('users_online',array('h'),array()),'','');
		else
		{
			$count=0;
			$members=get_online_members(true,NULL,$count);
			if (is_null($members)) return array('','',do_lang('TOO_MANY_USERS_ONLINE'),'');
			$out=new ocp_tempcode();
			$guests=0;

			$valid_members=array();
			foreach ($members as $member)
			{
				if ((is_guest($member['member_id'])) || (is_null($member['cache_username']))) $guests++;
				else $valid_members[$member['cache_username']]=$member['member_id'];
			}

			return array('',do_template('OCCLE_USERS_ONLINE',array('_GUID'=>'fcf779ef175895d425b706e40fb3252a','MEMBERS'=>$valid_members,'GUESTS'=>integer_format($guests))),'','');
		}
	}

}
