<tr>
	<th class="de_th ocf_topic_poll_result ocf_column1">{+START,FRACTIONAL_EDITABLE,{ANSWER},answer_{I},_SEARCH:topics:type=_edit_poll:id={ID}}{ANSWER*}{+END}</th>
	<td class="ocf_topic_poll_result_column2 ocf_column2">
		<div class="accessibility_hidden"><label for="vote_{I*}">{ANSWER*}</label></div>
		<input {+START,IF,{$NOT,{REAL_BUTTON}}}disabled="disabled" {+END}value="1" type="checkbox" id="vote_{I*}" name="vote_{I*}" />
	</td>
</tr>
