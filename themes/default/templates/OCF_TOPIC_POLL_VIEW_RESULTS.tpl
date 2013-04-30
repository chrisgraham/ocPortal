{$REQUIRE_JAVASCRIPT,javascript_ocf_forum}

<div class="ocf_topic_poll_form">
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
</div>
