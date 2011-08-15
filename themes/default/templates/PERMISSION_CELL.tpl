<td>
	<div class="accessibility_hidden"><label for="{NAME*}">{HUMAN*}</label></div>
	{+START,IF,{$NOT,{CHECKED}}}
		<input onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{HUMAN*;}','20%');" alt="{HUMAN*}" type="checkbox" id="{NAME*}" name="{NAME*}" value="1" />
	{+END}
	{+START,IF,{CHECKED}}
		<input onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{HUMAN*;}','20%');" alt="{HUMAN*}" type="checkbox" id="{NAME*}" name="{NAME*}" checked="checked" value="1" />
	{+END}
</td>

