<input tabindex="{TABINDEX*}" class="input_upload{REQUIRED*}" type="file" id="{NAME*}" name="{NAME*}" />
{+START,IF,{EDIT}}
	<input type="checkbox" id="i_{NAME*}_unlink" name="{NAME*}_unlink" value="1" />
	<label class="upload_field_msg" for="i_{NAME*}_unlink">
		{+START,IF,{$NOT,{IS_IMAGE}}}
			{!UNLINK_EXISTING_UPLOAD}
		{+END}
		{+START,IF,{IS_IMAGE}}
			{!UNLINK_EXISTING_UPLOAD_IMAGE,&lt;img src=&quot;{EXISTING_URL^;*}&quot; title=&quot;&quot; alt=&quot;{!EXISTING^;}&quot; /&gt;}
		{+END}
	</label>
{+END}

{+START,IF,{$AND,{$JS_ON},{$BROWSER_MATCHES,gecko}}}<button class="button_pageitem" type="button" id="clearBtn_{NAME*}" onclick="var x=document.getElementById('{NAME*;}'); x.value=''; if (typeof x.fakeonchange!='undefined' &amp;&amp; x.fakeonchange) x.fakeonchange(); return false;" title="{!CLEAR}{+START,IF_PASSED,PRETTY_NAME}: {PRETTY_NAME*}{+END}">{!CLEAR}</button>{+END}

{+START,IF,{$CONFIG_OPTION,java_upload}}
	{+START,IF,{$NOT,{$GET,included_java_upload}}}
		{+START,INCLUDE,JAVA_DETECT}{+END}
	{+END}
	{$SET,included_java_upload,_true}
{+END}

{+START,IF,{SWFUPLOAD}}{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
	<script type="text/javascript">
	// <![CDATA[
		addEventListenerAbstract(window,'load',function () {
			preinitFileInput('upload','{NAME}');
		} );
	//]]>
	</script>
{+END}{+END}
