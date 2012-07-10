<section class="box box___gallery_image_box"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h2>{TITLE*}</h2>
	{+END}

	{$PREG_REPLACE,^\s*<section class="box [^"]+"><div class="box_inner">,,{$PREG_REPLACE,</div></section>\s*$,,{CONTENT}}}

	{+START,IF_NON_EMPTY,{AWARDEE_USERNAME}}
		<p class="additional_details">
			{!AWARDED_TO,<a href="{AWARDEE_PROFILE_URL*}">{AWARDEE_USERNAME*}</a>}
		</p>
	{+END}

	<ul class="horizontal_links associated_links_block_group force_margin">
		{+START,IF_NON_EMPTY,{SUBMIT_URL}}
			<li><a rel="add" href="{SUBMIT_URL*}">{!ADD}</a></li>
		{+END}
		<li><a href="{ARCHIVE_URL*}" title="{!ARCHIVES}: {TYPE*}">{!ARCHIVES}</a></li>
	</ul>
</div></section>
