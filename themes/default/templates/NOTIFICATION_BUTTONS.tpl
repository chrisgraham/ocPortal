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
	{+START,IF_PASSED_AND_TRUE,RIGHT}<div class="float_surrounder"><div class="right">{+END}

	{$INC,notification_id}
	<form id="nenable_{$GET*,notification_id}" title="{!notifications:NOTIFICATIONS}" {+START,IF,{$NOTIFICATIONS_ENABLED,{NOTIFICATIONS_ID},{$GET,NOTIFICATIONS_TYPE}}}style="display: none" aria-hidden="true" {+END}onsubmit="set_display_with_aria(this,'none'); set_display_with_aria(document.getElementById('ndisable_{$GET;*,notification_id}'),'inline'); return open_link_as_overlay(this,null,'100%');" class="inline" rel="enable-notifications" method="post" action="{$PAGE_LINK*,{$GET,NOTIFICATIONS_PAGELINK}:redirect={$SELF_URL&*,1}}"><input type="image" class="button_page" src="{$IMG*,{$GET,button_type}/enable_notifications}" title="{!ENABLE_NOTIFICATIONS}" alt="{!ENABLE_NOTIFICATIONS}" /></form>
	<form id="ndisable_{$GET*,notification_id}" title="{!notifications:NOTIFICATIONS}" {+START,IF,{$NOT,{$NOTIFICATIONS_ENABLED,{NOTIFICATIONS_ID},{$GET,NOTIFICATIONS_TYPE}}}}style="display: none" aria-hidden="true" {+END}onsubmit="set_display_with_aria(this,'none'); set_display_with_aria(document.getElementById('nenable_{$GET;*,notification_id}'),'inline'); return open_link_as_overlay(this,null,'100%');" class="inline" rel="disable-notifications" method="post" action="{$PAGE_LINK*,{$GET,NOTIFICATIONS_PAGELINK}:redirect={$SELF_URL&*,1}}"><input type="image" class="button_page" src="{$IMG*,{$GET,button_type}/disable_notifications}" title="{!DISABLE_NOTIFICATIONS}" alt="{!DISABLE_NOTIFICATIONS}" /></form>

	{+START,IF_PASSED_AND_TRUE,RIGHT}</div></div>{+END}
{+END}
