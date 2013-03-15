<div class="fields_set_radio">
	<label class="accessibility_hidden" for="choose_{NAME*}">{!USE}: {PRETTY_NAME*}</label>
	<input type="radio" name="{SET_NAME*}" id="choose_{NAME*}" />

	<label for="{NAME*}">{PRETTY_NAME*}</label>

	{+START,IF_NON_EMPTY,{COMCODE}}
		<span class="comcode_supported">
			<input type="hidden" name="comcode__{NAME*}" value="1" />
			{COMCODE}
		</span>
	{+END}
</div>

<div class="mini_indent fields_set_contents">
	{INPUT}

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div class="associated_details{+START,IF,{$AND,{$EQ,{$SUBSTR_COUNT,{INPUT}, name="},2},{$EQ,{$SUBSTR_COUNT,{INPUT},type="file"},0},{$EQ,{$SUBSTR_COUNT,{INPUT},type="checkbox"},1}}} field_checkbox_description{+END}">
			<input type="hidden" name="label_for__{NAME*}" value="{$TRIM,{$REPLACE,&lsquo;,',{$REPLACE,&rsquo;,',{$REPLACE,&ldquo;,&quot;,{$REPLACE,&rdquo;,&quot;,{$REPLACE,&raquo;, ,{$STRIP_TAGS,{PRETTY_NAME*}}}}}}}}" />
			{DESCRIPTION}
		</div>
	{+END}

	<div id="error_{NAME*}" style="display: none" class="input_error_here"></div>

	<input type="hidden" id="required_posted__{NAME*}" name="require__{NAME*}" value="{$?,{REQUIRED*},1,0}" />

	<script type="text/javascript">// <![CDATA[
		set_up_change_monitor('form_table_field_input__{NAME*}');
	//]]></script>
</div>
