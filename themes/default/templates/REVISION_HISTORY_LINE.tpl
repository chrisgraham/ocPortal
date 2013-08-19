<li>
	{+START,SET,tooltip}
		{+START,IF_EMPTY,{RENDERED_DIFF}}<em>{!DIFF_NONE;}</em>{+END}
		{$?,{$LT,{$LENGTH,{RENDERED_DIFF}},5000},<div class="diff">{$REPLACE,\\n,<br />,{RENDERED_DIFF;}}</div>,<em>{!DIFF_TOO_MUCH;}</em>}
	{+END}

	{!REVISION_TAG_LINE,{EDITOR*},{DATE*},{RESTORE_URL*},{SIZE*},{$STRIP_TAGS,{DATE*}}}
	<img onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{$GET;^*,tooltip}','500px',null,'auto',true,true);" onmousemove="if (typeof window.activate_tooltip!='undefined') reposition_tooltip(this,event,true);" src="{$IMG*,help}" alt="{!DIFF}" />
</li>

