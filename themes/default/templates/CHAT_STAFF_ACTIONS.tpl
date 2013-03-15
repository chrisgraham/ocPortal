{+START,IF_NON_EMPTY,{EDIT_URL}{BAN_URL}{CHAT_BAN_URL}}<span class="associated_details">[
  {$SET,previous,0}
  {+START,IF_NON_EMPTY,{EDIT_URL}}
	  <a rel="edit" target="_blank" title="{!EDIT}: {!LINK_NEW_WINDOW}" href="{EDIT_URL*}">{!EDIT}</a>{$SET,previous,1}
  {+END}
  {+START,IF_NON_EMPTY,{BAN_URL}}
	  {+START,IF,{$GET,previous}} | {+END} <a target="_blank" title="{!SUBMITTER_BAN}: {!LINK_NEW_WINDOW}" href="{BAN_URL*}">{!SUBMITTER_BAN}</a>{$SET,previous,1}
  {+END}
  {+START,IF_NON_EMPTY,{CHAT_BAN_URL}}
	  {+START,IF,{$GET,previous}} | {+END} <a target="_blank" title="{!CHAT_BAN}: {!LINK_NEW_WINDOW}" href="{CHAT_BAN_URL*}">{!CHAT_BAN}</a>
  {+END}
  {+START,IF_NON_EMPTY,{CHAT_UNBAN_URL}}
	  {+START,IF,{$GET,previous}} | {+END} <a target="_blank" title="{!CHAT_UNBAN}: {!LINK_NEW_WINDOW}" href="{CHAT_UNBAN_URL*}">{!CHAT_UNBAN}</a>
  {+END}
]</span>{+END}

