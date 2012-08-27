<div class="box box___gallery_box"><div class="box_inner">
	{+START,IF_NON_EMPTY,{THUMB}}
		<div class="right float_separation"><a href="{URL*}">{$TRIM,{THUMB}}</a></div>
	{+END}
	<h3><a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{TITLE},fullname,_SEARCH:cms_galleries:type=__ec:id={ID}}{TITLE*}{+END}</a></h3>

	{+START,IF_PASSED,COMMENTS}{+START,IF_NON_EMPTY,{COMMENTS}}
		<p class="associated_details">{$TRUNCATE_LEFT,{COMMENTS},100,0,1}</p>
	{+END}{+END}

	<p class="associated_details">
		{$,Displays summary of gallery contents}
		({LANG})
	</p>
</div></div>
