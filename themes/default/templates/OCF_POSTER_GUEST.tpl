{+START,IF,{$EQ,{POSTER_USERNAME},{!SYSTEM}}}
	<em>{!SYSTEM}</em>
{+END}
{+START,IF,{$NEQ,{POSTER_USERNAME},{!SYSTEM}}}
	{+START,IF_EMPTY,{IP_LINK}}
	<a class="ocf_guest_poster non_link" href="#" onclick="return false;" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{POSTER_DETAILS*;~}','auto',null,null,null,true);">{POSTER_USERNAME*}</a>
	{+END}
	{+START,IF_NON_EMPTY,{IP_LINK}}
	<a class="ocf_guest_poster" href="{IP_LINK*}" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{POSTER_DETAILS*;~}','auto',null,null,null,true);">{POSTER_USERNAME*}</a>
	{+END}
{+END}
