<tr class="form_table_field_spacer">
	<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="table_heading_cell{+START,IF,{REQUIRED}} required{+END}">
		<span class="field_name">
			<span id="required_readable_marker__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" style="display: {$?,{REQUIRED*},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>
		</span>

		{+START,IF_PASSED,POST_COMMENT}
			<h2><label for="{NAME*}">{POST_COMMENT*}</label></h2>

			<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_TAGS,{POST_COMMENT*}}" />
		{+END}
		{+START,IF_NON_PASSED,POST_COMMENT}
			<label class="accessibility_hidden" for="{NAME*}">{!_POST}</label>
		{+END}

		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_details">{DESCRIPTION}</div>
		{+END}

		<input type="hidden" name="comcode__{NAME*}" value="1" />
		{HIDDEN_FIELDS}

		<div class="comcode_supported posting_form_main_comcode_button">
			{+START,IF,{$OR,{$AND,{$IN_STR,{CLASS},wysiwyg},{$JS_ON}},{$AND,{$MATCH_KEY_MATCH,_WILD:cms_comcode_pages},{$SHOW_DOCS}}}}
				<ul class="horizontal_links horiz_field_sep associated_links_block_group">
					{+START,IF,{$SHOW_DOCS}}{+START,IF_PASSED,COMCODE_URL}
						{$,<li><a class="link_exempt" title="\{!COMCODE_MESSAGE,Comcode\}: \{!LINK_NEW_WINDOW\}" target="_blank" href="\{COMCODE_URL*\}"><img class="comcode_supported_icon" alt="\{!COMCODE_MESSAGE,Comcode\}" src="\{$IMG*,comcode\}" title="\{!COMCODE_MESSAGE,Comcode\}" /></a> \{!COMCODE_MESSAGE,<a class="link_exempt" title="Comcode: \{!LINK_NEW_WINDOW\}" target="_blank" href="\{COMCODE_URL*\}">Comcode</a>\}</li>}
						{+START,IF,{$MATCH_KEY_MATCH,_WILD:cms_comcode_pages}}
							<li><a class="link_exempt" title="{!FULL_COMCODE_TUTORIAL}: {!LINK_NEW_WINDOW}" target="_blank" href="{$BRAND_BASE_URL*}/docs/tut_comcode.htm">{!FULL_COMCODE_TUTORIAL}</a></li>
							<li><a class="link_exempt" title="{!FULL_BLOCK_TUTORIAL}: {!LINK_NEW_WINDOW}" target="_blank" href="{$BRAND_BASE_URL*}/docs/tut_adv_comcode_pages.htm">{!FULL_BLOCK_TUTORIAL}</a></li>
						{+END}
					{+END}{+END}
					{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
						{+START,IF,{$JS_ON}}
							<li><a id="toggle_wysiwyg_{NAME*}" href="#" onclick="return toggle_wysiwyg('{NAME*;}');"><abbr title="{!TOGGLE_WYSIWYG_2}">{!ENABLE_WYSIWYG}</abbr></a></li>
						{+END}
					{+END}
				</ul>
			{+END}
		</div>
	</th>
</tr>
<tr class="field_input">
	<td class="{+START,IF,{REQUIRED}} required{+END} form_table_huge_field"{+START,IF,{$NOT,{$MOBILE}}} colspan="2"{+END}>
		{+START,IF_PASSED,DEFAULT_PARSED}
			<textarea cols="1" rows="1" style="display: none" readonly="readonly" disabled="disabled" name="{NAME*}_parsed">{DEFAULT_PARSED*}</textarea>
		{+END}

		<div class="float_surrounder">
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$JS_ON}}
					<div class="float_surrounder" role="toolbar">
						<div id="post_special_options2" style="display: none">
							{COMCODE_EDITOR_SMALL}
						</div>
						<div id="post_special_options">
							{COMCODE_EDITOR}
						</div>
					</div>
				{+END}
			{+END}

			<div id="container_for_{NAME*}" class="constrain_field container_for_wysiwyg">
				<textarea accesskey="x" class="{CLASS*}{+START,IF,{REQUIRED}} posting_required{+END} wide_field" tabindex="{TABINDEX_PF*}" id="{NAME*}" name="{NAME*}" cols="70" rows="17">{POST*}</textarea>

				{+START,IF_PASSED,WORD_COUNTER}
					{$SET,word_count_id,{$RAND}}
					<div class="word_count" id="word_count_{$GET*,word_count_id}"></div>
				{+END}

				{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
					<script type="text/javascript">// <![CDATA[
						if ((window.wysiwyg_on) && (wysiwyg_on()))
						{
							document.getElementById('{NAME;*}').readOnly=true; // Stop typing while it loads
							window.setTimeout(function() {
								if (document.getElementById('{NAME;*}').value==document.getElementById('{NAME;*}').defaultValue)
									document.getElementById('{NAME;*}').readOnly=false; // Too slow, maybe WYSIWYG failed due to some network issue
							},3000);
						}

						{+START,IF_PASSED,WORD_COUNTER}
							add_event_listener_abstract(window,'load',function () {
								setup_word_counter(document.getElementById('post'),document.getElementById('word_count_{$GET*,word_count_id}'));
							} );
						{+END}
					//]]></script>
				{+END}
			</div>
		</div>

		{+START,IF_NON_EMPTY,{$TRIM,{EMOTICON_CHOOSER}}}
			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$OR,{$CONFIG_OPTION,is_on_emoticon_choosers},{$AND,{$OCF},{$JS_ON}}}}
				<div{+START,IF,{$CONFIG_OPTION,is_on_emoticon_choosers}} class="emoticon_chooser box"{+END}>
					{+START,IF,{$AND,{$OCF},{$JS_ON}}}
						<span class="right horiz_field_sep associated_link"><a rel="nofollow" target="_blank" href="{$FIND_SCRIPT*,emoticons}?field_name={NAME*}{$KEEP*;,0,1}" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT;*,emoticons}?field_name={NAME*}{$KEEP*;,0,1}'),'site_emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;" title="{!EMOTICONS_POPUP} {!LINK_NEW_WINDOW}">{$?,{$CONFIG_OPTION,is_on_emoticon_choosers},{!VIEW_ARCHIVE},{!EMOTICONS_POPUP}}</a></span>
						{$,<span class="right horiz_field_sep associated_link"><a rel="nofollow" href="#" onclick="if (document.getElementById('\{NAME*\}').value.substr(0,8)=='&lt;comcode') \{ window.fauxmodal_alert('\{!ALREADY_COMCODE_XML;\}'); return false; \} return convert_xml('\{NAME*\}');"><abbr title="\{!CONVERT_TO_XML_2\}">\{!CONVERT_TO_XML\}</abbr></a></span>}
					{+END}

					{+START,IF,{$CONFIG_OPTION,is_on_emoticon_choosers}}
						{EMOTICON_CHOOSER}
					{+END}
				</div>
			{+END}{+END}

			{+START,IF_PASSED,POST_COMMENT}
				<p>{!USE_WEBSITE_RULES,{$PAGE_LINK*,:rules},{$PAGE_LINK*,:privacy}}</p>
			{+END}
		{+END}
	</td>
