<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

if (!running_script('tracker'))
{
	$params='';
	foreach ($map as $key=>$val)
	{
		$params.=($params=='')?'?':'&';
		$params.=$key.'='.urlencode($val);
	}
	$frame_name='frame_'.uniqid('');
	echo '
		<div style="padding: 1em">
			<iframe title="Tracker" frameborder="0" name="'.$frame_name.'" id="'.$frame_name.'" marginwidth="0" marginheight="0" class="expandable_iframe" scrolling="no" src="'.find_script('tracker').$params.'">Tracker</iframe>
		</div>

		<script type="text/javascript">// <![CDATA[
			window.setInterval(function() {
				if ((typeof window.frames[\''.$frame_name.'\']!=\'undefined\') && (typeof window.frames[\''.$frame_name.'\'].trigger_resize!=\'undefined\')) resizeFrame(\''.$frame_name.'\');
			}, 1000);
		//]]></script>
	';
	return;
}

require_code('xhtml');

$max=get_param_integer('mantis_max',10);
$start=get_param_integer('mantis_start',0);

$db=new database_driver(get_db_site(),get_db_site_host(),get_db_site_user(),get_db_site_password(),'');

$where='duplicate_id=0';
$where.=' AND view_state=10';
if (isset($map['completed'])) $where.=' AND '.(($map['completed']=='0')?'a.status<=50':'a.status=80');
if (isset($map['voted'])) $where.=' AND ('.(($map['voted']=='1')?'a.reporter_id='.strval(get_member()).' OR  EXISTS':'NOT EXISTS').' (SELECT * FROM mantis_bug_monitor_table p WHERE user_id='.strval(get_member()).' AND p.bug_id=a.id))';
if (isset($map['project'])) $where.=' AND a.project_id='.strval(intval($map['project']));

$order='id';

if (isset($map['sort']))
{
	list($sort,$direction)=explode(' ',$map['sort'],2);
	if (($direction!='ASC') && ($direction!='DESC')) $direction='DESC';
	switch ($sort)
	{
		case 'popular':
			$order='num_votes '.$direction;
			break;
		case 'added':
			$order='date_submitted '.$direction;
			break;
		case 'hours':
			$order='hours '.$direction;
			$where.=' AND '.db_string_not_equal_to('c.value','');
			break;
	}
}

$max_rows=$db->query_value_if_there('SELECT COUNT(*) FROM mantis_bug_table a JOIN mantis_bug_text_table b ON b.id=a.bug_text_id JOIN mantis_custom_field_string_table c ON c.bug_id=a.id AND field_id=3 WHERE '.$where);
$query='SELECT a.*,b.description,(SELECT COUNT(*) FROM mantis_bugnote_table x WHERE x.bug_id=a.id) AS num_comments,(SELECT COUNT(*) FROM mantis_bug_monitor_table y WHERE y.bug_id=a.id) AS num_votes,(SELECT SUM(amount) FROM mantis_sponsorship_table z WHERE z.bug_id=a.id) AS money_raised,CAST(c.value AS DECIMAL) as hours,d.name AS category FROM mantis_bug_table a JOIN mantis_bug_text_table b ON b.id=a.id JOIN mantis_custom_field_string_table c ON c.bug_id=a.id AND field_id=3 JOIN mantis_category_table d ON d.id=a.category_id WHERE '.$where.' ORDER BY '.$order;

$issues=$db->query($query,$max,$start);

if (count($issues)==0)
{
	echo '<p class="nothing_here">Nothing here yet! Maybe you should add something.</p>';
} else
{
	echo '<div style="font-size: 0.9em">';
	
	foreach ($issues as $issue)
	{
		$title=$issue['category'].': '.$issue['summary'];
		$description=$issue['description'];
		$votes=intval($issue['num_votes']);
		$cost=($issue['hours']==0 || is_null($issue['hours']))?mixed():($issue['hours']*5.5*6);
		$money_raised=$issue['money_raised'];
		$suggested_by=$issue['reporter_id'];
		$add_date=$issue['date_submitted'];
		$vote_url='http://ocportal.com/tracker/bug_monitor_add.php?bug_id='.strval($issue['id']);
		$unvote_url='http://ocportal.com/tracker/bug_monitor_delete.php?bug_id='.strval($issue['id']);
		$voted=!is_null($db->query_select_value_if_there('mantis_bug_monitor_table','user_id',array('user_id'=>get_member(),'bug_id'=>$issue['id'])));
		$full_url='http://ocportal.com/tracker/view.php?id='.strval($issue['id']);
		$num_comments=$issue['num_comments'];

		$_cost=is_null($cost)?'unknown':(static_evaluate_tempcode(comcode_to_tempcode('[currency="GBP"]'.float_to_raw_string($cost).'[/currency]')));
		$_money_raised=static_evaluate_tempcode(comcode_to_tempcode('[currency="GBP"]'.float_to_raw_string($money_raised).'[/currency]'));
		$_hours=is_null($cost)?'unknown':(escape_html(number_format($issue['hours'])).' hours');
		$_credits=is_null($cost)?'unknown':(escape_html(number_format($issue['hours']*6)).' credits');
		$_percentage=is_null($cost)?'unknown':(escape_html(float_format(100.0*$money_raised/$cost,0)).'%');

		$out='';
		$out.='
			<div style="float: left; width: 140px; text-align: center; border: 1px solid #AAA" class="medborder">
				<p style="font-size: 1.5em"><strong>'.escape_html(number_format($votes)).'</strong> '.(($votes==1)?'vote':'votes').'</p>
		';

		if (!$voted)
		{
			$out.='
					<p onclick="this.style.border=\'1px dotted blue\';"><a style="text-decoration: none" target="_blank" href="'.escape_html($vote_url).'"><img style="vertical-align: middle" src="'.find_theme_image('tracker/plus').'" /> <span style="vertical-align: middle">Vote</span></a></p>
			';
		} else
		{
			$out.='
					<p onclick="this.style.border=\'1px dotted blue\';"><a style="text-decoration: none" target="_blank" href="'.escape_html($unvote_url).'"><img style="vertical-align: middle" src="'.find_theme_image('tracker/minus').'" /> <span style="vertical-align: middle">Unvote</span></a></p>
			';
		}

		$out.='
				<p style="font-size: 0.8em">
					Raised '.$_percentage.' of '.$_credits;
		if (!is_null($cost))
		$out.='
					<br />
					<span class="associated_details">('.$_credits.' = '.$_hours.' or '.$_cost.')</span>';
		$out.='
				</p>
			</div>

			<div style="margin-left: 150px">
				<p style="min-height: 7.5em">'.xhtml_substr(nl2br(escape_html($description)),0,310,false,true).'</p>

				<p style="float: right; margin-bottom: 0" class="associated_details" style="color: #777">Suggested by '.static_evaluate_tempcode($GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($suggested_by)).' on '.escape_html(get_timezoned_date($add_date,false)).'</p>

				<p class="associated_link_to_small" style="float: left; margin-bottom: 0">&raquo; <a href="'.escape_html($full_url).'">Full details and sponsorship</a> ('.escape_html(number_format($num_comments)).' '.(($num_comments!=1)?'comments':'comment').')</p>
			</div>
		';

		echo static_evaluate_tempcode(put_in_standard_box(make_string_tempcode($out),$title,'curved_turquoise'));
	}
	
	echo '</div>';
}

require_code('templates_pagination');
$results_browser=pagination(make_string_tempcode('Issues'),$start,'mantis_start',$max,'mantis_max',$max_rows);
echo '<div class="float_surrounder">';
echo str_replace(get_base_url().((get_zone_name()=='')?'':'/').get_zone_name().'/index.php',find_script('tracker'),$results_browser->evaluate());
echo '</div>';
