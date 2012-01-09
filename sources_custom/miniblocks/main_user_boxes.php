<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

if (!isset($map['max'])) $map['max']='10';

require_code('ocf_members');
require_code('ocf_members2');
$members=$GLOBALS['FORUM_DRIVER']->member_group_query(array(intval($map['param'])),intval($map['max']));
global $M_SORT_KEY;
$M_SORT_KEY='id';
usort($members,'multi_sort');
$members=array_reverse($members);
foreach ($members as $i=>$member)
{
	if ($i==intval($map['max'])) break;
	
	$tpl=ocf_show_member_box($member['id']);
	$tpl->evaluate_echo();
	echo '<br />';
}
