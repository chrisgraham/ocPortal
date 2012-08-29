<div class="box box___calendar_event_box"><div class="box_inner">
	<h3>
		{+START,IF,{GIVE_CONTEXT}}
			{!CONTENT_IS_OF_TYPE,{!EVENT},{TITLE*}}
		{+END}

		{+START,IF,{$NOT,{GIVE_CONTEXT}}}
			{TITLE*}
		{+END}
	</h3>

	{+START,IF_NON_EMPTY,{SUMMARY}}
		<div class="float_surrounder">
			{SUMMARY`}
		</div>
	{+END}
	{+START,IF_EMPTY,{SUMMARY}}
		<p>
			{!NO_SUMMARY}
		</p>
	{+END}

	<ul class="horizontal_links associated_links_block_group force_margin">
		<li><a title="{TITLE*}: {!READ_MORE}" class="more" href="{URL*}">{!READ_MORE}</a></li>
	</ul>
</div></div>
