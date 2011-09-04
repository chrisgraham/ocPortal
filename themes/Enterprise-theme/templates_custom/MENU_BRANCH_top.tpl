<li class="{$?,{CURRENT},current,non_current}{+START,IF,{LAST}} last{+END}"{+START,IF,{$NOT,{$MOBILE}}} style="width: {$DIV_FLOAT',99,{BRETHREN_COUNT}}%"{+END}> {$,99 instead of 100 for ie6 bug}
	<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{LAST}} class="last"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}{+START,IF_EMPTY,{IMG}}{+END} {$TRUNCATE_LEFT,{CAPTION},12,0,1}</a>
</li>
<li class="vert-line"></li>