{+START,IF,{$CONFIG_OPTION,java_upload}}
	{+START,IF,{$NOT,{$GET,included_java_upload}}}
		{+START,INCLUDE,JAVA_DETECT}{+END}
	{+END}
	{$SET,included_java_upload,1}
{+END}

<div class="wide_table_wrap"><table class="map_table form_table wide_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col class="attachments_field_name_column" />
			<col class="attachments_field_input_column" />
		</colgroup>
	{+END}

	<tbody>
		<tr>
			<td colspan="2" class="form_table_field_name table_heading_cell">
				<h3>{!ATTACHMENT,{I*}}</h3>
			</td>
		</tr>

		<tr>
			<th class="form_table_field_name">
				{!UPLOAD}
				<span class="horiz_field_sep"><img onkeydown="this.onmouseover(event);" onkeyup="this.onmouseout(event);" onclick="this.onmouseover(event);" class="right" title="{!ATTACHMENT_HELP_2=,{$GET,IMAGE_TYPES}}" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,1x/help}" srcset="{$IMG*,2x/help} 2x" /></span>
			</th>
			<td class="form_table_field_input">
				<div class="accessibility_hidden"><label for="file{I*}">{!UPLOAD}</label></div>

				<span class="vertical_alignment">
					<input size="15" type="file" onchange="set_attachment('post',{I*},'');" id="file{I*}" name="file{I*}" />
					<script>// <![CDATA[
						document.getElementById('file{I;/}').setAttribute('unselectable','on');
					//]]></script>

					{+START,IF,{$AND,{$JS_ON},{$BROWSER_MATCHES,gecko}}}<input class="buttons__clear button_micro" type="button" id="clear_button_file{I*}" value="{!CLEAR}" onclick="var new_contents=get_textbox(form.elements['post']).replace(new RegExp('\\[(attachment|attachment_safe)[^\\]]*\\]new_{I;*}\\[/(attachment|attachment_safe)\\]'),''); set_textbox(form.elements['post'],new_contents,new_contents); document.getElementById('file{I;/}').value=''; return false;" title="{!CLEAR}: {!ATTACHMENT,{I*}}" />{+END}
				</span>

				{+START,IF_PASSED,SYNDICATION_JSON}
					<div id="file{I*}_syndication_options" class="syndication_options"></div>
				{+END}
			</td>
		</tr>
	</tbody>
</table></div>

{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
	<script>// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			preinit_file_input((typeof window.plUploadLoaded!='undefined')?'attachment_multi':'attachment','file{I}',null,'{POSTING_FIELD_NAME;/}'{+START,IF_PASSED,FILTER},'{FILTER;/}'{+END});
		} );
	//]]></script>
{+END}

{+START,IF_PASSED,SYNDICATION_JSON}
	<script>// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			show_upload_syndication_options('file{I;/}','{SYNDICATION_JSON;/}'{+START,IF_PASSED_AND_TRUE,NO_QUOTA},true{+END});
		} );
	//]]></script>
{+END}
