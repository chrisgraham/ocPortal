{$REQUIRE_JAVASCRIPT,javascript_ocf_forum}

<a id="poll_jump" rel="dovote"></a>
<form class="ocf_topic_poll_form" title="{!VOTE}" action="{VOTE_URL*}" method="post" onsubmit="return ocf_check_poll(this,{MINIMUM_SELECTIONS*},{MAXIMUM_SELECTIONS*},({MINIMUM_SELECTIONS*}=={MAXIMUM_SELECTIONS*})?'{!POLL_NOT_ENOUGH_ERROR_2;,{MINIMUM_SELECTIONS*}}':'{!POLL_NOT_ENOUGH_ERROR;,{MINIMUM_SELECTIONS*},{MAXIMUM_SELECTIONS*}}');">
	<h3>{+START,FRACTIONAL_EDITABLE,{QUESTION},question,_SEARCH:topics:type=_edit_poll:id={ID}}{QUESTION*}{+END}</h3>

	<div class="wide_table_wrap">
		<table summary="{!POLL}" class="autosized_table ocf_topic_poll wide_table">
			<tbody>
				{ANSWERS}
			</tbody>
		</table>

		{+START,IF_NON_EMPTY,{BUTTON}}
			<div class="ocf_poll_button">
				{BUTTON}
			</div>
		{+END}

		{+START,IF_NON_EMPTY,{PRIVATE}{NUM_CHOICES}}
			<div class="ocf_poll_meta ocf_column6">
				{PRIVATE}
				{NUM_CHOICES}
			</div>
		{+END}
	</div>
</form>
