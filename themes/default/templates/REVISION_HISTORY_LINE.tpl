<li>
	{!REVISION_TAG_LINE,{EDITOR*},{DATE*},{RESTORE_URL*},{SIZE*},{$STRIP_TAGS,{DATE*}}}
	<img onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{+START,IF_EMPTY,{RENDERED_DIFF}}&lt;em&gt;{!DIFF_NONE=;^}&lt;/em&gt;{+END}{$?,{$LT,{$LENGTH,{RENDERED_DIFF}},3000},&lt;div class=&quot;diff&quot;&gt;{$REPLACE*,\\n,<br />,{RENDERED_DIFF;^}}&lt;/div&gt;,&lt;em&gt;{!DIFF_TOO_MUCH=;^}&lt;/em&gt;}','500px',null,'auto',true,true);" onmousemove="if (typeof window.activate_tooltip!='undefined') reposition_tooltip(this,event,true);" src="{$IMG*,help}" alt="{!DIFF}" />
</li>

