{$INIT,follower,_false}
<div class="medborder boxes_together{+START,IF,{$GET,follower}} boxes_together_follower{+END}"><div class="medborder_box">
	<span class="right">{DATE*}</span>
	<a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{TITLE_PLAIN},title,_SEARCH:cms_news:type=__ed:id={ID},_true}{TITLE}{+END}</a>
</div></div>
{$SET,follower,{$BROWSER_MATCHES,ie6}}