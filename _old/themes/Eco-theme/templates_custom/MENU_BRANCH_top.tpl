<li class="{$?,{CURRENT},current,non_current}{+START,IF,{LAST}} last{+END}" style="width: {$DIV_FLOAT',99,{BRETHREN_COUNT}}%"> {$,99 instead of 100 for ie6 bug}
	<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{LAST}} class="last"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt=""  />{+END}{+START,IF_EMPTY,{IMG}}{+END} {CAPTION}</a>
</li>
