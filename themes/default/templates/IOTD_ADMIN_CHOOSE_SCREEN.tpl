{TITLE}

{+START,IF_PASSED,TEXT}
	<p>{TEXT}</p>
{+END}

<h2>{!CURRENT_IOTD}</h2>

{CURRENT_IOTD}
{+START,IF_EMPTY,{CURRENT_IOTD}}
	<p class="nothing_here">{!NO_IOTD}</p>
{+END}

<h2>{!UNUSED_IOTDS}</h2>

{UNUSED_IOTD}
{+START,IF_EMPTY,{UNUSED_IOTD}}
	<p class="nothing_here">{!NONE}</p>
{+END}

<a id="used"></a>
<h2>{!USED_IOTDS}</h2>

{+START,IF,{SHOWING_OLD}}
	{USED_IOTD}
	{+START,IF_EMPTY,{USED_IOTD}}
		<p class="nothing_here">{!NONE}</p>
	{+END}
{+END}

{+START,IF,{$NOT,{SHOWING_OLD}}}
	<p>
		{!NOT_SHOWING_OLD_IOTDS_YET}
	</p>
	<p>
		<a href="{USED_URL*}#used"><img class="button_page" src="{$IMG*,page/all2}" title="{!SHOW_OLD_TOO}" alt="{!SHOW_OLD_TOO}" /></a>
	</p>
{+END}

