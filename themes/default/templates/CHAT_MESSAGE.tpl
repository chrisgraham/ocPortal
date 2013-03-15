<div class="chat_message{+START,IF,{OLD_MESSAGES}} chat_message_old{+END}">
	{+START,IF_NON_EMPTY,{AVATAR_URL}}
		<img class="chat_avatar" src="{AVATAR_URL*}" alt="{!AVATAR}" title="" />
	{+END}

	{+START,IF,{$NOT,{SYSTEM_MESSAGE}}}
	<div><span class="chat_message_by{+START,IF,{STAFF}} chat_operator_staff{+END}">{!BY_SIMPLE,{USER}}</span> <span class="associated_details">({TIME*})</span> <span class="c_staff_actions">{STAFF_ACTIONS}</span></div>
	<blockquote style="color: {FONT_COLOUR'}; font-family: {FONT_FACE|}">{MESSAGE}</blockquote>
	{+END}
	{+START,IF,{SYSTEM_MESSAGE}}
	<div><span class="chat_message_by{+START,IF,{STAFF}} chat_operator_staff{+END}">{!BY_SIMPLE,{!SYSTEM}}</span> <span class="associated_details">({TIME*})</span></div>
	<blockquote style="color: {FONT_COLOUR'}; font-family: {FONT_FACE|}"><strong>{MESSAGE}</strong></blockquote>
	{+END}
</div>
