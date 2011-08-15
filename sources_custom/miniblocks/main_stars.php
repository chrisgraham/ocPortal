<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

require_code('ocf_groups');
require_code('ocf_members');

echo '<div class="wide_table_wrap"><table class="wide_table solidborder"><colgroup><col style="width: 100px" /><col style="width: 150px" /><col style="width: 100%" /></colgroup>';
echo '<tr><th>Avatar</th><th>Details</th><th>Signature</th></tr>';

$query='SELECT gift_to,SUM(amount) as cnt FROM '.get_table_prefix().'gifts g LEFT JOIN '.get_table_prefix().'translate t ON t.id=g.reason WHERE text_original LIKE \''.db_encode_like($map['param']).': %\' AND gift_from<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' GROUP BY gift_to ORDER BY cnt DESC';

$gifts=$GLOBALS['SITE_DB']->query($query,10);
$count=0;
foreach ($gifts as $gift)
{
	$member_id=$gift['gift_to'];
	$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
	if (!is_null($username))
	{
		$link=$GLOBALS['FORUM_DRIVER']->member_profile_link($member_id,false,true);
		if (is_object($link)) $link=$link->evaluate();
		$avatar_url=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);
		$signature=get_translated_tempcode($GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id,'m_signature'),$GLOBALS['FORUM_DB']);
		$points=$gift['cnt'];
		$rank=ocf_get_group_name(ocf_get_member_primary_group($member_id));
		if ($avatar_url=='')
		{
			$avatar='';
		} else
		{
			$avatar='<img alt="" src="'.escape_html($avatar_url).'" />';
		}
		echo '<tr><td>'.$avatar.'</td><td><a href="'.escape_html($link).'">Username: '.escape_html($username).'</a><br />Role points: '.integer_format($points).'<br />Rank: '.$rank.'</td><td>'.$signature->evaluate().'</td></td>';
		
		$count++;
	}
}
if ($count==0)
{
	echo '<tr><td colspan="3" style="font-weight: bold; padding: 10px">Nobody yet &ndash; could you be here?</td></tr>';
}

echo '</table></div>';
