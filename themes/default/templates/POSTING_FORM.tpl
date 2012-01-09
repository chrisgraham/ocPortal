{+START,IF,{$IN_STR,{SPECIALISATION}{SPECIALISATION2},_required}}
	<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>
{+END}

<form title="{!PRIMARY_PAGE_FORM}" id="posting_form" method="post" enctype="multipart/form-data" action="{URL*}" {+START,IF_PASSED,AUTOCOMPLETE}{+START,IF,{AUTOCOMPLETE}}class="autocomplete" {+END}{+END}>
	<div>
		{+START,IF_PASSED,DEFAULT_PARSED}
		<textarea cols="1" rows="1" style="display: none" readonly="readonly" name="post_parsed">{DEFAULT_PARSED*}</textarea>
		{+END}

		{HIDDEN_FIELDS}
		<input type="hidden" name="label_for__post" value="{$STRIP_TAGS,{POST_COMMENT*}}" />

		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 198px" />
					<col style="width: 100%" />
				</colgroup>
			{+END}

			<tbody>
				{SPECIALISATION}

				<tr class="form_screen_field_spacer">
					{$,width: 100% is needed to workaround a very weird IE bug - without it, colspan had no effect. Putting it in a CSS class didn't have any effect}
					<th style="width: 100%" abbr="{POST_COMMENT*}" class="de_th dottedborder_divider"{+START,IF,{$NOT,{$MOBILE}}} colspan="2"{+END}>
						<div class="comcode_supported posting_form_main_comcode_button">
							{+START,IF,{$OR,{$AND,{$IN_STR,{CLASS},wysiwyg},{$JS_ON}},{$SHOW_DOCS}}}
							[
								{+START,IF,{$SHOW_DOCS}}{+START,IF_PASSED,COMCODE_URL}
									<!--<a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{COMCODE_URL*}"><img class="comcode_button" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a> {!COMCODE_MESSAGE,<a class="link_exempt" title="Comcode: {!LINK_NEW_WINDOW}" target="_blank" href="{COMCODE_URL*}">Comcode</a>}-->
									{+START,IF,{$MATCH_KEY_MATCH,_WILD:cms_comcode_pages}}
										<a class="link_exempt" title="{!FULL_COMCODE_TUTORIAL}: {!LINK_NEW_WINDOW}" target="_blank" href="{$BRAND_BASE_URL*}/docs/tut_comcode.htm">{!FULL_COMCODE_TUTORIAL}</a>
										&middot; <a class="link_exempt" title="{!FULL_BLOCK_TUTORIAL}: {!LINK_NEW_WINDOW}" target="_blank" href="{$BRAND_BASE_URL*}/docs/tut_adv_comcode_pages.htm">{!FULL_BLOCK_TUTORIAL}</a>
									{+END}
								{+END}{+END}
								{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
									{+START,IF,{$JS_ON}}
										{+START,IF,{$MATCH_KEY_MATCH,_WILD:cms_comcode_pages}}
											&middot;
										{+END}
										<a id="toggle_wysiwyg_post" class="wysiwyg_button" href="#" onclick="return toggle_wysiwyg('post');"><abbr title="{!TOGGLE_WYSIWYG_2}">{!ENABLE_WYSIWYG}</abbr></a>
									{+END}
								{+END}
							]
							{+END}
						</div>

						<h2>{POST_COMMENT*}</h2>
					</th>
				</tr>
				<tr>
					<td class="dottedborder_divider_continue"{+START,IF,{$NOT,{$MOBILE}}} colspan="2"{+END}>
						<div class="float_surrounder_hidden">
							{+START,IF,{$NOT,{$MOBILE}}}
								{+START,IF,{$JS_ON}}
									<div class="float_surrounder_hidden">
										<div id="post_special_options2" style="display: none">
											{COMCODE_EDITOR_SMALL}
										</div>
										<div id="post_special_options">
											{COMCODE_EDITOR}
										</div>
									</div>
								{+END}
							{+END}

							<p class="accessibility_hidden"><label for="post">{POST_COMMENT*}</label></p>
							<div id="container_for_post" class="constrain_field container_for_wysiwyg">
								<textarea accesskey="x" class="{CLASS*} {+START,IF_PASSED,REQUIRED}{+START,IF,{REQUIRED}} posting_required{+END}{+END} wide_field" tabindex="{TABINDEX_PF*}" id="post" name="post" cols="70" rows="17">{POST*}</textarea>
								<div id="word_count"></div>
								{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
									<script type="text/javascript">// <![CDATA[
										if ((window.wysiwyg_on) && (wysiwyg_on())) document.getElementById('post').readOnly=true;

										window.setInterval(function() {
											if (isWYSIWYGField(document.getElementById('post')))
											{
												text_value=CKEDITOR.instances['post'].getData();
												var matches = text_value.replace(/<[^<|>]+?>|&nbsp;/gi,' ').match(/\b/g);
												var count = 0;
												if(matches) count = matches.length/2;
												setInnerHTML(document.getElementById('word_count'),'{!WORDS;}'.replace('\{1\}',count));
											}
										}, 1000);
									//]]></script>
								{+END}
							</div>
						</div>

						{+START,IF_NON_EMPTY,{$TRIM,{EMOTICON_CHOOSER}}}
							{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$OR,{$CONFIG_OPTION,is_on_emoticon_choosers},{$AND,{$OCF},{$JS_ON}}}}
								<div class="emoticon_chooser lightborder"><div class="float_surrounder">
									{+START,IF,{$AND,{$OCF},{$JS_ON}}}
										<div class="right">
											[ <a target="_blank" href="{$FIND_SCRIPT*,emoticons}?field_name=post{$KEEP*;,0,1}" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name=post{$KEEP*;,0,1}'),'site_emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;" class="posting_form_sup_link" title="{!EMOTICONS_POPUP} {!LINK_NEW_WINDOW}">{!VIEW_ARCHIVE}</a> ]<br />
											<!--<br />[ <a href="#" onclick="if (document.getElementById('post').value.substr(0,8)=='&lt;comcode') { window.fauxmodal_alert('{!ALREADY_COMCODE_XML;}'); return false; } return convert_xml('post');" class="posting_form_sup_link"><abbr title="{!CONVERT_TO_XML_2}">{!CONVERT_TO_XML}</abbr></a> ]-->
										</div>
									{+END}

									{+START,IF,{$CONFIG_OPTION,is_on_emoticon_choosers}}
										{EMOTICON_CHOOSER}
									{+END}
								</div></div>
							{+END}{+END}
						{+END}
						
						<p>{!USE_WEBSITE_RULES,{$PAGE_LINK*,:rules},{$PAGE_LINK*,:privacy}}</p>
					</td>
				</tr>

				<tr class="form_screen_field_spacer">
					<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th dottedborder_divider">
						{+START,IF,{$JS_ON}}
							<a id="fesAttachments" onclick="toggleSubordinateFields(this.getElementsByTagName('img')[0]); return false;" href="#"><img class="inline_image_2" style="float: {!en_right}" alt="{!EXPAND}: {!ATTACHMENTS}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
						{+END}

						<h2{+START,IF,{$JS_ON}} onclick="toggleSubordinateFields(this.parentNode.getElementsByTagName('img')[0],'fesAttachments_help'); return false;"{+END}>
							{!ATTACHMENTS}

							{+START,IF,{$NOT,{$MOBILE}}}
								<img onclick="this.onmouseover();" title="{!ATTACHMENT_HELP=}" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,help}" />
							{+END}
						</h2>

						{+START,IF_PASSED,HELP}
							<p style="display: none" id="fesAttachments_help">
								{HELP*}
							</p>
						{+END}
					</th>
				</tr>
				<tr style="display: none">
					<td class="dottedborder_divider_continue"{+START,IF,{$NOT,{$MOBILE}}} colspan="2"{+END}>
						{ATTACHMENTS}
					</td>
				</tr>
			
				{+START,IF,{$AND,{$IS_NON_EMPTY,{SPECIALISATION2}},{$OR,{$NOT,{$IN_STR,{SPECIALISATION2},<th colspan="2"}},{$LT,{$STRPOS,{SPECIALISATION2},<td},{$STRPOS,{SPECIALISATION2},<th colspan="2"}}}}}
					<tr class="form_screen_field_spacer">
						<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th dottedborder_divider">
							{+START,IF,{$JS_ON}}
								<a onclick="toggleSubordinateFields(this.getElementsByTagName('img')[0]); return false;" href="#"><img class="inline_image_2" style="float: {!en_right}" alt="{!CONTRACT}: {!OTHER_DETAILS}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>
							{+END}

							<h2{+START,IF,{$JS_ON}} onclick="toggleSubordinateFields(this.parentNode.getElementsByTagName('img')[0]); return false;"{+END}>{!OTHER_DETAILS}</h2>
						</th>
					</tr>
				{+END}

				{SPECIALISATION2}
			</tbody>
		</table></div>

		{+START,INCLUDE,FORM_STANDARD_END}{+END}

		<input type="hidden" name="comcode__post" value="1" />
		<input type="hidden" name="posting_ref_id" value="{$RAND,1,2147483646}" />
	</div>
</form>

{+START,IF,{$IS_A_COOKIE_LOGIN}}
<script type="text/javascript">// <![CDATA[
	window.want_form_saving=true;
//]]></script>
{+END}

{+START,IF_PASSED,EXTRA}
	{EXTRA}
{+END}

<script type="text/javascript">// <![CDATA[
	initialise_dragdrop_upload('container_for_post','post');
//]]></script>
