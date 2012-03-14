{+START,IF_NON_EMPTY,{TEXT}}
	<div>
		{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}</p>{+END}
	</div>
{+END}

{+START,IF_NON_PASSED,SKIP_REQUIRED}
	{+START,IF,{$IN_STR,{FIELDS},_required}}
		<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
	{+END}
{+END}

{$JAVASCRIPT_INCLUDE,javascript_validation}
<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_PASSED,TARGET}target="{TARGET*}" {+END} {+START,IF_NON_PASSED,GET}method="post" action="{URL*}"{+START,IF,{$IN_STR,{FIELDS},"file"}} enctype="multipart/form-data"{+END}{+END}{+START,IF_PASSED,GET}method="get" action="{$URL_FOR_GET_FORM*,{URL}}"{+END} {+START,IF_NON_PASSED,TARGET}target="_top" {+END}{+START,IF_PASSED,AUTOCOMPLETE}{+START,IF,{AUTOCOMPLETE}}class="autocomplete" {+END}{+END}>
	{+START,IF_PASSED,GET}{$HIDDENS_FOR_GET_FORM,{URL}}{+END}

	{+START,IF_PASSED,SKIPPABLE}
		{+START,IF,{$JS_ON}}
			<div class="form_skip">
				<input type="hidden" id="{SKIPPABLE*}" name="{SKIPPABLE*}" value="0" />
				<div>
					<input onclick="document.getElementById('{SKIPPABLE;}').value='1'; disable_button_just_clicked(this);" tabindex="151" class="button_pageitem" type="submit" value="{!SKIP}" />
				</div>
			</div>
		{+END}
	{+END}

	<div>
		{HIDDEN}
	
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 198px" />
					<col style="width: 100%" />
				</colgroup>
			{+END}

			<tbody>
				{FIELDS}
			</tbody>
		</table></div>
	
		{+START,IF_NON_EMPTY,{SUBMIT_NAME}}
			{+START,INCLUDE,FORM_STANDARD_END}{+END}
		{+END}
	</div>
</form>

