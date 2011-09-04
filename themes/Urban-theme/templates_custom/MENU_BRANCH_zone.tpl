<li class="{$?,{CURRENT},current,non_current}">
	{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}
	<a {+START,IF,{$OR,{$NOT,{$HAS_ACTUAL_PAGE_ACCESS,admin_zones}},{$NEQ,{MENU},_zone_menu}}}title="{TOOLTIP*}" {+END}{+START,IF,{$AND,{$HAS_ACTUAL_PAGE_ACCESS,admin_zones},{$EQ,{MENU},_zone_menu}}}title="{$STRIP_TAGS,{CAPTION}}: {+START,IF_NON_EMPTY,{TOOLTIP}}{TOOLTIP*}{+START,IF,{NEW_WINDOW}} {!LINK_NEW_WINDOW}{+END} &ndash; {+END}{$SPECIAL_CLICK_TO_EDIT#}" onmousedown="if (typeof window.handleZoneClick=='undefined') return true; if (!event) event=window.event; return handleZoneClick(this,event,'{PAGE_LINK*;}');" {+END}{+START,IF,{$AND,{$IS_NON_EMPTY,{ACCESSKEY}},{$EQ,{POSITION},0}}}accesskey="z" {+END}href="{URL*}" class="{$?,{CURRENT_ZONE},current,non_current}" {+START,IF,{POPUP}}onclick="window.open(this.getAttribute('href'),'','width={POPUP_WIDTH*},height={POPUP_HEIGHT*},status=yes,resizable=yes,scrollbars=yes'); return false;" {+END}{+START,IF_NON_EMPTY,{ACCESSKEY}}accesskey="{ACCESSKEY*}" {+END}{+START,IF,{NEW_WINDOW}}target="_blank" {+END}>{CAPTION}</a>
</li>
<li class="divider">.</li>
{CHILDREN}
