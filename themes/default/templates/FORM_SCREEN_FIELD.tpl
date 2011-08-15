{$,If editing this template, make sure that the setRequired Javascript function is updated}
<tr class="field_input">
	{$SET,randomised_id,{$?,{$IS_EMPTY,{BORING_NAME*}},{$RAND},{BORING_NAME*}}}
	<th id="requirea__{$GET,randomised_id}" abbr="{NAME=}" class="de_th {$?,{REQUIRED*},dottedborder_barrier_a_required,dottedborder_barrier_a_nonrequired}">
		<span class="form_field_name field_name">
			<span id="requireb__{$GET,randomised_id}" style="display: {$?,{REQUIRED*},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>{NAME*}
		</span>

		{+START,IF_NON_EMPTY,{COMCODE}}
			<p class="comcode_supported">
				<input type="hidden" name="comcode__{$GET,randomised_id}" value="1" />
				{COMCODE}
			</p>
		{+END}

		{+START,IF_PASSED,DESCRIPTION_SIDE}{+START,IF_NON_EMPTY,{DESCRIPTION_SIDE}}
			<p class="associated_caption">{DESCRIPTION_SIDE}</p>
		{+END}{+END}
	</th>
	
	{+START,IF,{$MOBILE}}
		</tr>

		<tr class="field_input">
	{+END}

	<td id="required__{$GET,randomised_id}" class="{$?,{REQUIRED*},dottedborder_barrier_b_required,dottedborder_barrier_b_nonrequired}">
		<div id="error_{$GET,randomised_id}" style="display: none" class="input_error_here"></div>
		{$SET,show_label,{$AND,{$IS_NON_EMPTY,{BORING_NAME}},{$NOT,{SKIP_LABEL}}}}
		{+START,IF,{$GET,show_label}}
			<div class="accessibility_hidden"><label for="{BORING_NAME*}">{NAME*}</label></div>
		{+END}
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<input type="hidden" name="label_for__{BORING_NAME*}" value="{$TRIM,{$REPLACE,&lsquo;,',{$REPLACE,&rsquo;,',{$REPLACE,&ldquo;,&quot;,{$REPLACE,&rdquo;,&quot;,{$REPLACE,&raquo;, ,{$STRIP_TAGS,{NAME*}}}}}}}}" />
		{+END}
		{INPUT}
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_caption{+START,IF,{$AND,{$EQ,{$SUBSTR_COUNT,{INPUT}, name="},2},{$EQ,{$SUBSTR_COUNT,{INPUT},type="file"},0},{$EQ,{$SUBSTR_COUNT,{INPUT},type="checkbox"},1}}} field_checkbox_description{+END}">{+START,IF,{$GET,show_label}}<label for="{BORING_NAME*}">{+END}{DESCRIPTION}{+START,IF,{$GET,show_label}}</label>{+END}</div>
		{+END}
		<input type="hidden" id="requirec__{$GET,randomised_id}" name="require__{BORING_NAME*}" value="{$?,{REQUIRED*},1,0}" />

		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'load',function () {
				if (typeof window.setUpChangeMonitor!='undefined')
				{
					ch=document.getElementById('required__{$GET,randomised_id}');
					if (ch) setUpChangeMonitor(ch.parentNode);
				}
			} );
		//]]></script>
	</td>
</tr>

