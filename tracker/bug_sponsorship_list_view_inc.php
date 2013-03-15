<?php
# MantisBT - a php based bugtracking system

# MantisBT is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# MantisBT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MantisBT.  If not, see <http://www.gnu.org/licenses/>.

	/**
	 * This include file prints out the list of users sponsoring the current
	 * bug.	$f_bug_id must be set to the bug id
	 *
	 * @package MantisBT
	 * @copyright Copyright (C) 2000 - 2002  Kenzaburo Ito - kenito@300baud.org
	 * @copyright Copyright (C) 2002 - 2010  MantisBT Team - mantisbt-dev@lists.sourceforge.net
	 * @link http://www.mantisbt.org
	 */

	require_once( 'sponsorship_api.php' );
	require_once( 'collapse_api.php' );

	#
	# Determine whether the sponsorship section should be shown.
	#

	if ( ( config_get( 'enable_sponsorship' ) == ON ) && ( access_has_bug_level( config_get( 'view_sponsorship_total_threshold' ), $f_bug_id ) ) ) {
		$t_sponsorship_ids = sponsorship_get_all_ids( $f_bug_id );

		$t_sponsorships_exist = count( $t_sponsorship_ids ) > 0;
		$t_can_sponsor = !bug_is_readonly( $f_bug_id ) && !current_user_is_anonymous();

		$t_show_sponsorships = $t_sponsorships_exist || $t_can_sponsor;
	} else {
		$t_show_sponsorships = false;
	}

	#
	# Sponsorship Box
	#

	if ( $t_show_sponsorships ) {
?>

<a name="sponsorships" id="sponsorships"></a> <br />

<?php
	collapse_open( 'sponsorship' );
?>

<table class="width100" cellspacing="1">
	<tr>
		<td width="50" rowspan="5">
			<img src="images/dollars.gif" alt="<?php echo lang_get( 'sponsor_verb' ) ?>" border="0" />
		</td>
		<td class="form-title" colspan="2">
		<?php 
			collapse_icon( 'sponsorship' );

			echo lang_get( 'users_sponsoring_bug' );

			$t_details_url = lang_get( 'sponsorship_process_url' );
			if ( !is_blank( $t_details_url ) ) {
				echo '&nbsp;[<a href="' . $t_details_url . '" target="_blank">'
					. lang_get( 'sponsorship_more_info' ) . '</a>]';
			}
		?>
		</td>
	</tr>

<?php
	$gbp_needed = $hours*6*5.5;

	if ( $t_can_sponsor ) {

		$result=db_query_bound('SELECT f.id FROM ocp2_f_custom_fields f LEFT JOIN ocp2_translate t ON f.cf_name=t.id WHERE text_original=\'ocp_support_credits\'',array());
		$field_num = db_fetch_array( $result );

		$result=db_query_bound('SELECT field_'.strval($field_num['id']).' AS result FROM ocp2_f_member_custom_fields WHERE mf_member_id='.auth_get_current_user_id(),array());
		$num_credits = db_fetch_array( $result );
		$credits_available=isset($num_credits['result'])?$num_credits['result']:0;
		if ($credits_available=='') $credits_available=0;

		$result=db_query_bound('SELECT SUM(amount) AS result FROM mantis_sponsorship_table s JOIN mantis_bug_table b ON s.bug_id=b.id WHERE status<80 AND user_id='.auth_get_current_user_id(),array());
		$amount_sponsored = db_fetch_array( $result );
		$total_user_sponsored=isset($amount_sponsored['result'])?$amount_sponsored['result']:0;
		if ($total_user_sponsored=='') $total_user_sponsored=0;
		$credits_available_real=$credits_available;
		$credits_sponsored=intval(round($total_user_sponsored/5.5));
		$credits_available-=$credits_sponsored;

		$result=db_query_bound('SELECT SUM(amount) AS result FROM mantis_sponsorship_table WHERE bug_id='.$f_bug_id,array());
		$amount_sponsored = db_fetch_array( $result );
		$t_total_sponsorship=isset($amount_sponsored['result'])?$amount_sponsored['result']:0;
		if ($t_total_sponsorship=='') $t_total_sponsorship=0;

?>
	<tr class="row-1">
		<td class="category" width="15%"><?php echo lang_get( 'sponsor_issue' ) ?> / Cost</td>
		<td>
			<form method="post" action="bug_set_sponsorship.php">
				<?php if ($hours!=0) { ?>
				<p>At <?php echo number_format(floatval($hours)); ?> hours, this would cost <?php echo number_format($hours*6); ?> support credits at budget priority (&pound;<?php echo number_format($gbp_needed); ?> GBP [ <a href="http://www.xe.com/ucc/convert/?Amount=<?php echo strval($gbp_needed); ?>&amp;From=GBP&amp;To=USD" target="_blank">convert to USD etc</a> ] ). If this is reached and sponsors have this much in their accounts, ocProducts will prioritise the feature and release the code early in this tracker. If a feature is not sponsored then it may also be done anyway, but there is no guarantee that any features posted in the tracker are planned as ocPortal is non-commercial and no roadmap is maintained. <strong>Important:</strong> all the normal commercial work guidelines apply to sponsored work, the time quote is only valid for the developers <em>interpretation</em> of what was written up for the task at the time for the hour-estimate, and may be <em>subject to re-review</em> before work begins. In short, make sure you are patient and very clear and precise.</p>
				<?php } ?>
				<p>Please be aware that even with sponsorship a requested feature may not end up in the main ocPortal distribution, to avoid software bloat.</p>

				<?php echo form_security_field( 'bug_set_sponsorship' ) ?>
				<input type="hidden" name="bug_id" value="<?php echo $f_bug_id ?>" size="4" />
				<p>
					<label><input type="text" name="amount_credits" onblur="if (this.value.match(/^\d+$/)) this.form.elements['amount'].value=this.value*5.5;" value="" size="20" /> Amount in support credits</label><br />You currently have <?php echo strval($credits_available); ?> support credits. If you sponsor more than this, you will be able to buy more credits after clicking the 'Sponsor' button' (next to your listed sponsorship).<br />
					<span style="display: none">or&hellip;<label><input type="text" name="amount" onblur="if (this.value.match(/^\d+$/)) this.form.elements['amount_credits'].value=Math.ceil(this.value/5.5);" value="" size="20" /> Amount in GBP</label></span>
				</p>
				<p>
					<input type="submit" class="button" name="sponsor" value="<?php echo lang_get( 'sponsor_verb' ) ?>" />
				</p>
				<?php
				foreach ( $t_sponsorship_ids as $id ) {
					$t_sponsorship = sponsorship_get( $id );
					if ($t_sponsorship->user_id==auth_get_current_user_id()) {
				?>
				<p>
					Filling in this form replaces your previous sponsorship, it does not add to it. To remove re-sponsor with zero.
				</p>
				<?php
					}
				}
				?>
			</form>
		</td>
	</tr>
<?php
	}

	//$t_total_sponsorship = bug_get_field( $f_bug_id, 'sponsorship_total' );		Can get out of sync!
	$t_total_sponsorship_confirmed = 0;
	if ( $t_total_sponsorship > 0 ) {
?>
	<tr class="row-2">
		<td class="category" width="15%"><?php echo lang_get( 'sponsors_list' ) ?></td>
		<td>
		<?php
			/*echo sprintf( lang_get( 'total_sponsorship_amount' ),
				sponsorship_format_amount( $t_total_sponsorship ) ), ' ('.round(floatval($t_total_sponsorship)/5.5).' support credits)';*/

			if ( access_has_bug_level( config_get( 'view_sponsorship_details_threshold' )
				, $f_bug_id ) ) {
				//echo '<br /><br />';
				$i = 0;
				foreach ( $t_sponsorship_ids as $id ) {
					$t_sponsorship = sponsorship_get( $id );
					$t_date_added = date( config_get( 'normal_date_format' )
						, $t_sponsorship->date_submitted );

					echo ($i > 0) ? '<br />' : '';
					$i++;

					echo $t_date_added . ': ';
					print_user( $t_sponsorship->user_id );
					echo ' - ' , sponsorship_format_amount( $t_sponsorship->amount ) , ' ('.round(floatval($t_sponsorship->amount)/5.5).' support credits)';
					if ( access_has_bug_level( config_get( 'handle_sponsored_bugs_threshold' ), $f_bug_id ) ) {
						echo ' ' . get_enum_element( 'sponsorship', $t_sponsorship->paid );
					}
					
					$result=db_query_bound('SELECT f.id FROM ocp2_f_custom_fields f LEFT JOIN ocp2_translate t ON f.cf_name=t.id WHERE text_original=\'ocp_support_credits\'',array());
					$field_num = db_fetch_array( $result );
					$result=db_query_bound('SELECT field_'.strval($field_num['id']).' AS result FROM ocp2_f_member_custom_fields WHERE mf_member_id='.$t_sponsorship->user_id,array());
					$num_credits = db_fetch_array( $result );
					if ($num_credits['result']*5.5>=$t_sponsorship->amount)
					{
						echo ' - backed by existing support credits';
						$t_total_sponsorship_confirmed += $t_sponsorship->amount;
					} else
					{
						echo ' - not backed by existing support credits';
						if ($t_sponsorship->user_id==auth_get_current_user_id())
						{
							echo ' - <a href="http://ocportal.com/site/commercial_support.htm" target="_blank">buy some</a>';
						}
					}
				}
			}
		?>
		</td>
		</tr>
		<tr class="row-1">
			<td class="category" width="15%">Funding progress (theory)</td>
			<td>
				<progress style="width: 100%" value="<?php echo $t_total_sponsorship; ?>" max="<?php echo $gbp_needed; ?>"></progress>
				<?php echo round(100*$t_total_sponsorship/$gbp_needed).'% ('.round(($gbp_needed-$t_total_sponsorship)/5.5).' credits remaining)'; ?>
			</td>
		</tr>
		<?php if ($tpl_bug->status!=80) { ?>
		<tr class="row-1">
			<td class="category" width="15%">Funding progress (paid up)</td>
			<td>
				<progress style="width: 100%" value="<?php echo $t_total_sponsorship_confirmed; ?>" max="<?php echo $gbp_needed; ?>"></progress>
				<?php echo round(100*$t_total_sponsorship_confirmed/$gbp_needed).'% ('.round(($gbp_needed-$t_total_sponsorship_confirmed)/5.5).' credits remaining)'; ?>
			</td>
		</tr>
		<?php } ?>
<?php
		}
?>
</table>

<?php
	collapse_closed( 'sponsorship' );
?>

<table class="width100" cellspacing="1">
	<tr>
		<td class="form-title">
<?php
			collapse_icon( 'sponsorship' );
			echo lang_get( 'users_sponsoring_bug' );

			$t_details_url = lang_get( 'sponsorship_process_url' );
			if ( !is_blank( $t_details_url ) ) {
				echo '&nbsp;[<a href="' . $t_details_url . '" target="_blank">'
					. lang_get( 'sponsorship_more_info' ) . '</a>]';
			}

	//$t_total_sponsorship = bug_get_field( $f_bug_id, 'sponsorship_total' );
	if ( $t_total_sponsorship > 0 ) {
		echo ' <span style="font-weight: normal;">(';
		echo sprintf( lang_get( 'total_sponsorship_amount' ),
			sponsorship_format_amount( $t_total_sponsorship ) );
		echo ')</span>';
	}
?>
		</td>
	</tr>
</table>

<?php
	collapse_end( 'sponsorship' );
} # If sponsorship enabled