</tr>

{+START,IF_NON_EMPTY,{ATTACHMENTS}}
	<tr class="form_table_field_spacer">
		<th {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="table_heading_cell">
			{+START,IF,{$JS_ON}}
				<a class="toggleable_tray_button" id="fes_attachments" onclick="toggle_subordinate_fields(this.getElementsByTagName('img')[0]); return false;" href="#"><img alt="{!EXPAND}: {!ATTACHMENTS}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			{+END}

			<h2{+START,IF,{$JS_ON}} class="toggleable_tray_button" onclick="toggle_subordinate_fields(this.parentNode.getElementsByTagName('img')[0],'fes_attachments_help'); return false;"{+END}>
				{!ATTACHMENTS}

				{+START,IF,{$NOT,{$MOBILE}}}
					<img class="help_icon" onkeydown="this.onmouseover(event);" onkeyup="this.onmouseout(event);" onclick="this.onmouseover(event);" title="{!ATTACHMENT_HELP=}" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,help}" />
				{+END}
			</h2>

			{+START,IF_PASSED,HELP}
				<p style="display: none" id="fes_attachments_help">
					{HELP*}
				</p>
			{+END}
		</th>
	</tr>
	<tr style="display: none" class="field_input">
		<td class="form_table_huge_field"{+START,IF,{$NOT,{$MOBILE}}} colspan="2"{+END}>
			{ATTACHMENTS}

			<input type="hidden" name="posting_ref_id" value="{$RAND,1,2147483646}" />

			<script type="text/javascript">// <![CDATA[
				initialise_dragdrop_upload('container_for_{NAME;/}','{NAME;/}');
			//]]></script>
		</td>
	</tr>
{+END}
