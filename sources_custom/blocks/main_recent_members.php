<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_ocf
 */

class Block_main_recent_members
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
		$info['parameters']=array('max','filter');
		return $info;
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(array_key_exists(\'max\',$map)?intval($map[\'max\']):10,array_key_exists(\'filter\',$map)?$map[\'filter\']:\'*\')';
		$info['ttl']=60;
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
		$number=array_key_exists('max',$map)?intval($map['max']):10;
		$filter=array_key_exists('filter',$map)?$map['filter']:'*';

		$out=new ocp_tempcode();

		require_code('ocf_members');
		require_code('ocf_members2');
		require_code('ocfiltering');

		$sql_filter=ocfilter_to_sqlfragment($filter,'m_primary_group');
		$sql_filter_2=ocfilter_to_sqlfragment($filter,'gm_group_id');

		$rows=$GLOBALS['FORUM_DB']->query('SELECT m.* FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_group_members g ON (m.id=g.gm_member_id AND gm_validated=1) LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_custom_fields f ON m.id=f.mf_member_id WHERE (('.$sql_filter.') OR ('.$sql_filter_2.')) AND id<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).(can_arbitrary_groupby()?' GROUP BY m.id':'').' ORDER BY m.m_join_time DESC',$number);
		$rows=remove_duplicate_rows($rows,'id');

		if (count($rows)==0)
		{
			return do_template('BLOCK_NO_ENTRIES',array('HIGH'=>false,'TITLE'=>do_lang_tempcode('RECENT',make_string_tempcode(integer_format($number)),do_lang_tempcode('MEMBERS')),'MESSAGE'=>do_lang_tempcode('NO_ENTRIES'),'ADD_NAME'=>'','SUBMIT_URL'=>''));
		} else
		{
			foreach ($rows as $i=>$row)
			{
				if ($i!=0) $out->attach(do_template('BLOCK_SEPARATOR'));
				$out->attach(ocf_show_member_box($row['id'],true));
			}
		}

		return $out;
	}

}


