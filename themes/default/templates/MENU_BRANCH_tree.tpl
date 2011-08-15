<li class="{$?,{CURRENT},current,non_current} {$?,{$IS_EMPTY,{IMG}},has_no_img,has_img}">
	{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}
	{+START,IF_EMPTY,{CHILDREN}}
		<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}>{CAPTION}</a>
	{+END}
	{+START,IF_NON_EMPTY,{CHILDREN}}
		<a href="#" class="drawer" onclick="event.returnValue=false; toggleSectionInline('{MENU|*;}_{RANDOM*;}','block'); return false;">{CAPTION}</a>
		<ul id="{MENU|*;}_{RANDOM*}" style="display: {DISPLAY*}">
			{CHILDREN}
		</ul>
	{+END}
</li>
