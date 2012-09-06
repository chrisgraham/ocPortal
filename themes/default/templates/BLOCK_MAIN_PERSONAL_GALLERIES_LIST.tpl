{+START,IF_NON_EMPTY,{GALLERIES}}
	<div class="box box___download_category_screen"><div class="box_inner compacted_subbox_stream">
		<div>
			{GALLERIES}
		</div>
	</div></div>
{+END}
{+START,IF_EMPTY,{GALLERIES}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{+START,IF_NON_EMPTY,{PAGINATION}}
	<div class="float_surrounder">
		{PAGINATION}
	</div>
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={ADD_GALLERY_URL*}
	1_TITLE={!ADD_GALLERY}
	1_REDIRECT_HASH=galleries
	2_URL={ADD_IMAGE_URL*}
	2_TITLE={!ADD_IMAGE}
	2_REDIRECT_HASH=galleries
	3_URL={ADD_VIDEO_URL*}
	3_TITLE={!ADD_VIDEO}
	3_REDIRECT_HASH=galleries
{+END}
