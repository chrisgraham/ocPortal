<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('init__forum__ocf'))
{
	function init__forum__ocf($in=NULL)
	{
		if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.

		$in=str_replace("return \$this->get_member_row_field(\$member,'m_username');","return ocjester_name_filter(\$this->get_member_row_field(\$member,'m_username'));",$in);

		$in=str_replace(
			'$avatar=$this->get_member_row_field($member,\'m_avatar_url\');',
			'require_code(\'ocfiltering\'); $passes=(count(array_intersect(@ocfilter_to_idlist_using_memory(get_option(\'ocjester_avatar_switch_shown_for\',true),$GLOBALS[\'FORUM_DRIVER\']->get_usergroup_list()),$GLOBALS[\'FORUM_DRIVER\']->get_members_groups(get_member())))!=0);
			if ($passes) $avatar=($member==get_member())?\'\':$this->get_member_row_field(get_member(),\'m_avatar_url\'); else $avatar=$this->get_member_row_field($member,\'m_avatar_url\');',
			$in);

		return $in;
	}
}

function ocjester_name_filter($in)
{
	$option=get_option('ocjester_name_changes',true);
	if ($option=='') return $in;

	require_code('ocfiltering');

	$passes=(count(array_intersect(@ocfilter_to_idlist_using_memory(get_option('ocjester_name_changes_shown_for',true),$GLOBALS['FORUM_DRIVER']->get_usergroup_list()),$GLOBALS['FORUM_DRIVER']->get_members_groups(get_member())))!=0);
	if (!$passes) return $in;

	$alphabetic=@explode("\n",$option);

	if (strtoupper($in[0])!=strtolower($in[0]))
	{
		return $alphabetic[ord(strtoupper($in[0]))-ord('A')].' '.$in;
	}
	return $in;
}
