{+START,BOX,{TITLE}}
	{CONTENT}

	{+START,IF_NON_EMPTY,{SUBMIT_URL}{ARCHIVE_URL}}
		<p class="community_block_tagline" style="margin-bottom: 0">
			[
				{+START,IF_NON_EMPTY,{SUBMIT_URL}}
					<a rel="add" href="{SUBMIT_URL*}">{!ADD}</a> &middot;
				{+END}
				{+START,IF_NON_EMPTY,{ARCHIVE_URL}}
					<a href="{ARCHIVE_URL*}" title="{!ARCHIVES}: {TYPE*}">{!ARCHIVES}</a>
				{+END}
			]
		</p>
	{+END}
{+END}
