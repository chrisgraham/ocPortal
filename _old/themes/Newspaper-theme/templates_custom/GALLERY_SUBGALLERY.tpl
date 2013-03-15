{+START,IF_NON_EMPTY,{PIC}}
	<div class="left"><a href="{URL*}"><img src="{$THUMBNAIL*,{PIC},130x130,,,,crop,both,#00000000}" title="" alt="{TITLE*}" /></a></div>
{+END}
<a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{TITLE},fullname,_SEARCH:cms_galleries:type=__ec:id={ID}}{TITLE*}{+END}</a>

{+START,IF_PASSED,COMMENTS}{+START,IF_NON_EMPTY,{COMMENTS}}
	<div class="associated_details">{$TRUNCATE_LEFT,{COMMENTS},100,0,1}	({LANG})</div>
{+END}{+END}
