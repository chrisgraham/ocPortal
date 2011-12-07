{$JAVASCRIPT_INCLUDE,javascript_validation}
<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}" enctype="multipart/form-data">
	{HIDDEN}

	<div>
		<div class="float_surrounder"><div class="tabs">
			{+START,LOOP,TABS}
				<a href="#" id="t_{$LCASE,{TAB_TITLE|*}}" class="tab{+START,IF,{TAB_FIRST}} tab_active tab_first{+END}{+START,IF,{TAB_LAST}} tab_last{+END}" onclick="select_tab('g','{$LCASE,{TAB_TITLE|*}}'); return false;">
					{TAB_TITLE*}
				</a>
			{+END}
		</div></div>
		<div class="tab_surround">
			{+START,LOOP,TABS}
				<div id="g_{$LCASE,{TAB_TITLE|*}}" style="display: {$?,{$OR,{TAB_FIRST},{$NOT,{$JS_ON}}},block,none}">
					<a name="tab__{$LCASE,{TAB_TITLE|*}}" id="tab__{$LCASE,{TAB_TITLE|*}}"></a>

					{+START,IF_NON_EMPTY,{TAB_TEXT}}
						<div>
							{+START,IF,{$NOT,{$IN_STR,{TAB_TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}<p>{+END}{TAB_TEXT}{+START,IF,{$NOT,{$IN_STR,{TAB_TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}</p>{+END}
						</div>
					{+END}

					{+START,IF_NON_PASSED,SKIP_REQUIRED}
						{+START,IF,{$IN_STR,{TAB_FIELDS},_required}}
							<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
						{+END}
					{+END}

					<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
						{+START,IF,{$NOT,{$MOBILE}}}
							<colgroup>
								<col style="width: 120px" />
								<col style="width: 100%" />
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
