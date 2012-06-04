{+START,IF,{$CONFIG_OPTION,enable_image_fading}}
	{+START,IF,{$NOT,{JS_TOOLTIP}}}
		<img alt="{CAPTION^*~}" title="{$STRIP_TAGS,{CAPTION^*~}}" class="img_thumb" onmouseover="if (typeof window.thumbnail_fade!='undefined') thumbnail_fade(this,100,70,5)" onmouseout="if (typeof window.thumbnail_fade!='undefined') thumbnail_fade(this,70,50,5)" src="{URL*}" />
	{+END}
	{+START,IF,{JS_TOOLTIP}}
		<img alt="" class="img_thumb" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{CAPTION^;*~}','40%'); if (typeof window.thumbnail_fade!='undefined') thumbnail_fade(this,100,70,5);" onmouseout="if (typeof window.deactivate_tooltip!='undefined') deactivate_tooltip(this,event); if (typeof window.thumbnail_fade!='undefined') thumbnail_fade(this,70,50,5);" src="{URL*}" />
	{+END}
{+END}

{+START,IF,{$NOT,{$CONFIG_OPTION,enable_image_fading}}}
	{+START,IF,{$NOT,{JS_TOOLTIP}}}
		<img alt="{CAPTION=~}" title="{$STRIP_TAGS,{CAPTION^*~}}" src="{URL*}" />
	{+END}
	{+START,IF,{JS_TOOLTIP}}
		<img alt="" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{CAPTION^;*~}','40%');" src="{URL*}" />
	{+END}
{+END}
