<div class="float_surrounder">
	{+START,IF_NON_EMPTY,{IMGCODE}}
		<div class="download_box_pic"><a href="{URL*}">{IMGCODE}</a></div>
	{+END}

	<h4><a title="{NAME*}: {!BY_SIMPLE,{AUTHOR*}}" href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME},name,_SEARCH:cms_downloads:type=__ed:id={ID}}{NAME*}{+END}</a></h4>

	<p class="tiny_para associated_details">
		{+START,IF_PASSED,RATING}<span>{RATING}</span>{+END}

		{+START,IF,{$INLINE_STATS}}{DOWNLOADS*} {!COUNT_DOWNLOADS}{+END}
	</p>

	<p class="tiny_para associated_details">
		{!_ADDED} {DATE*}
	</p>
</div>
