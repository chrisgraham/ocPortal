<div class="pointstore_item">
	<div class="box box___pointstore_ocgifts"><div class="box_inner">
		<h2>{!OCGIFTS_TITLE}</h2>

		<p>
			{!GIFTS_DESCRIPTION}
		</p>

		{+START,IF_NON_EMPTY,{NEXT_URL}}
			<ul class="horizontal_links associated_links_block_group">
				<li><a title="{!ENTER}: {!OCGIFTS_TITLE}" href="{NEXT_URL*}">{!ENTER}</a></li>
			</ul>
		{+END}
	</div></div>
</div>
