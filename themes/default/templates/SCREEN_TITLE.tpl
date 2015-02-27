{+START,IF_PASSED,ID}
<a id="title__{ID*}"></a>
{+END}

<h1 class="screen_title"{+START,IF,{$NOT,{$GET,name_set_elsewhere}}} itemprop="name"{+END} role="banner">
	{TITLE}

	{+START,IF_PASSED,AWARDS}
		{+START,IF_NON_EMPTY,{AWARDS}}
			{+START,SET,AWARDS_TEXT}
				<h2>{!AWARD_WINNER}</h2>
				<p class="lonely_label">{!AWARDS_WON,{AWARDS}}</p>
				<ul>
					{+START,LOOP,AWARDS}
						<li>
							<strong>{AWARD_TYPE*}</strong>
							<span>{!AWARD_ON,{$DATE*,1,1,1,{AWARD_TIMESTAMP}}}</span>
						</li>
					{+END}
				</ul>
			{+END}
			<img onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{$GET*;^,AWARDS_TEXT}','auto',null,null,false,true);" title="" alt="{!AWARD_WINNER}" src="{$IMG*,awarded}" />
		{+END}
	{+END}

	{+START,IF_NON_EMPTY,{HELP_URL}}
		<a rel="external" title="{!HELP}: {!LINK_NEW_WINDOW}" target="_blank" href="{HELP_URL*}#{HELP_TERM*}"><img title="{!HELP}" alt="{!HELP}" src="{$IMG*,help}" /></a>
	{+END}
</h1>

{+START,IF_PASSED,SUB}
	<div class="title_tagline">
		{SUB}
	</div>
{+END}
