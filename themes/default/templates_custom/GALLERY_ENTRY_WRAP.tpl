{+START,IF,{$GET,gallery_carousel}}
	{ENTRY}
{+END}

{+START,IF,{$NOT,{$GET,gallery_carousel}}}
	<div class="gallery_grid_cell">
		{ENTRY}
	</div>
{+END}

