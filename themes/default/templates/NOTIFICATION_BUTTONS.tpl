{+START,IF_PASSED,NOTIFICATIONS_TYPE}
	{$SET,NOTIFICATIONS_TYPE,{NOTIFICATIONS_TYPE}}
{+END}

{+START,IF_NON_PASSED,NOTIFICATIONS_TYPE}
	{$SET,NOTIFICATIONS_TYPE,{$PAGE}}
{+END}

{+START,IF_PASSED,NOTIFICATIONS_PAGELINK}
	{$SET,NOTIFICATIONS_PAGELINK,{NOTIFICATIONS_PAGELINK}}
{+END}

{+START,IF_NON_PASSED,NOTIFICATIONS_PAGELINK}
	{$SET,NOTIFICATIONS_PAGELINK,_SEARCH:notifications:advanced:{NOTIFICATIONS_ID}:notification_code={$GET,NOTIFICATIONS_TYPE}}
{+END}

{+START,IF,{$NOT,{$IS_GUEST}}}
	{+START,IF_PASSED,BREAK}<br />{+END}
	{+START,IF_PASSED,RIGHT}<div class="float_surrounder"><div class="right">{+END}

	{+START,IF,{$NOT,{$NOTIFICATIONS_ENABLED,{NOTIFICATIONS_ID},{$GET,NOTIFICATIONS_TYPE}}}}
		<form class="inline" rel="enable-notifications" method="post" action="{$PAGE_LINK*,{$GET,NOTIFICATIONS_PAGELINK}:redirect={$SELF_URL*&,1}}"><input type="image" class="button_page page_icon" src="{$IMG*,page/enable_notifications}" title="{!ENABLE_NOTIFICATIONS}" alt="{!ENABLE_NOTIFICATIONS}" /></form>
	{+END}

	{+START,IF,{$NOTIFICATIONS_ENABLED,{NOTIFICATIONS_ID},{$GET,NOTIFICATIONS_TYPE}}}
		<form class="inline" rel="disable-notifications" method="post" action="{$PAGE_LINK*,{$GET,NOTIFICATIONS_PAGELINK}:redirect={$SELF_URL*&,1}}"><input type="image" class="button_page page_icon" src="{$IMG*,page/disable_notifications}" title="{!DISABLE_NOTIFICATIONS}" alt="{!DISABLE_NOTIFICATIONS}" /></form>
	{+END}

	{+START,IF_PASSED,RIGHT}</div></div>{+END}
{+END}
