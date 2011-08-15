<h2>
	{SECTION*}
</h2>

{+START,IF_NON_EMPTY,{NOTES}}
	<p>
		<em>{NOTES*}</em>
	</p>
{+END}

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="variable_table solidborder wide_table"><tbody>
	{TESTS}
</tbody></table></div>

{+START,IF_NON_EMPTY,{EDIT_TEST_SECTION_URL}}
	<p>
		<a href="{EDIT_TEST_SECTION_URL*}" title="{!EDIT_TEST_SECTION}: #{ID*}">{!EDIT_TEST_SECTION}</a>
	</p>
{+END}

<div>
	<hr />
</div>
