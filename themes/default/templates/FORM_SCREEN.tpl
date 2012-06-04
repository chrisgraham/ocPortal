{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

{+START,IF_NON_EMPTY,{TEXT}}
	<div>
		{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}</p>{+END}
	</div>
{+END}

{+START,IF,{$IN_STR,{FIELDS},_required}}
	<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
{+END}

{$JAVASCRIPT_INCLUDE,javascript_validation}
{+START,IF_NON_PASSED,IFRAME_URL}
<form title="{!PRIMARY_PAGE_FORM}" id="main_form" {+START,IF_NON_PASSED,GET}method="post" action="{URL*}"{+START,IF,{$IN_STR,{FIELDS},"file"}} enctype="multipart/form-data"{+END}{+END}{+START,IF_PASSED,GET}method="get" action="{$URL_FOR_GET_FORM*,{URL}}"{+END} {+START,IF_PASSED,TARGET}target="{TARGET*}" {+END}{+START,IF_NON_PASSED,TARGET}target="_top" {+END}{+START,IF_PASSED,AUTOCOMPLETE}{+START,IF,{AUTOCOMPLETE}}class="autocomplete" {+END}{+END}>
	{+START,IF_PASSED,GET}{$HIDDENS_FOR_GET_FORM,{URL}}{+END}
{+END}
{+START,IF_PASSED,IFRAME_URL}
<form title="{!PRIMARY_PAGE_FORM}" id="main_form" {+START,IF_NON_PASSED,GET}method="post" action="{IFRAME_URL*}"{+START,IF,{$IN_STR,{FIELDS},"file"}} enctype="multipart/form-data"{+END}{+END}{+START,IF_PASSED,GET}method="get" action="{$URL_FOR_GET_FORM*,{IFRAME_URL}}"{+END} target="iframe_under" {+START,IF_PASSED,AUTOCOMPLETE}{+START,IF,{AUTOCOMPLETE}}class="autocomplete" {+END}{+END}>
	{+START,IF_PASSED,GET}{$HIDDENS_FOR_GET_FORM,{IFRAME_URL}}{+END}
{+END}

	{+START,IF_PASSED,SKIPPABLE}
		{+START,IF,{$JS_ON}}
			<div class="form_skip{+START,IF,{$IN_STR,{FIELDS},_required}} form_skip_with_req_note{+END}">
				<div>
					<input type="hidden" id="{SKIPPABLE*}" name="{SKIPPABLE*}" value="0" />
					<input onclick="document.getElementById('{SKIPPABLE;}').value='1'; disable_button_just_clicked(this);" tabindex="151" class="button_pageitem" type="submit" value="{!SKIP}" />
				</div>
			</div>
		{+END}
	{+END}

	<div>
		{HIDDEN}

		{+START,IF_NON_EMPTY,{FIELDS}}
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table scrollable_inside">
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
		{+END}

		{+START,INCLUDE,FORM_STANDARD_END}{+END}
	</div>
</form>

{+START,IF_PASSED,IFRAME_URL}
	<a name="edit_space" id="edit_space"></a>

	<div class="arrow_ruler">
		<form action="#" method="post">
			<div>
				[ <label for="will_open_new"><input onclick="var f=document.getElementById('main_form'); f.action=this.checked?non_iframe_url:iframe_url; f.elements['opens_below'].value=this.checked?'0':'1'; f.elements['wide_high'].value=this.checked?'0':'1'; f.target=this.checked?'_blank':'iframe_under';" type="checkbox" name="will_open_new" id="will_open_new" /> {!CHOOSE_OPEN_NEW_WINDOW}</label> ]
			</div>
		</form>

		<img alt="" src="{$IMG*,arrow_ruler}" />
	</div>

	<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} class="form_page_iframe" title="{!EDIT}" name="iframe_under" id="iframe_under" src="{$BASE_URL*}/uploads/index.html">{!EDIT}</iframe>

	<script type="text/javascript">// <![CDATA[
		if (typeof window.try_to_simplify_iframe_form!='undefined') try_to_simplify_iframe_form();
		var non_iframe_url='{URL;*}';
		var iframe_url='{IFRAME_URL;*}';
		window.setInterval(function() { resizeFrame('iframe_under'); },1500);
	//]]></script>
{+END}
{+START,IF_NON_PASSED,IFRAME_URL}
	<script type="text/javascript">// <![CDATA[
		if (typeof window.try_to_simplify_iframe_form!='undefined') try_to_simplify_iframe_form();
	//]]></script>
{+END}

{+START,IF_PASSED,BACK}
	{+START,IF,{$JS_ON}}
	<p><a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a></p>
	{+END}
{+END}
