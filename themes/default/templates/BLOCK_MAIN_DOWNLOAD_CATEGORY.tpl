{+START,SET,DC_CONTENT}
	{+START,IF_NON_EMPTY,{SUBCATEGORIES}}
		<section class="box box___block_main_download_category"><div class="box_inner">
			<h3>{!SUBCATEGORIES_HERE}</h3>

			{SUBCATEGORIES}
		</div></section>
	{+END}

	{+START,IF_NON_EMPTY,{DOWNLOADS}}
		{DOWNLOADS}
	{+END}

	{+START,IF_NON_EMPTY,{SUBMIT_URL}}
		<p class="associated_link associated_links_block_group">
			<a rel="add" href="{SUBMIT_URL*}">{!ADD_DOWNLOAD}</a>
		</p>
	{+END}
{+END}

<section class="box box___block_main_download_category"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}<h3>{TITLE*}</h3>{+END}

	{$GET,DC_CONTENT}
</div></section>
