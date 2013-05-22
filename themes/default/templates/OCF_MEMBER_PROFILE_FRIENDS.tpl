{+START,IF_NON_EMPTY,{FRIENDS_FORWARD}}
	<p>{!DESCRIPTION_FRIENDS,{$USERNAME*,{MEMBER_ID}}}</p>

	<ul class="ocf_profile_friends actions_list">
		{+START,LOOP,FRIENDS_FORWARD}
			<li onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{BOX*;~}','500px');">
				<a href="{URL*}">{USERNAME*}</a> <span class="associated_details">{USERGROUP*}</span>
			</li>
		{+END}
	</ul>
{+END}

{+START,IF_EMPTY,{FRIENDS_FORWARD}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}{REMOVE_FRIEND_URL}{ALL_FRIENDS_URL}}
	<ul class="horizontal_links associated_links_block_group force_margin">
		{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}}
			<li><a href="{ADD_FRIEND_URL*}">{!ocf:_ADD_AS_FRIEND,{$USERNAME*,{MEMBER_ID}}}</a></li>
		{+END}
		{+START,IF_NON_EMPTY,{REMOVE_FRIEND_URL}}
			<li><a href="{REMOVE_FRIEND_URL*}">{!ocf:_REMOVE_AS_FRIEND,{$USERNAME*,{MEMBER_ID}}}</a></li>
		{+END}
		{+START,IF_NON_EMPTY,{ALL_FRIENDS_URL}}
			<li><a href="{ALL_FRIENDS_URL*}">{!VIEW_ARCHIVE}</a></li>
		{+END}
	</ul>
{+END}
