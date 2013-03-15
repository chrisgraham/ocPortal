{$SET,FIRST_IMAGE_ID,{ID}}

<figure>
	<div>
		<a rel="lightbox" href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
	</div>

	{+START,IF_NON_EMPTY,{COMMENT}}
		<figcaption class="associated_details">
			{COMMENT}
		</figcaption>
	{+END}

	{+START,IF_NON_EMPTY,{EDIT_URL}}
		<p class="associated_link associated_links_block_group">
			<a href="{EDIT_URL*}" title="{!EDIT_IMAGE}, #{ID*}">{!_EDIT_LINK}</a>
		</p>
	{+END}
</figure>
