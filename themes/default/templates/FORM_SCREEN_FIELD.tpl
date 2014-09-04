{$,If editing this template, make sure that the set_required Javascript function is updated}

{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}

<tr class="field_input">
	<th id="form_table_field_name__{$GET,randomised_id}" class="form_table_field_name{+START,IF,{REQUIRED}} required{+END}">
		<span class="form_field_name field_name">
			<span id="required_readable_marker__{$GET,randomised_id}" style="display: {$?,{REQUIRED},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>

			{$SET,show_label,{$AND,{$IS_NON_EMPTY,{NAME}},{$NOT,{SKIP_LABEL}}}}
			{+START,IF,{$GET,show_label}}
				<label for="{NAME*}">{PRETTY_NAME*}</label>

				<input type="hidden" name="label_for__{NAME*}" value="{$TRIM,{$REPLACE,&lsquo;,',{$REPLACE,&rsquo;,',{$REPLACE,&ldquo;,&quot;,{$REPLACE,&rdquo;,&quot;,{$REPLACE,&raquo;, ,{$STRIP_TAGS,{PRETTY_NAME*}}}}}}}}" />
			{+END}
			{+START,IF,{$NOT,{$GET,show_label}}}
				{PRETTY_NAME*}
			{+END}
		</span>

		{+START,IF_NON_EMPTY,{COMCODE}}{+START,IF,{$NOT,{$_GET,overlay}}}
			<div class="comcode_supported">
				<input type="hidden" name="comcode__{$GET,randomised_id}" value="1" />
				{COMCODE}
			</div>
		{+END}{+END}

		{+START,IF_PASSED,DESCRIPTION_SIDE}{+START,IF_NON_EMPTY,{DESCRIPTION_SIDE}}
			<p class="associated_details">{DESCRIPTION_SIDE}</p>
		{+END}{+END}
	</th>

	{+START,IF,{$MOBILE}}
		</tr>

		<tr class="field_input">
	{+END}

	<td id="form_table_field_input__{$GET,randomised_id}" class="form_table_field_input{+START,IF,{REQUIRED}} required{+END}">
		{INPUT}

		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_details{+START,IF,{$AND,{$EQ,{$SUBSTR_COUNT,{INPUT}, name="},2},{$EQ,{$SUBSTR_COUNT,{INPUT},type="file"},0},{$EQ,{$SUBSTR_COUNT,{INPUT},type="checkbox"},1}}} field_checkbox_description{+END}">{DESCRIPTION}</div>
		{+END}

		<div id="error_{$GET,randomised_id}" style="display: none" class="input_error_here"></div>

		{+START,IF_NON_EMPTY,{NAME}}
			<input type="hidden" id="required_posted__{$GET,randomised_id}" name="require__{NAME*}" value="{$?,{REQUIRED*},1,0}" />
		{+END}

		<script type="text/javascript">// <![CDATA[
			set_up_change_monitor('form_table_field_input__{$GET,randomised_id}');
		//]]></script>
	</td>
</tr>

