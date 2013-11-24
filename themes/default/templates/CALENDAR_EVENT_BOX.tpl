<div class="box box___calendar_event_box"><div class="box_inner">
	<h3>
		{+START,IF,{GIVE_CONTEXT}}
			{!CONTENT_IS_OF_TYPE,{!EVENT},{TITLE*}}
		{+END}

		{+START,IF,{$NOT,{GIVE_CONTEXT}}}
			{+START,FRACTIONAL_EDITABLE,{TITLE},title,_SEARCH:cms_calendar:__ed:{ID},0}{TITLE*}{+END}
		{+END}
	</h3>

	{+START,IF_NON_EMPTY,{SUMMARY}}
		<div class="float_surrounder">
			{SUMMARY`}
		</div>
	{+END}

	<ul class="horizontal_links associated_links_block_group force_margin">
		<li><a title="{TITLE*}: {!READ_MORE}" class="more" href="{URL*}">{!READ_MORE}</a></li>
	</ul>
</div></div>
