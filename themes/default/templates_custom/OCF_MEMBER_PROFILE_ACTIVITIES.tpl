{+START,IF,{$EQ,{MEMBER_ID},{$USER}}}
	{$BLOCK,block=main_activities_state,member={MEMBER_ID},mode=all,param=}

	<hr class="spaced_rule" />
{+END}

{$BLOCK,block=main_activities,member={MEMBER_ID},mode=all,param=}
