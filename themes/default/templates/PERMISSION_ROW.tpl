<tr>
	<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{ABBR*}"{+END}>
		{PERMISSION*}
		{+START,IF_PASSED,DESCRIPTION}<img src="{$IMG*,help}" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{DESCRIPTION^;*}','auto');" alt="{!HELP}" title="" />{+END}
	</th>
	{CELLS}
	<td>
		{+START,IF,{$JS_ON}}
		<input type="button" value="{$?,{HAS},-,+}" onclick="{CODE*}; this.value=(this.value=='-')?'+':'-';" />
		{+END}
	</td>
</tr>
