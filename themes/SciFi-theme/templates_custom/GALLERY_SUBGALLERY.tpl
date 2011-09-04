{+START,IF_NON_EMPTY,{PIC}}
	<a href="{URL*}"><img src="{$THUMBNAIL*,{PIC},110x110,,,,crop,both,#00000000}" title="" alt="{TITLE*}" /></a>
	<br />
{+END}
<a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{TITLE},fullname,_SEARCH:cms_galleries:type=__ec:id={ID}}{TITLE*}{+END}</a>

{+START,IF_PASSED,COMMENTS}{+START,IF_NON_EMPTY,{COMMENTS}}
	<p class="associated_details">{$TRUNCATE_LEFT,{COMMENTS},100,0,1}</p>
{+END}{+END}

<p class="associated_details">
	({LANG})
</p>
