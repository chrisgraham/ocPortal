{+START,IF_EMPTY,{BANNERS}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{+START,IF_NON_EMPTY,{BANNERS}}
	<div class="wide_table_wrap"><table class="wide_table solidborder variable_table" summary="{!COLUMNED_TABLE}">
		<thead>
			<tr>
				<th>
					Movie
				</th>
				<th>
					Clicks
				</th>
			</tr>
		</thead>
		<tbody>
			{+START,LOOP,BANNERS}
				<tr {+START,IF,{$LT,{_loop_key},5}}class="highlighted_table_cell"{+END}>
					<td>
						<a href="{URL*}">{DESCRIPTION*}</a>
					</td>
					<td>
						{$NUMBER_FORMAT*,{HITSTO}}
					</td>
				</tr>
			{+END}
		</tbody>
	</table></div>
{+END}

{+START,IF_NON_EMPTY,{SUBMIT_URL}}
	<p class="proceed_button"><a href="{SUBMIT_URL*}"><img class="button_page" alt="{!ADD_BANNER}" title="{!ADD_BANNER}" src="{$IMG*,page/new}" /></a></p>
{+END}
