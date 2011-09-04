{+START,IF_NON_EMPTY,{PIC}}
	<p><a href="{URL*}"><img src="{$THUMBNAIL*,{PIC},125x125,,,,pad,both,#00000000}" title="" alt="{TITLE*}" /></a></p>
	<p><a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{TITLE},fullname,_SEARCH:cms_galleries:type=__ec:id={ID}}{TITLE*}{+END}</a></p>
{+END}
