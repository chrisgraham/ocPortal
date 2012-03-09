{+START,IF_PASSED,TEXT_ID}{$SET,TEXT_ID,{TEXT_ID}}{+END}

{+START,IF_EMPTY,{FIELDS}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}
{+START,IF_NON_EMPTY,{FIELDS}}
	{MESSAGE}
	<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="dottedborder wide_table{+START,IF_EMPTY,{WIDTHS}} variable_table{+END}"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
		{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{WIDTHS}}
			<colgroup>
				{+START,LOOP,WIDTHS}
					<col style="width: {_loop_var}{+START,IF,{$NOT,{$IN_STR,{_loop_var},px,%}}}px{+END}" />
				{+END}
			</colgroup>
		{+END}{+END}

		<thead>
			<tr>
				{FIELDS_TITLE}
			</tr>
		</thead>
		<tbody>
			{FIELDS}
		</tbody>
	</table></div>
	{+START,IF_NON_EMPTY,{SORT}{BROWSER}}
		<div class="lightborder medborder_box results_table">
			<div class="float_surrounder">
				<div class="results_table_sorter">{SORT}</div>

				{BROWSER}
			</div>
		</div>
	{+END}
{+END}

