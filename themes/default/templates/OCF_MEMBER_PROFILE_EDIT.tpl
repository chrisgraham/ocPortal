{+START,IF,{$JS_ON}}
	{+START,IF_NON_EMPTY,{$MESSAGES_TOP}}
		<div class="global_messages">
			{$MESSAGES_TOP}
		</div>
	{+END}
{+END}

{$REQUIRE_JAVASCRIPT,javascript_validation}
<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}" enctype="multipart/form-data">
	{HIDDEN}

	<div>
		<div class="float_surrounder"><div class="tabs">
			{+START,LOOP,TABS}
				<a aria-controls="g_edit__{$LCASE,{TAB_TITLE|*}}" role="tab" href="#" id="t_edit__{$LCASE,{TAB_TITLE|*}}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="select_tab('g','edit__{$LCASE,{TAB_TITLE|*}}'); return false;">{TAB_TITLE*}</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div aria-labeledby="t_edit__{$LCASE,{TAB_TITLE|*}}" role="tabpanel" id="g_edit__{$LCASE,{TAB_TITLE|*}}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a id="tab__edit__{$LCASE,{TAB_TITLE|*}}"></a>

					{+START,IF_NON_EMPTY,{TAB_TEXT}}
						{$PARAGRAPH,{TAB_TEXT}}
					{+END}

					{+START,IF_NON_PASSED_OR_FALSE,SKIP_REQUIRED}
						{+START,IF,{$IN_STR,{TAB_FIELDS},_required}}
							<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
						{+END}
					{+END}

					<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table">
						{+START,IF,{$NOT,{$MOBILE}}}
							<colgroup>
								<col class="field_name_column_shorter" />
								<col class="field_input_column" />
							</colgroup>
						{+END}

						<tbody>
							{TAB_FIELDS}
						</tbody>
					</table></div>
				</div>
			{+END}
		</div>
	</div>

	{+START,IF_NON_EMPTY,{SUBMIT_NAME}}
		{+START,INCLUDE,FORM_STANDARD_END}{+END}
	{+END}
</form>
