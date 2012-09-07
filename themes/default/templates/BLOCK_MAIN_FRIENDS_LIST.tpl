{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
	<div id="{$GET*,wrapper_id}">
		<p>{!DESCRIPTION_FRIENDS,{$USERNAME*,{MEMBER_ID}}}</p>

		{+START,IF_NON_EMPTY,{FRIENDS}}
			<ul class="ocf_profile_friends actions_list raw_grow_spot">
				{+START,LOOP,FRIENDS}
					<li onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{BOX*;~}','500px');"><a href="{URL*}">{USERNAME*}</a> <span class="associated_details">{USERGROUP*}</span></li>
				{+END}
			</ul>
		{+END}
		{+START,IF_EMPTY,{FRIENDS}}
			<p class="nothing_here">{!NO_ENTRIES}</p>
		{+END}

		{+START,IF_NON_EMPTY,{PAGINATION}}
			<div class="float_surrounder ajax_block_wrapper_links">
				{PAGINATION}
			</div>
		{+END}

		{+START,INCLUDE,AJAX_PAGINATION}{+END}
	</div>
{+END}

{+START,IF,{$EQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{+START,LOOP,FRIENDS}
		<li onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{BOX*;~}','500px');"><a href="{URL*}">{USERNAME*}</a> <span class="associated_details">{USERGROUP*}</span></li>
	{+END}

	{PAGINATION}
{+END}

