<section class="box box___gallery_image_box"><div class="box_inner">
	<h3>{!IMAGE}: {TITLE*}</h3>

	<div>
		<a href="{URL*}">{THUMB}</a>
	</div>

	{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<p>{BREADCRUMBS}</p>
	{+END}
</div></section>
