{+START,BOX,{!USERS_ONLINE},,{$?,{$GET,in_panel},panel,classic},tray_closed,,{$?,{$AND,{$HAS_ACTUAL_PAGE_ACCESS,onlinemembers},{$OCF}},<a href="{$PAGE_LINK*,_SEARCH:onlinemembers}">{!DETAILS}</a>}}
	{CONTENT} {!NUM_GUESTS,{GUESTS*}}

	{NEWEST}

	{+START,IF_NON_EMPTY,{BIRTHDAYS}}<div>{BIRTHDAYS}</div>{+END}
{+END}
