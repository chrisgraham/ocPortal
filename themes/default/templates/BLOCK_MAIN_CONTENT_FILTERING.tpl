{$REQUIRE_JAVASCRIPT,javascript_validation}

{+START,IF_NON_EMPTY,{FIELDS}}
	<form title="{!PRIMARY_PAGE_FORM}" method="get" action="{$URL_FOR_GET_FORM*,{$SELF_URL}}">
		{+START,IF_NON_PASSED_OR_FALSE,GET}{$INSERT_SPAMMER_BLACKHOLE}{+END}

		{+START,IF_PASSED_AND_TRUE,GET}{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,0,0,active_filter=<null>}}{+END}

		<div>
			<input type="hidden" name="active_filter" value="{ACTIVE_FILTER*}" />

			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table">
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

			{+START,INCLUDE,FORM_STANDARD_END}SUBMIT_NAME={!FILTER}{+END}
		</div>
	</form>
{+END}

{+START,IF_NON_EMPTY,{LINKS}}
	<ul>
		{+START,LOOP,LINKS}
			<li>
				{+START,IF,{ACTIVE}}
					{TITLE*}
				{+END}
				{+START,IF,{$NOT,{ACTIVE}}}
					<a href="{URL*}">{TITLE*}</a>
				{+END}
			</li>
		{+END}
	</ul>
{+END}
