{+START,IF_NON_EMPTY,{TITLE}}
	<h2>{TITLE*}</h2>
{+END}

{CONTENT}

{+START,IF_NON_EMPTY,{AWARDEE_USERNAME}}
	<p class="additional_details">
		{!AWARDED_TO,<a href="{AWARDEE_PROFILE_URL*}">{AWARDEE_USERNAME*}</a>}
	</p>
{+END}

<ul class="horizontal_links associated_links_block_group">
	{+START,IF_NON_EMPTY,{SUBMIT_URL}}
		<li><a rel="add" href="{SUBMIT_URL*}">{!ADD}</a></li>
	{+END}
	<li><a href="{ARCHIVE_URL*}" title="{!ARCHIVES}: {TYPE*}">{!ARCHIVES}</a></li>
</ul>
