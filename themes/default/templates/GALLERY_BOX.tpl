<div class="box box___gallery_box"><div class="box_inner">
	<h3>
		{+START,IF,{GIVE_CONTEXT}}
			{!CONTENT_IS_OF_TYPE,{!GALLERY},{TITLE*}}
		{+END}

		{+START,IF,{$NOT,{GIVE_CONTEXT}}}
			{+START,FRACTIONAL_EDITABLE,{TITLE},fullname,_SEARCH:cms_galleries:type=__ec:id={ID}}{TITLE*}{+END}
		{+END}
	</h3>

	{+START,IF_NON_EMPTY,{THUMB}}
		<div class="right float_separation">
			<a href="{URL*}">{$TRIM,{THUMB}}</a>
		</div>
	{+END}

	{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<p class="associated_details">{$TRUNCATE_LEFT,{DESCRIPTION},100,0,1}</p>
	{+END}{+END}

	<p class="associated_details">
		{$,Displays summary of gallery contents}
		({LANG})
	</p>

	{+START,IF_PASSED,BREADCRUMBS}{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>
			{!LOCATED_IN,{BREADCRUMBS}}
		</p></nav>
	{+END}{+END}

	<p class="shunted_button">
		<a href="{URL*}"><img class="button_pageitem" alt="{!VIEW}" title="{!VIEW}" src="{$IMG*,pageitem/goto}" /></a>
	</p>
</div></div>
