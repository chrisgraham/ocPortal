{+START,IF_PASSED,ID}
<a name="title__{ID*}" id="title__{ID*}"></a>
{+END}

<h1 class="main_page_title"{$?,{$VALUE_OPTION,html5}, itemprop="name" role="banner"}>
	{TITLE}

	{+START,IF_PASSED,AWARDS}
		{+START,IF_NON_EMPTY,{AWARDS}}
			{+START,SET,AWARDS_TEXT}
				<h2>{!AWARD_WINNER}</h2>
				<p>{!AWARDS_WON,{AWARDS}}</p>
				<ul>
					{+START,LOOP,AWARDS}
						<li>
							<strong>{AWARD_TYPE*}</strong><br />
							{!AWARD_ON,{$DATE*,1,1,1,{AWARD_TIMESTAMP}}}
						</li>
					{+END}
				</ul>
			{+END}
			<img onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$GET^;*,AWARDS_TEXT}','auto',null,null,false,true);" title="" alt="{!AWARD_WINNER}" src="{$IMG*,awarded}" />
		{+END}
	{+END}
</h1>
{+START,IF_NON_EMPTY,{HELP_URL}}
	<a rel="external" title="{!HELP}: {!LINK_NEW_WINDOW}" target="_blank" href="{HELP_URL*}#{HELP_TERM*}"><img title="{!HELP}" alt="{!HELP}" src="{$IMG*,help}" /></a>
{+END}

{+START,IF_PASSED,SUB}
	<div class="page_title_tagline">
		{SUB`}
	</div>
{+END}
