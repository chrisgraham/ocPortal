<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Hook_members_facebook
{
	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function get_sections($member_id)
	{
		return array(do_template('MEMBER_FACEBOOK',array('_GUID'=>'233c4cf6852e67fd2687dadb2ddff4c1','MEMBER_ID'=>strval($member_id))));
	}
}
