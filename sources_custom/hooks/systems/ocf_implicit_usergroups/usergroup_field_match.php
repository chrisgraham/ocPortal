<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Hook_implicit_usergroups_usergroup_field_match
{

	function _get_structure()
	{
		if (!function_exists('get_translated_text')) return array();

		static $out=NULL;
		if ($out!==NULL) return $out;

		$out=array();
		$_groups=$GLOBALS['FORUM_DB']->query_select('f_groups',array('id','g_name'),array('g_open_membership'=>1));
		$groups=array();
		foreach ($_groups as $g)
		{
			$groups[get_translated_text($g['g_name'],$GLOBALS['FORUM_DB'])]=$g['id'];
		}

		$list_cpfs=$GLOBALS['FORUM_DB']->query_select('f_custom_fields',array('id','cf_default'),array('cf_type'=>'list'));
		foreach ($list_cpfs as $c)
		{
			$values=explode('|',$c['cf_default']);
			foreach ($values as $v)
			{
				if (($v!='') && (isset($groups[$v])))
				{
					if (!isset($out[$groups[$v]])) $out[$groups[$v]]=array();
					$out[$groups[$v]][]=array($c['id'],$v);	// group id => [ {CPF id, CPF value / group name} ]
				}
			}
		}

		return $out;
	}

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds the group IDs it is bound to.
	 *
	 * @return array		A list of usergroup IDs.
	 */
	function get_bound_group_ids()
	{
		return array_keys($this->_get_structure());
	}

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds all members in the group.
	 *
	 * @param  GROUP		The group ID to check (if only one group supported by the hook, can be ignored).
	 * @return ?array		The list of members as a map between member ID and member row (NULL: unsupported by hook).
	 */
	function get_member_list($group_id)
	{
		$out=array();

		$structure=$this->_get_structure();
		$for_group=$structure[$group_id];
		foreach ($for_group as $pairs)
		{
			$cpf_key='field_'.strval($pairs[0]);
			$_members=$GLOBALS['FORUM_DB']->query_select('f_member_custom_fields',array('mf_member_id'),array($cpf_key=>$pairs[1]));
			foreach ($_members as $m)
			{
				$member_id=$m['mf_member_id'];
				$out[$member_id]=$GLOBALS['FORUM_DRIVER']->get_member_row($member_id);
			}
		}

		return $out;
	}

	/**
	 * Standard modular run function for implicit usergroup hooks. Finds all members in the group.
	 *
	 * @param  GROUP		The group ID to check (if only one group supported by the hook, can be ignored).
	 * @return ?array		The list of members (NULL: unsupported by hook).
	 */
	function get_member_list_count($group_id)
	{
		$structure=$this->_get_structure();
		$for_group=$structure[$group_id];

		if (count($for_group)==1)
		{
			$pairs=$for_group[0];
			$cpf_key='field_'.strval($pairs[0]);
			return $GLOBALS['FORUM_DB']->query_value('f_member_custom_fields','COUNT(*)',array($cpf_key=>$pairs[1]));
		} else // Much more complex if multiple CPFs are mapped, we need to find all and de-dupe
		{
			$out=array();

			foreach ($for_group as $pairs)
			{
				$cpf_key='field_'.strval($pairs[0]);
				$_members=$GLOBALS['FORUM_DB']->query_select('f_member_custom_fields',array('mf_member_id'),array($cpf_key=>$pairs[1]));
				foreach ($_members as $m)
				{
					$member_id=$m['mf_member_id'];
					$out[$member_id/*automatic de-dupe*/]=true;
				}
			}

			return count($out);
		}

		return NULL; // Should not get here
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
		static $cache=array(); // So finding if member in each, is quick

		$structure=$this->_get_structure();
		$for_group=$structure[$group_id];

		foreach ($for_group as $pairs)
		{
			$cpf_key='field_'.strval($pairs[0]);

			if (isset($cache[$member_id][$cpf_key]))
			{
				$cpf_value_actual=$cache[$member_id][$cpf_key];
			} else
			{
				$cpf_value_actual=$GLOBALS['FORUM_DB']->query_value_null_ok('f_member_custom_fields',$cpf_key,array('mf_member_id'=>$member_id));
				$cache[$member_id][$cpf_key]=$cpf_value_actual;
			}

			if ($cpf_value_actual==$pairs[1]) return true;
		}

		return false;
	}

}


