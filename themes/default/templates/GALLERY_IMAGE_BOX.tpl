<section class="box box___gallery_image_box"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h3>
			{+START,IF,{GIVE_CONTEXT}}
				{!CONTENT_IS_OF_TYPE,{!IMAGE},{TITLE*}}
			{+END}

			{+START,IF,{$NOT,{GIVE_CONTEXT}}}
				{+START,FRACTIONAL_EDITABLE,{TITLE},title,_SEARCH:cms_galleries:type=__ed:id={ID},0}{TITLE*}{+END}
			{+END}
		</h3>
	{+END}

	<div>
		<a href="{URL*}">{THUMB}</a>
	</div>

	{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>{!LOCATED_IN,{BREADCRUMBS}}</p></nav>
	{+END}
</div></section>
