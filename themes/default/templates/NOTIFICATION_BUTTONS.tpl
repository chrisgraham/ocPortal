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

{+START,IF_PASSED,BUTTON_TYPE}
	{$SET,button_type,{BUTTON_TYPE}}
{+END}
{+START,IF_NON_PASSED,BUTTON_TYPE}
	{$SET,button_type,page}
{+END}

{+START,IF,{$NOT,{$IS_GUEST}}}
	{+START,IF_PASSED,BREAK}<br />{+END}
	{+START,IF_PASSED,RIGHT}<div class="float_surrounder"><div class="right">{+END}

	<form title="{!notifications:NOTIFICATIONS}" {+START,IF,{$NOTIFICATIONS_ENABLED,{NOTIFICATIONS_ID},{$GET,NOTIFICATIONS_TYPE}}}style="display: none"{$?,{$VALUE_OPTION,html5}, aria-hidden="true"} {+END}onsubmit="set_display_with_aria(this,'none'); set_display_with_aria(this.nextSibling.nextSibling,'inline'); return open_link_as_overlay(this,null,'100%');" class="inline" method="post" action="{$PAGE_LINK*,{$GET,NOTIFICATIONS_PAGELINK}:redirect={$SELF_URL*&,1}}"><input type="image" class="button_page page_icon" src="{$IMG*,{$GET,button_type}/enable_notifications}" title="{!ENABLE_NOTIFICATIONS}" alt="{!ENABLE_NOTIFICATIONS}" /></form>
	<form title="{!notifications:NOTIFICATIONS}" {+START,IF,{$NOT,{$NOTIFICATIONS_ENABLED,{NOTIFICATIONS_ID},{$GET,NOTIFICATIONS_TYPE}}}}style="display: none"{$?,{$VALUE_OPTION,html5}, aria-hidden="true"} {+END}onsubmit="set_display_with_aria(this,'none'); set_display_with_aria(this.previousSibling.previousSibling,'inline'); return open_link_as_overlay(this,null,'100%');" class="inline" method="post" action="{$PAGE_LINK*,{$GET,NOTIFICATIONS_PAGELINK}:redirect={$SELF_URL*&,1}}"><input type="image" class="button_page page_icon" src="{$IMG*,{$GET,button_type}/disable_notifications}" title="{!DISABLE_NOTIFICATIONS}" alt="{!DISABLE_NOTIFICATIONS}" /></form>

	{+START,IF_PASSED,RIGHT}</div></div>{+END}
{+END}
