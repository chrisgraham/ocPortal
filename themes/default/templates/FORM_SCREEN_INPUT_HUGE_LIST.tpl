<tr>
	{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}
	<th id="form_table_field_name__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="form_table_description_above_cell{+START,IF,{REQUIRED}} required{+END}">
		<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_TAGS,{PRETTY_NAME*}}" />

		<span class="field_name">
			<span id="required_readable_marker__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" class="inline"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>

			<label for="{NAME*}">{PRETTY_NAME*}</label>
		</span>

		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_details">{DESCRIPTION}</div>
		{+END}
	</th>
</tr>

<tr class="field_input">
	<td id="form_table_field_input__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="form_table_huge_field{+START,IF,{REQUIRED}} required{+END}">
		{+START,IF,{INLINE_LIST}}
		<select size="{+START,IF_PASSED,SIZE}{SIZE*}{+END}{+START,IF_NON_PASSED,SIZE}15{+END}" tabindex="{TABINDEX*}" class="input_list{REQUIRED*} wide_field" id="{NAME*}" name="{NAME*}">
		{+END}
		{+START,IF,{$NOT,{INLINE_LIST}}}
		<select tabindex="{TABINDEX*}" class="input_list" id="{NAME*}" name="{NAME*}">
		{+END}
		{CONTENT}
		</select>

		<script type="text/javascript">// <![CDATA[
			set_up_change_monitor('form_table_field_input__{$GET,randomised_id}');
		//]]></script>
	</td>
</tr>

