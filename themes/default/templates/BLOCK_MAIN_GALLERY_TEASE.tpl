{CONTENT}

{+START,IF_EMPTY,{CONTENT}}
	<div class="gallery_tease_pic_wrap"><div class="gallery_tease_pic">
		<div class="box box___gallery_tease_pic"><div class="box_inner">
			<p class="nothing_here">
				{!NO_ENTRIES}
			</p>
		</div>
	</div>
{+END}

{+START,IF_NON_EMPTY,{PAGINATION}}
	<div class="pagination_spacing float_surrounder">
		{PAGINATION}
	</div>
{+END}
