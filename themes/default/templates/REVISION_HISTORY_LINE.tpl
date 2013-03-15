<li>
	{!REVISION_TAG_LINE,{EDITOR*},{DATE*},{RESTORE_URL*},{SIZE*},{$STRIP_TAGS,{DATE*}}}
	<img onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{+START,IF_EMPTY,{RENDERED_DIFF}}&lt;em&gt;{!DIFF_NONE=^;}&lt;/em&gt;{+END}{$?,{$LT,{$LENGTH,{RENDERED_DIFF}},3000},&lt;div class=&quot;diff&quot;&gt;{$REPLACE*,\\n,<br />,{RENDERED_DIFF;^}}&lt;/div&gt;,&lt;em&gt;{!DIFF_TOO_MUCH=^;}&lt;/em&gt;}','500px',null,'auto',true,true);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event,true);" src="{$IMG*,help}" alt="{!DIFF}" title="" />
</li>

