{+START,IF,{$CONFIG_OPTION,java_upload}}
	{+START,IF,{$NOT,{$GET,included_java_upload}}}
		{+START,INCLUDE,JAVA_DETECT}{+END}
	{+END}
	{$SET,included_java_upload,1}
{+END}

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="form_table wide_table">
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
				<span class="horiz_field_sep"><img onkeydown="this.onmouseover(event);" onkeyup="this.onmouseout(event);" onclick="this.onmouseover(event);" class="right help_icon" title="{!ATTACHMENT_HELP_2=,{$GET,IMAGE_TYPES}}" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,help}" /></span>
			</th>
			<td class="form_table_field_input">
				<div class="accessibility_hidden"><label for="file{I*}">{!UPLOAD}</label></div>
				<input size="15" type="file" onchange="set_attachment('post',{I*},'');" id="file{I*}" name="file{I*}" />
				<script type="text/javascript">// <![CDATA[
					document.getElementById('file{I;}').setAttribute('unselectable','on');
				//]]></script>

				{+START,IF,{$AND,{$JS_ON},{$BROWSER_MATCHES,gecko}}}<button class="button_pageitem" type="button" id="clearBtn_file{I*}" onclick="var new_contents=get_textbox(form.elements['post']).replace(new RegExp('\\[(attachment|attachment_safe)[^\\]]*\\]new_{I*;}\\[/(attachment|attachment_safe)\\]'),''); set_textbox(form.elements['post'],new_contents,new_contents); document.getElementById('file{I;}').value=''; return false;" title="{!CLEAR}: {!ATTACHMENT,{I*}}">{!CLEAR}</button>{+END}
			</td>
		</tr>
	</tbody>
</table></div>

{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			preinitFileInput('attachment','file{I}',null,'{POSTING_FIELD_NAME;}');
		} );
	//]]></script>
{+END}
