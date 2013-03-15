<div class="wide_table_wrap"><table summary="{!POLL}" class="autosized_table wide_table ocf_topic_poll">
	<tbody>
		<tr>
			<td colspan="2" class="table_heading_cell">
				<h3>{QUESTION*}</h3>
			</td>
		</tr>
		{ANSWERS}
		{+START,IF_NON_EMPTY,{BUTTON}}
			<tr>
				<td colspan="2" class="ocf_poll_button">
					{BUTTON}
				</td>
			</tr>
		{+END}
		<tr>
			<td colspan="2" class="ocf_topic_poll_results ocf_column6">
				{PRIVATE}
				{NUM_CHOICES}
			</td>
		</tr>
	</tbody>
</table></div>
