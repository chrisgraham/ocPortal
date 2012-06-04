{CONTENT}

{+START,IF_NON_EMPTY,{AWARDEE_USERNAME}}
	<p class="additional_details">
		{!AWARDED_TO,<a href="{AWARDEE_PROFILE_URL*}">{AWARDEE_USERNAME*}</a>}
	</p>
{+END}
