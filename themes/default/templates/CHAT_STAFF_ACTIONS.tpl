{+START,IF_NON_EMPTY,{EDIT_URL}{BAN_URL}{CHAT_BAN_URL}}<ul class="horiz_field_sep associated_links_block_group horizontal_links">
  {+START,IF_NON_EMPTY,{EDIT_URL}}
	  <li><a rel="edit" target="_blank" title="{!EDIT}: {!LINK_NEW_WINDOW}" href="{EDIT_URL*}">{!EDIT}</a></li>
  {+END}
  {+START,IF_NON_EMPTY,{BAN_URL}}
	  <li><a target="_blank" title="{!SUBMITTER_BAN}: {!LINK_NEW_WINDOW}" href="{BAN_URL*}">{!SUBMITTER_BAN}</a></li>
  {+END}
  {+START,IF_NON_EMPTY,{CHAT_BAN_URL}}
	  <li><a target="_blank" title="{!CHAT_BAN}: {!LINK_NEW_WINDOW}" href="{CHAT_BAN_URL*}">{!CHAT_BAN}</a></li>
  {+END}
  {+START,IF_NON_EMPTY,{CHAT_UNBAN_URL}}
	  <li><a target="_blank" title="{!CHAT_UNBAN}: {!LINK_NEW_WINDOW}" href="{CHAT_UNBAN_URL*}">{!CHAT_UNBAN}</a></li>
  {+END}
</ul>{+END}

