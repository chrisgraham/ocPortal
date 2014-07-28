{$,If editing this template, make sure that the set_required Javascript function is updated}

{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}

<tr class="field_input">
	<th id="form_table_field_name__{$GET,randomised_id}" class="form_table_field_name{+START,IF,{REQUIRED}} required{+END}">
		{+START,IF,{$MOBILE}}
			{COMCODE}

			{+START,INCLUDE,FORM_SCREEN_FIELD_DESCRIPTION}{+END}
		{+END}

		<span class="form_field_name field_name">
			{$SET,show_label,{$AND,{$IS_NON_EMPTY,{NAME}},{$NOT,{SKIP_LABEL}}}}
			{+START,IF,{$GET,show_label}}
				<label for="{NAME*}">{PRETTY_NAME*}</label>

				<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_HTML*,{PRETTY_NAME}}" />
			{+END}
			{+START,IF,{$NOT,{$GET,show_label}}}
				{PRETTY_NAME*}
			{+END}
		</span>

		{+START,IF,{$NOT,{$GET,no_required_stars}}}
			<span id="required_readable_marker__{$GET,randomised_id}" style="display: {$?,{REQUIRED},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>
		{+END}

		{+START,IF_PASSED,DESCRIPTION_SIDE}{+START,IF_NON_EMPTY,{DESCRIPTION_SIDE}}
			<p class="associated_details">{DESCRIPTION_SIDE}</p>
		{+END}{+END}
	</th>

	{+START,IF,{$MOBILE}}
		</tr>

		<tr class="field_input">
	{+END}

	<td id="form_table_field_input__{$GET,randomised_id}" class="form_table_field_input{+START,IF,{REQUIRED}} required{+END}">
		{+START,IF,{$NOT,{$MOBILE}}}
			{COMCODE}
		{+END}

		{INPUT}

		{+START,IF,{$NOT,{$MOBILE}}}
			{+START,INCLUDE,FORM_SCREEN_FIELD_DESCRIPTION}{+END}
		{+END}

		<div id="error_{$GET,randomised_id}" style="display: none" class="input_error_here"{+START,IF_PASSED,PATTERN_ERROR} data-errorRegexp="{PATTERN_ERROR*}"{+END}></div>

		{+START,IF_NON_EMPTY,{NAME}}
			<input type="hidden" id="required_posted__{$GET,randomised_id}" name="require__{NAME*}" value="{$?,{REQUIRED*},1,0}" />
		{+END}

		<script>// <![CDATA[
			set_up_change_monitor('form_table_field_input__{$GET,randomised_id}');
		//]]></script>
	</td>
</tr>

