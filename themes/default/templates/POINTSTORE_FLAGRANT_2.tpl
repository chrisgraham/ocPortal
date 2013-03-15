<div class="pointstore_item">
	<div class="box box___pointstore_flagrant_2"><div class="box_inner">
		<h2>{!FLAGRANT_MESSAGE}</h2>

		<p>
			{!FLAGRANT_MESSAGE_DESCRIPTION}
		</p>

		{+START,IF_NON_EMPTY,{TEXT_URL}}
			<ul class="horizontal_links associated_links_block_group">
				<li><a title="{!ENTER}: {!FLAGRANT_MESSAGE}" href="{TEXT_URL*}">{!ENTER}</a></li>
			</ul>
		{+END}
	</div></div>
</div>
