{+START,IF_NON_EMPTY,{PIC}}
	<div class="left">
		<div onmouseout="if (typeof window.deactivate_tooltip!='undefined') deactivate_tooltip(this,event);" onmousemove="if (typeof window.activate_tooltip!='undefined') reposition_tooltip(this,event);" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{+START,IF_PASSED,COMMENTS}{$TRUNCATE_LEFT^;*,{COMMENTS},100,0,1}{+END}','auto');"><a href="{URL*}"><img src="{$THUMBNAIL*,{PIC},90x90,,,,pad,both,#00000000}" title="" alt="{TITLE*}" /></a></div>
		<p class="associated_details"><strong>{TITLE*}</strong><br />{ADD_DATE*}<br />({LANG})</p>
	</div>
{+END}
