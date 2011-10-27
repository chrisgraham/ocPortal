<div class="float_surrounder">
	{+START,IF_NON_EMPTY,{AVATAR_URL}}
		<img class="chat_participant_avatar" style="display: block" id="avatar__{ID*}" src="{AVATAR_URL*}" alt="{!AVATAR}" title="" />
	{+END}
	<a target="_blank" title="{USERNAME*}: {$STRIP_TAGS,{!MEMBER_PROFILE,{USERNAME*}}} {!LINK_NEW_WINDOW}" href="{PROFILE_URL*}">{USERNAME*}</a><br />
	<span id="participant_online__{ROOM_ID*}__{ID*}"><em>{ONLINE*}</em></span>
</div>
<div class="associated_details">
	{!ACTIONS}:
	<ul class="actions_list_super_compact">
		<li id="buddy__{ID*}">
			&raquo; <a onclick="this.style.display='none';" target="_blank" title="{!MAKE_BUDDY}: {!LINK_NEW_WINDOW}" href="{MAKE_BUDDY_URL*}">{!MAKE_BUDDY}</a>
		</li>
		<li id="block__{ID*}">
			&raquo; <a target="_blank" title="{!BLOCK_MEMBER}: {!LINK_NEW_WINDOW}" href="{BLOCK_MEMBER_URL*}">{!BLOCK_MEMBER}</a>
		</li>
	</ul>
</div>
<br />
