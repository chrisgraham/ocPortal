<script type="text/javascript">// <![CDATA[
function ocfCheckPoll(form,min,max,error)
{
	var j=0;
	for (var i=0;i<form.elements.length;i++)
		if ((form.elements[i].checked) && ((form.elements[i].type=='checkbox') || (form.elements[i].type=='radio'))) j++;
	var answer=((j>=min) && (j<=max));
	if (!answer)
	{
		window.fauxmodal_alert(error);
	} else
	{
		disable_button_just_clicked(form.elements['poll_vote_button']);
	}
	
	return answer;
}
//]]></script>
<a name="poll_jump" id="poll_jump" rel="dovote"></a>
<form title="{!VOTE}" action="{VOTE_URL*}" method="post" onsubmit="return ocfCheckPoll(this,{MINIMUM_SELECTIONS*},{MAXIMUM_SELECTIONS*},({MINIMUM_SELECTIONS*}=={MAXIMUM_SELECTIONS*})?'{!POLL_NOT_ENOUGH_ERROR_2;,{MINIMUM_SELECTIONS*}}':'{!POLL_NOT_ENOUGH_ERROR;,{MINIMUM_SELECTIONS*},{MAXIMUM_SELECTIONS*}}');">
	<!-- Layout table for uniform auto-sizing layout -->
	<div class="wide_table_wrap"><table summary="" class="variable_table dottedborder wide_table">
		<tbody>
			<tr>
				<td colspan="2" class="tabletitle_internal">
					{+START,FRACTIONAL_EDITABLE,{QUESTION},question,_SEARCH:topics:type=_edit_poll:id={ID}}{QUESTION*}{+END}
				</td>
			</tr>
			{ANSWERS}
			{+START,IF_NON_EMPTY,{BUTTON}}
				<tr>
					<td colspan="2" class="ocf_poll_button ocf_row7">
						{BUTTON}
					</td>
				</tr>
			{+END}
			<tr>
				<td colspan="2" class="ocf_poll_meta ocf_row5">
					{PRIVATE}
					{NUM_CHOICES}
				</td>
			</tr>
		</tbody>
	</table></div>
</form>

<br />
