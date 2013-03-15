{+START,IF_NON_EMPTY,{PIC}}
	<div class="left">
		<div onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{+START,IF_PASSED,COMMENTS}{$TRUNCATE_LEFT^;*,{COMMENTS},100,0,1}{+END}','auto');"><a href="{URL*}"><img src="{$THUMBNAIL*,{PIC},90x90,,,,pad,both,#00000000}" title="" alt="{TITLE*}" /></a></div>
		<p class="associated_details"><strong>{TITLE*}</strong><br />{ADD_DATE*}<br />({LANG})</p>
	</div>
{+END}
