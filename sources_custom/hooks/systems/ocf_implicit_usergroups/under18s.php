<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Hook_implicit_usergroups_under18s
{

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds the group IDs it is bound to.
	 *
	 * @return array		A list of usergroup IDs.
	 */
	function get_bound_group_ids()
	{
		return array(10); // Probation on standard install; customise as required
	}

	function _where()
	{
		$eago=intval(date('Y'))-18;
		return 'm_dob_year>'.strval($eago).' OR m_dob_year='.strval($eago).' AND (m_dob_month>'.date('m').' OR m_dob_month='.date('m').' AND m_dob_day>='.date('d').')';
	}

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds all members in the group.
	 *
	 * @param  GROUP		The group ID to check (if only one group supported by the hook, can be ignored).
	 * @return ?array		The list of members as a map between member ID and member row (NULL: unsupported by hook).
	 */
	function get_member_list($group_id)
	{
		return list_to_map('id',$GLOBALS['FORUM_DB']->query('SELECT * FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE '.$this->_where()));
	}

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds all members in the group.
	 *
	 * @param  GROUP		The group ID to check (if only one group supported by the hook, can be ignored).
	 * @return ?array		The list of members (NULL: unsupported by hook).
	 */
	function get_member_list_count($group_id)
	{
		return $GLOBALS['FORUM_DB']->query_value_if_there('SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE '.$this->_where());
	}

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds whether the member is within the implicit usergroup.
	 *
	 * @param  MEMBER		The member ID.
	 * @param  GROUP		The group ID to check (if only one group supported by the hook, can be ignored).
	 * @return boolean	Whether they are.
	 */
	function is_member_within($member_id,$group_id)
	{
		return !is_null($GLOBALS['FORUM_DB']->query_value_if_there('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE ('.$this->_where().') AND id='.strval($member_id)));
	}

}


