{+START,BOX,{TITLE*},{$?,{$AND,{HIGH},{$NOT,{$GET,in_panel}}},100%|230px,100%},{$?,{$GET,in_panel},panel,{$?,{HIGH},curved,classic}},,,{$?,{$IS_NON_EMPTY,{SUBMIT_URL}},<a title="{ADD_NAME*}: {TITLE*}" target="_top" href="{SUBMIT_URL*}">{ADD_NAME*}</a>,}}
	<p class="block_no_entries">&raquo; {MESSAGE*}</p>
{+END}
