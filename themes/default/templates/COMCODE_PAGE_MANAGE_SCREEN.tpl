{TITLE}

{$PARAGRAPH,{TEXT}}

<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_NON_PASSED_OR_FALSE,GET}method="post" {+END}{+START,IF_PASSED_AND_TRUE,GET}method="get" {+END}action="{POST_URL*}">
	{TABLE}

	{+START,IF_PASSED,FIELDS}
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="results_table wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col class="field_name_column" />
					<col class="field_input_column" />
				</colgroup>
			{+END}

			<tbody>
				{FIELDS}
			</tbody>
		</table></div>
	{+END}

	{+START,IF_PASSED,HIDDEN}
		<div>
			{HIDDEN}
		</div>
	{+END}

	{+START,IF_PASSED,SUBMIT_NAME}
		<p class="proceed_button"><input class="button_page" type="submit" value="{SUBMIT_NAME*}" /></p>
	{+END}
</form>

{+START,IF_NON_EMPTY,{LINKS}}
	<h2>{!ADVANCED}</h2>

	<ul class="actions_list">
		{+START,LOOP,LINKS}
			<li style="background-image: url('{LINK_IMAGE;*}'); background-size: 18px 18px; background-position: 0 0; padding-left: 20px"><a href="{LINK_URL*}">{LINK_TEXT*}</a></li>
		{+END}
	</ul>
{+END}
