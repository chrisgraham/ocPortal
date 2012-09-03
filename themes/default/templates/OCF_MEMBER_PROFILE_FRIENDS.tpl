{FRIENDS}

{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}{REMOVE_FRIEND_URL}}
	<ul class="horizontal_links associated_links_block_group force_margin">
		{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}}
			<li><a href="{ADD_FRIEND_URL*}">{!ocf:_ADD_AS_FRIEND,{$USERNAME*,{MEMBER_ID}}}</a></li>
		{+END}
		{+START,IF_NON_EMPTY,{REMOVE_FRIEND_URL}}
			<li><a href="{REMOVE_FRIEND_URL*}">{!ocf:_REMOVE_AS_FRIEND,{$USERNAME*,{MEMBER_ID}}}</a></li>
		{+END}
	</ul>
{+END}
