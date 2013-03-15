{TITLE}

{+START,IF_NON_EMPTY,{BUDDIES}}
	<ul class="ocf_profile_friends">
		{+START,LOOP,BUDDIES}
			<li onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{BOX*;~}','500px');">&raquo; <a href="{URL*}">{USERNAME*}</a><br />&nbsp;&nbsp;&nbsp;{USERGROUP*}</li>
		{+END}
	</ul>
{+END}
{+START,IF_EMPTY,{BUDDIES}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
	<br />
	<div class="float_surrounder">
		{RESULTS_BROWSER}
	</div>
{+END}
