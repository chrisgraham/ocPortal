{+START,IF_PASSED,FORWARDING_URL}
	<p class="community_block_tagline">{!FORWARDING} [ <a title="{!ENTER}: {!FORWARDING}" href="{FORWARDING_URL*}">{!ENTER}</a> ]</p>
{+END}
{+START,IF_NON_PASSED,FORWARDING_URL}
	<p class="nothing_here">
		{!NO_FORWARDINGS}
	</p>
{+END}

