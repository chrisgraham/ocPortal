<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

require_code('ocf_groups');
require_code('ocf_members');

echo '<div class="wide_table_wrap"><table class="wide_table results_table spaced_table autosized_table">';
echo '<tr><th>Avatar</th><th>Details</th><th>Signature</th></tr>';

$gifts=$GLOBALS['SITE_DB']->query('SELECT gift_to,SUM(amount) as cnt FROM '.get_table_prefix().'gifts g LEFT JOIN '.get_table_prefix().'translate t ON t.id=g.reason WHERE text_original LIKE \''.db_encode_like($map['param']).': %\' AND gift_from<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' GROUP BY gift_to ORDER BY cnt DESC',10);
$count=0;
foreach ($gifts as $gift)
{
	$member_id=$gift['gift_to'];
	$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
	if (!is_null($username))
	{
		$link=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id);
		$avatar_url=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);
		$signature=get_translated_tempcode($GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id,'m_signature'),$GLOBALS['FORUM_DB']);
		$points=$gift['cnt'];
		$rank=get_translated_text(ocf_get_group_property(ocf_get_member_primary_group($member_id),'name'),$GLOBALS['FORUM_DB']);
		if ($avatar_url=='')
		{
			$avatar='';
		} else
		{
			$avatar='<img style="max-width: 100%" alt="" src="'.escape_html($avatar_url).'" />';
		}
		echo '<tr><td>'.$avatar.'</td><td>Username: <a href="'.escape_html($link).'">'.escape_html($username).'</a><br /><br />Role points: '.integer_format($points).'<br /><br />Rank: '.$rank.'</td><td style="font-size: 0.8em;">'.$signature->evaluate().'</td></tr>';

		$count++;
	}
}
if ($count==0)
{
	echo '<tr><td colspan="3" style="font-weight: bold; padding: 10px">Nobody yet &ndash; could you be here?</td></tr>';
}

echo '</table></div>';
