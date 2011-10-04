{+START,IF,{$OR,{$IS_EMPTY,{$_GET,mge_start}},{$NEQ,{_GUID},bf84d65b8dd134ba6cd7b1b7bde99de2}}}
	{+START,BOX,{TITLE*},{$?,{$AND,{HIGH},{$NOT,{$GET,in_panel}}},100%|230px,100%},{$?,{$GET,in_panel},panel,{$?,{HIGH},curved,{$?,{$EQ,{_GUID},bf84d65b8dd134ba6cd7b1b7bde99de2},invisible,classic}}},,,{$?,{$IS_NON_EMPTY,{SUBMIT_URL}},<a title="{ADD_NAME*}: {TITLE*}" target="_top" href="{SUBMIT_URL*}">{ADD_NAME*}</a>,}}
		<p class="block_no_entries">&raquo; {MESSAGE*}</p>
	{+END}
{+END}