<tr>
	<th class="de_th ocf_topic_poll_radio ocf_column1">{+START,FRACTIONAL_EDITABLE,{ANSWER},answer_{I},_SEARCH:cms_polls:type=_edit_poll:id={ID}}{ANSWER*}{+END}</th>
	<td class="ocf_topic_poll_radio_2 ocf_column2"><div class="accessibility_hidden"><label for="vote_{I*}">{ANSWER*}</label></div><input {+START,IF,{$NOT,{REAL_BUTTON}}}disabled="disabled" {+END}type="radio" id="vote_{I*}" name="vote" value="{I*}" /></td>
</tr>
