{+START,IF,{$CONFIG_OPTION,java_upload}}
	{+START,IF,{$NOT,{$GET,included_java_upload}}}
		{+START,INCLUDE,JAVA_DETECT}{+END}
	{+END}
	{$SET,included_java_upload,1}
{+END}

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 180px" />
			<col style="width: 100%" />
		</colgroup>
	{+END}

	<tbody>
		<tr>
			<td colspan="2" class="de_th dottedborder_barrier_a_nonrequired">
				<h3>{!ATTACHMENT,{I*}}</h3>
			</td>
		</tr>

		<tr>
			<th class="de_th dottedborder_barrier_a_nonrequired">
				{!UPLOAD}
				<img onclick="this.onmouseover();" class="right" title="{!ATTACHMENT_HELP_2=,{$GET,IMAGE_TYPES}}" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,help}" />
			</th>
			<td class="dottedborder_barrier_b_nonrequired">
				<div class="accessibility_hidden"><label for="file{I*}">{!UPLOAD}</label></div>
				<input size="15" type="file" onchange="setAttachment('post',{I*},'');" id="file{I*}" name="file{I*}" />
				<script type="text/javascript">// <![CDATA[
					document.getElementById('file{I;}').setAttribute('unselectable','on');
				//]]></script>

				{+START,IF,{$AND,{$JS_ON},{$BROWSER_MATCHES,gecko}}}<button class="button_pageitem" type="button" id="clearBtn_file{I*}" onclick="var new_contents=getTextbox(form.elements['post']).replace(new RegExp('\\[(attachment|attachment_safe)[^\\]]*\\]new_{I;*}\\[/(attachment|attachment_safe)\\]'),''); setTextbox(form.elements['post'],new_contents,new_contents); document.getElementById('file{I;}').value=''; return false;" title="{!CLEAR}: {!ATTACHMENT,{I*}}">{!CLEAR}</button>{+END}
			</td>
		</tr>
		<tr>
			<th class="de_th dottedborder_barrier_a_nonrequired">
				{!TYPE}
			</th>
			<td class="dottedborder_barrier_b_nonrequired">
				<div class="accessibility_hidden"><label for="attachmenttype{I*}">{!TYPE}</label></div>
				<div class="constrain_field">
					<select id="attachmenttype{I*}" name="attachmenttype{I*}" class="wide_field">
						<option value="island">{!ATTACHMENT_ISLAND}</option>
						<option value="island_extract">{!ATTACHMENT_ISLAND_EXTRACT}</option>
						<option value="left">{!ATTACHMENT_LEFT}</option>
						<option value="right">{!ATTACHMENT_RIGHT}</option>
						<option value="left_inline">{!ATTACHMENT_LEFT_INLINE}</option>
						<option value="right_inline">{!ATTACHMENT_RIGHT_INLINE}</option>
						<option value="inline">{!ATTACHMENT_INLINE}</option>
						<option value="inline_extract">{!ATTACHMENT_INLINE_EXTRACT}</option>
						<option value="download">{!ATTACHMENT_DOWNLOAD}</option>
						<option value="code">{!ATTACHMENT_CODE}</option>
						<option value="hyperlink">{!ATTACHMENT_HYPERLINK}</option>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<th class="de_th dottedborder_barrier_a_nonrequired">
				{!CAPTION}
				<img onclick="this.onmouseover();" class="right" title="{!ATTACHMENT_HELP_3=}" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,help}" />
			</th>
			<td class="dottedborder_barrier_b_nonrequired">
				<div class="accessibility_hidden"><label for="caption{I*}">{!CAPTION}</label></div>
				<div class="constrain_field">
					<input class="wide_field" value="" type="text" id="caption{I*}" name="caption{I*}" />
				</div>
			</td>
		</tr>
	</tbody>
</table></div>

{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
	<script type="text/javascript">
	// <![CDATA[
		addEventListenerAbstract(window,'load',function () {
			preinitFileInput('attachment','file{I}',null,'{POSTING_FIELD_NAME;}');
		} );
	//]]>
	</script>
{+END}
