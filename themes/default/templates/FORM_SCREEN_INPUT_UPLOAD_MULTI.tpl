<div class="accessibility_hidden"><label for="{NAME_STUB*}_{I*}">{!UPLOAD}</label></div>
<div class="vertical_alignment">
	<input tabindex="{TABINDEX*}" class="input_upload{REQUIRED*}" onchange="if (!key_pressed(event,9)) ensure_next_field_upload(this);" type="file" id="{NAME_STUB*}_{I*}" name="{NAME_STUB*}_{I*}" />
	<input type="hidden" name="label_for_{NAME_STUB*}_{I*}" value="{!UPLOAD}" />

	{+START,IF_NON_EMPTY,{EDIT}}
		{$, If you want to let people remove all in one tick
		<p>
			<input type="checkbox" id="i_{NAME*}_unlink" name="{NAME_STUB*}_unlink" value="1" />
			<label class="upload_field_msg" for="i_{NAME_STUB*}_unlink">
				{!UNLINK_EXISTING_UPLOADS}
			</label>
		</p>
		}

		{+START,LOOP,EDIT}
			<p>
				<input type="checkbox" id="i_{NAME_STUB*}_{$ADD*,{_loop_key},1}_unlink" name="{NAME_STUB*}_{$ADD*,{_loop_key},1}_unlink" value="1" />
				<label class="upload_field_msg" for="i_{NAME_STUB*}_{$ADD*,{_loop_key},1}_unlink">
					{!UNLINK_EXISTING_UPLOAD_SPECIFIC,<kbd>{$PREG_REPLACE*,.*/,,{_loop_var}}</kbd>}
				</label>
			</p>
		{+END}
	{+END}

	{+START,IF,{$JS_ON}}<button class="button_micro" type="button" id="clearBtn_{NAME_STUB*}_{I*}" onclick="var x=document.getElementById('{NAME_STUB;*}_{I;*}'); x.value=''; if (typeof x.fakeonchange!='undefined' &amp;&amp; x.fakeonchange) x.fakeonchange(event); return false;">{!CLEAR}</button>{+END}

	<!--Additional uploaders will auto-append here-->
</div>

{+START,IF,{SWFUPLOAD}}{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
	<script>// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			preinitFileInput('upload_multi','{NAME_STUB;/}_{I}',null,null,'{FILTER;/}');
		} );
	//]]></script>
{+END}{+END}
