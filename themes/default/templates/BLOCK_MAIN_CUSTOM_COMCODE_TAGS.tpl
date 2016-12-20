{+START,IF_NON_EMPTY,{TAGS}}
	<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="variable_table solidborder wide_table">
		<thead>
			<tr>
				<th>{!TITLE}</th>
				<th>{!DESCRIPTION}</th>
				<th>{!EXAMPLE}</th>
			</tr>
		</thead>

		<tbody>
			{TAGS}
		</tbody>
	</table></div>
{+END}
{+START,IF_EMPTY,{TAGS}}
	<p class="nothing_here">{!NONE}</p>
{+END}
