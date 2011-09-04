<li class="{$?,{CURRENT},current,non_current}{+START,IF,{LAST}} last{+END}"{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$NOT,{LAST}}} style="width: {$DIV_FLOAT',99.5,{BRETHREN_COUNT}}%"{+END}{+END}> {$,99 instead of 100 for ie6 bug}
	<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{LAST}} class="last"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" />{+END}{+START,IF_EMPTY,{IMG}}&raquo; {+END}{CAPTION}</a>
</li>
