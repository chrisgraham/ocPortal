<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

require_code('ocf_members');
$fields=ocf_get_all_custom_fields_match(NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL);

$field_id=NULL;
foreach ($fields as $field)
{
	if ($field['trans_name']=='ocp_support_credits')
	{
		$field_id=$field['id'];
		break;
	}
}

echo '<h1>Unspent credits</h1>';

echo '<div class="wide_table_wrap"><table class="solidborder wide_table"><thead><tr><th>Username</th><th>Credits</th><th>Join date</th></tr></thead><tbody>';

$members=$GLOBALS['FORUM_DB']->query('SELECT mf_member_id,CAST(field_'.strval($field_id).' AS UNSIGNED) AS field_'.strval($field_id).' FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_custom_fields WHERE '.db_string_not_equal_to('field_'.strval($field_id),'').' AND CAST(field_'.strval($field_id).' AS UNSIGNED)>0 ORDER BY CAST(field_'.strval($field_id).' AS UNSIGNED) DESC');
$total=0;
foreach ($members as $member)
{
	$credits=$member['field_'.strval($field_id)];
	
	echo '<tr>';
	echo '<td>'.static_evaluate_tempcode($GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($member['mf_member_id'])).'</td>';
	echo '<td>'.number_format($credits).'</td>';
	echo '<td>'.get_timezoned_date($GLOBALS['FORUM_DRIVER']->get_member_join_timestamp($member['mf_member_id'])).'</td>';
	echo '</tr>';
	
	$total+=$credits;
}

echo '<tfoot><tr><td></td><td style="font-weight: bold">'.number_format($total).'</td><td></td></tr></tfoot>';

echo '</tbody></table>';
