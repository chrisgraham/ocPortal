{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}{REMOVE_FRIEND_URL}{ALL_BUDDIES_LINK}}
	<p class="ocf_profile_add_friend">
		{+START,IF,{$NOT,{$MOBILE}}}[{+END}
		{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}}
			<a href="{ADD_FRIEND_URL*}">{!_ADD_AS_FRIEND,{$USERNAME*,{MEMBER_ID}}}</a>
		{+END}
		{+START,IF_NON_EMPTY,{REMOVE_FRIEND_URL}}
			<a href="{REMOVE_FRIEND_URL*}">{!_REMOVE_AS_FRIEND,{$USERNAME*,{MEMBER_ID}}}</a>
		{+END}
		{+START,IF_NON_EMPTY,{ALL_BUDDIES_LINK}}
			<a href="{ALL_BUDDIES_LINK*}">{!VIEW_ARCHIVE}</a>
		{+END}
		{+START,IF,{$NOT,{$MOBILE}}}]{+END}
	</p>
{+END}

{+START,IF_NON_EMPTY,{FRIENDS_A}{FRIENDS_B}}
	<p>{!DESCRIPTION_FRIENDS,{$USERNAME*,{MEMBER_ID}}}</p>

	<ul class="ocf_profile_friends">
		{+START,LOOP,FRIENDS_A}
			<li onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{BOX*;~}','500px');">&raquo; <a href="{URL*}">{USERNAME*}</a><br />&nbsp;&nbsp;&nbsp;{USERGROUP*}</li>
		{+END}
		{+START,LOOP,FRIENDS_B}
			<li onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{BOX*;~}','500px');">&raquo; <a href="{URL*}">{USERNAME*}</a><br />&nbsp;&nbsp;&nbsp;{USERGROUP*}</li>
		{+END}
	</ul>
{+END}

{+START,IF_EMPTY,{FRIENDS_A}{FRIENDS_B}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}
