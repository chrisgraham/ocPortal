<li{+START,IF_NON_EMPTY,{CHILDREN}} onmousemove="return popUpMenu('{MENU|*;}_pexpand_{RANDOM*;}',null,'{MENU|*;}_p');"{+END} class="{$?,{CURRENT},current,non_current} {$?,{$IS_EMPTY,{IMG}},has_no_img,has_img}">
	{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}
	{+START,IF_NON_EMPTY,{URL}}
		<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF_NON_EMPTY,{CHILDREN}} class="drawer"{+END}{+START,IF_NON_EMPTY,{CHILDREN}} onfocus="return popUpMenu('{MENU|*;}_pexpand_{RANDOM*;}',null,'{MENU|*;}_p');"{+END}>{CAPTION}</a>
	{+END}
	{+START,IF_EMPTY,{URL}}
		<a class="non_link{+START,IF_NON_EMPTY,{CHILDREN}} drawer{+END}" onclick="return false;" href="#"{+START,IF_NON_EMPTY,{CHILDREN}} onfocus="return popUpMenu('{MENU|*;}_pexpand_{RANDOM*;}',null,'{MENU|*;}_p');"{+END}>{CAPTION}</a>
	{+END}
	{+START,IF_NON_EMPTY,{CHILDREN}}
		<ul class="nlevel" onmouseover="if (activeMenu==null) return setActiveMenu(this.id,'{MENU|*;}_p'); else return false;" onmouseout="return desetActiveMenu();" id="{MENU|*}_pexpand_{RANDOM*}" style="display: none">
			{CHILDREN}
		</ul>
	{+END}
</li>

