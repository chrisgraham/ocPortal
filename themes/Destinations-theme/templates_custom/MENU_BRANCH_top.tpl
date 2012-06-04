{+START,IF,{$NOT,{TOP_LEVEL}}}
	<li class="{$?,{CURRENT},current,non_current}{+START,IF,{LAST}} last{+END}">
		<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{LAST}} class="last"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END} {CAPTION}</a>
	</li>
{+END}
{CHILDREN}
