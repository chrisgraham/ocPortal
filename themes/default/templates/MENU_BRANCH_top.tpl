<li class="{$?,{CURRENT},current,non_current}{+START,IF,{LAST}} last{+END}{+START,IF,{FIRST}} first{+END}"{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$NOT,{LAST}}} style="width: {$DIV_FLOAT',100,{BRETHREN_COUNT}}%"{+END}{+END}>
	<a{+START,INCLUDE,MENU_LINK_PROPERTIES}{+END}{+START,IF,{LAST}} class="last"{+END}>{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{$IMG*,{IMG}}" /> {+END}{CAPTION}</a>
</li>
