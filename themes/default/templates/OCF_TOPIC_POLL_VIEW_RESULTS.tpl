<!-- Layout table needed due to ensure consistant indentation against unknown width range -->
<div class="wide_table_wrap"><table summary="" class="variable_table dottedborder wide_table ocf_topic_poll">
	<tbody>
		<tr>
			<td colspan="2" class="tabletitle_internal">
				{QUESTION*}
			</td>
		</tr>
		{ANSWERS}
		{+START,IF_NON_EMPTY,{BUTTON}}
			<tr>
				<td colspan="2" class="ocf_poll_button ocf_row7">
					{BUTTON}
				</td>
			</tr>
		{+END}
		<tr>
			<td colspan="2" class="ocf_topic_poll_results ocf_row5">
				{PRIVATE}
				{NUM_CHOICES}
			</td>
		</tr>
	</tbody>
</table></div>

<br />