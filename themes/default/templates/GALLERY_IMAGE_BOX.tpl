<section class="box box___gallery_image_box"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h3>{!IMAGE}: {TITLE*}</h3>
	{+END}

	<div>
		<a href="{URL*}">{THUMB}</a>
	</div>

	{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>{!LOCATED_IN,{BREADCRUMBS}}</p></nav>
	{+END}
</div></section>
