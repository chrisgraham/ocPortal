<section class="box box___block_no_entries"><div class="box_inner">
	<h3>{TITLE*}</h3>

	<p class="nothing_here">{MESSAGE*}</p>

	{+START,IF_NON_EMPTY,{SUBMIT_URL}}
		<ul class="horizontal_links associated_links_block_group">
			<li><a target="_top" href="{SUBMIT_URL*}">{ADD_NAME*}</a></li>
		</ul>
	{+END}
</div></section>
