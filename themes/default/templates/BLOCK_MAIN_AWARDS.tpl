{+START,IF_NON_EMPTY,{TITLE}}
	<h2>{TITLE*}</h2>
{+END}

{CONTENT}

{+START,IF_NON_EMPTY,{AWARDEE_USERNAME}}
	<p class="additional_details">
		{!AWARDED_TO,<a href="{AWARDEE_PROFILE_URL*}">{AWARDEE_USERNAME*}</a>}
	</p>
{+END}

<p class="community_block_tagline">
	[
		{+START,IF_NON_EMPTY,{SUBMIT_URL}}
			<a rel="add" href="{SUBMIT_URL*}">{!ADD}</a> &middot;
		{+END}
		<a href="{ARCHIVE_URL*}" title="{!ARCHIVES}: {TYPE*}">{!ARCHIVES}</a>
	]
</p>
