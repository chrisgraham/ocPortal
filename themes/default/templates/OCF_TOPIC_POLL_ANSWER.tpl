<tr>
	<td class="ocf_topic_poll_result ocf_row1">{+START,FRACTIONAL_EDITABLE,{ANSWER},answer_{I},_SEARCH:topics:type=_edit_poll:id={ID}}{ANSWER*}{+END}</td>
	<td class="ocf_topic_poll_result_2 ocf_row2">
		<div class="accessibility_hidden"><label for="vote_{I*}">{ANSWER*}</label></div>
		<input {+START,IF,{$NOT,{REAL_BUTTON}}}disabled="disabled" {+END}value="1" type="checkbox" id="vote_{I*}" name="vote_{I*}" />
	</td>
</tr>
