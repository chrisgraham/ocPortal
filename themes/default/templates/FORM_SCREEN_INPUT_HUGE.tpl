{$SET,randomised_id,{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}}

<tr>
	<th id="form_table_field_name__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="form_table_description_above_cell{+START,IF,{REQUIRED}} required{+END}">
		<input type="hidden" name="label_for__{NAME*}" value="{$STRIP_TAGS,{PRETTY_NAME*}}" />

		<span class="field_name">
			<span id="required_readable_marker__{$?,{$IS_EMPTY,{NAME*}},{$RAND},{NAME*}}" style="display: {$?,{REQUIRED*},inline,none}"><span class="required_star">*</span> <span class="accessibility_hidden">{!REQUIRED}</span></span>

			<label for="{NAME*}">{PRETTY_NAME*}</label>
		</span>

		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="associated_details">{DESCRIPTION}</div>
		{+END}
	</th>
</tr>

<tr class="field_input">
	<td id="form_table_field_input__{$GET,randomised_id}" {+START,IF,{$NOT,{$MOBILE}}}colspan="2" {+END}class="form_table_huge_field {+START,IF,{REQUIRED}} required{+END}">
		<div id="container_for_{NAME*}" class="constrain_field">
			<textarea tabindex="{TABINDEX*}" class="{+START,IF,{SCROLLS}}textarea_scroll{+END} input_text{_REQUIRED} wide_field" cols="70" rows="{ROWS*}" id="{NAME*}" name="{NAME*}">{DEFAULT*}</textarea>

			{+START,IF_PASSED_AND_TRUE,RAW}<input type="hidden" name="pre_f_{NAME*}" value="1" />{+END}
		</div>

		<script type="text/javascript">// <![CDATA[
			set_up_change_monitor('form_table_field_input__{$GET,randomised_id}');
		//]]></script>
	</td>
</tr>

