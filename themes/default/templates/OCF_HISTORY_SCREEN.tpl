{TITLE}

<p>
	{!ABOUT_POST_HISTORY}
</p>

{+START,IF_NON_EMPTY,{CONTENT}}
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="variable_table solidborder wide_table">
		<tbody>
			{CONTENT}
		</tbody>
	</table></div>
{+END}
{+START,IF_EMPTY,{CONTENT}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
	<div class="float_surrounder results_browser_spacing">
		{RESULTS_BROWSER}
	</div>
{+END}
