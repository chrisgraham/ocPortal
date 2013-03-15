{+START,IF_PASSED,POP3_URL}
	<p class="community_block_tagline">{!POP3} [ <a title="{!ENTER}: {!POP3}" href="{POP3_URL*}">{!ENTER}</a> ]</p>
{+END}
{+START,IF_NON_PASSED,POP3_URL}
	<p class="nothing_here">
		{!NO_POP3S}
	</p>
{+END}

