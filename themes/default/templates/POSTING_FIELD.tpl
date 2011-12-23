<tr>
	<th style="width: 100%" abbr="{PRETTY_NAME=}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="de_th{+START,IF,{REQUIRED*}} dottedborder_barrier_a_required{+END} dottedborder_huge_a">
		<span class="field_name"><span id="requireb__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" style="display: {$?,{REQUIRED*},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>{PRETTY_NAME*}</span>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_caption">{DESCRIPTION}</div>
		{+END}

		<div class="comcode_supported posting_form_main_comcode_button">
			<!--{+START,IF,{$SHOW_DOCS}}{+START,IF_PASSED,COMCODE_URL}
			[
				<a class="link_exempt" title="{!COMCODE_MESSAGE,Comcode}: {!LINK_NEW_WINDOW}" target="_blank" href="{COMCODE_URL*}"><img class="comcode_button" alt="{!COMCODE_MESSAGE,Comcode}" src="{$IMG*,comcode}" title="{!COMCODE_MESSAGE,Comcode}" /></a> {!COMCODE_MESSAGE,<a class="link_exempt" title="Comcode: {!LINK_NEW_WINDOW}" target="_blank" href="{COMCODE_URL*}">Comcode</a>}
				{+START,IF,{$MATCH_KEY_MATCH,_WILD:cms_comcode_pages}}
					&middot; <a class="link_exempt" title="{!FULL_COMCODE_TUTORIAL}: {!LINK_NEW_WINDOW}" target="_blank" href="{$BRAND_BASE_URL*}/docs/tut_comcode.htm">{!FULL_COMCODE_TUTORIAL}</a>
					&middot; <a class="link_exempt" title="{!FULL_BLOCK_TUTORIAL}: {!LINK_NEW_WINDOW}" target="_blank" href="{$BRAND_BASE_URL*}/docs/tut_adv_comcode_pages.htm">{!FULL_BLOCK_TUTORIAL}</a>
				{+END}
			]
			{+END}{+END}-->

			{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
				{+START,IF,{$JS_ON}}
					&nbsp;&nbsp;&nbsp; [&nbsp;<a id="toggle_wysiwyg_{NAME*}" class="wysiwyg_button" href="#" onclick="return toggle_wysiwyg('{NAME*}');"><abbr title="{!TOGGLE_WYSIWYG_2}">{!ENABLE_WYSIWYG}</abbr></a>&nbsp;]
				{+END}
			{+END}
		</div>
	</th>
</tr>
<tr>
	<td class="{+START,IF,{REQUIRED*}} dottedborder_barrier_a_required{+END} dottedborder_huge_a"{+START,IF,{$NOT,{$MOBILE}}} colspan="2"{+END}>
		{+START,IF_PASSED,DEFAULT_PARSED}
		<textarea cols="1" rows="1" style="display: none" readonly="readonly" name="{NAME*}_parsed">{DEFAULT_PARSED*}</textarea>
		{+END}

		<div class="float_surrounder_hidden">
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$JS_ON}}
					<div class="float_surrounder">
						<div id="post_special_options2" style="display: none">
							{COMCODE_EDITOR_SMALL}
						</div>
						<div id="post_special_options">
							{COMCODE_EDITOR}
						</div>
					</div>
				{+END}
			{+END}

			<p class="accessibility_hidden"><label for="{NAME*}">{PRETTY_NAME*}</label></p>
			<div id="container_for_{NAME*}" class="constrain_field container_for_wysiwyg">
				<textarea accesskey="x" class="{CLASS*}{+START,IF,{REQUIRED}} posting_required{+END} wide_field" tabindex="{TABINDEX_PF*}" id="{NAME*}" name="{NAME*}" cols="70" rows="17">{POST*}</textarea>
				{+START,IF,{$IN_STR,{CLASS},wysiwyg}}
					<script type="text/javascript">// <![CDATA[
						if ((window.wysiwyg_on) && (wysiwyg_on())) document.getElementById('{NAME*}').readOnly=true;
					//]]></script>
				{+END}
			</div>
		</div>

		{+START,IF_NON_EMPTY,{EMOTICON_CHOOSER}}
			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$OR,{$CONFIG_OPTION,is_on_emoticon_choosers},{$AND,{$OCF},{$JS_ON}}}}
				<div class="emoticon_chooser lightborder"><div class="float_surrounder">
					{+START,IF,{$AND,{$OCF},{$JS_ON}}}
						<div class="right">
							[ <a target="_blank" href="{$FIND_SCRIPT*,emoticons}?field_name={NAME*}{$KEEP*;,0,1}" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name={NAME*}{$KEEP*;,0,1}'),'site_emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;" class="posting_form_sup_link" title="{!EMOTICONS_POPUP} {!LINK_NEW_WINDOW}">{!VIEW_ARCHIVE}</a> ]
							<!--<br />[ <a href="#" onclick="if (document.getElementById('{NAME*}').value.substr(0,8)=='&lt;comcode') { window.fauxmodal_alert('{!ALREADY_COMCODE_XML;}'); return false; } return convert_xml('{NAME*}');" class="posting_form_sup_link"><abbr title="{!CONVERT_TO_XML_2}">{!CONVERT_TO_XML}</abbr></a> ]-->
						</div>
					{+END}

					{+START,IF,{$CONFIG_OPTION,is_on_emoticon_choosers}}
						{EMOTICON_CHOOSER}
					{+END}
				</div></div>
			{+END}{+END}
		{+END}
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

		<input type="hidden" name="comcode__{NAME*}" value="1" />
		<input type="hidden" name="posting_ref_id" value="{$RAND,1,2147483646}" />
		{HIDDEN_FIELDS}

		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(document.getElementById('{NAME*}'),'dragover',function(event) { if (!event) event=window.event; if ((typeof event.dataTransfer!='undefined') && (typeof event.dataTransfer.types!='undefined') && (event.dataTransfer.types[0].indexOf('text')==-1)) { cancelBubbling(event); if (typeof event.preventDefault!='undefined') event.preventDefault(); event.returnValue = false;} }); // NB: don't use dropEffect, prevents drop on Firefox.
			if ((typeof window.google!='undefined') && (typeof window.google.gears!='undefined') && (typeof window.google.gears.factory!='undefined') && (typeof window.google.gears.factory.create!='undefined') && (typeof window.gears_upload!='undefined'))
			{
				/* Google Gears support. */
				var desktop = google.gears.factory.create('beta.desktop');
				addEventListenerAbstract(document.getElementById('{NAME*}'),'drop',function(event) { if (!event) event=window.event; gears_upload(event,'{NAME*}'); });
			} else
			{
				addEventListenerAbstract(document.getElementById('{NAME*}'),'drop',function(event) { if (!event) event=window.event; html5_upload(event,'{NAME*}'); });
			}
		//]]></script>
	</td>
</tr>
