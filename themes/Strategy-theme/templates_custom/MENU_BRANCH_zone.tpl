{+START,IF,{$GET,done_one_zone_item}}<li class="divider"></li>{+END}
<li class="{$?,{CURRENT},current,non_current}">
	{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}
	<a {+START,IF,{$OR,{$NOT,{$HAS_ACTUAL_PAGE_ACCESS,admin_zones}},{$NEQ,{MENU},_zone_menu}}}title="{TOOLTIP*}" {+END}{+START,IF,{$AND,{$HAS_ACTUAL_PAGE_ACCESS,admin_zones},{$EQ,{MENU},_zone_menu}}}title="{+START,IF_NON_EMPTY,{TOOLTIP}}{TOOLTIP*}{+START,IF,{NEW_WINDOW}} {!LINK_NEW_WINDOW}{+END} &ndash; {+END}{$SPECIAL_CLICK_TO_EDIT#}" onmousedown="if (typeof window.handleZoneClick=='undefined') return true; if (!event) event=window.event; return handleZoneClick(this,event,'{PAGE_LINK*;}');" {+END}{+START,IF,{$AND,{$IS_NON_EMPTY,{ACCESSKEY}},{$EQ,{POSITION},0}}}accesskey="z" {+END}href="{URL*}" class="{$?,{CURRENT},current,non_current}" {+START,IF,{POPUP}}onclick="window.open(this.getAttribute('href'),'','width={POPUP_WIDTH*},height={POPUP_HEIGHT*},status=yes,resizable=yes,scrollbars=yes'); return false;" {+END}{+START,IF_NON_EMPTY,{ACCESSKEY}}accesskey="{ACCESSKEY*}" {+END}{+START,IF,{NEW_WINDOW}}target="_blank" {+END}>{CAPTION}</a>
</li>
{CHILDREN}
{$SET,done_one_zone_item,1}
