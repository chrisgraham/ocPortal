{+START,IF,{$CONFIG_OPTION,enable_image_fading}}
	{+START,IF,{$NOT,{JS_TOOLTIP}}}
		<img alt="{CAPTION^*~}" title="{$STRIP_TAGS,{CAPTION^*~}}" class="img_thumb" onmouseover="if (typeof window.nereidFade!='undefined') nereidFade(this,100,70,5)" onmouseout="if (typeof window.nereidFade!='undefined') nereidFade(this,70,50,5)" src="{URL*}" />
	{+END}
	{+START,IF,{JS_TOOLTIP}}
		<img alt="" class="img_thumb" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{CAPTION^;*~}','40%'); if (typeof window.nereidFade!='undefined') nereidFade(this,100,70,5);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event); if (typeof window.nereidFade!='undefined') nereidFade(this,70,50,5);" src="{URL*}" />
	{+END}
{+END}

{+START,IF,{$NOT,{$CONFIG_OPTION,enable_image_fading}}}
	{+START,IF,{$NOT,{JS_TOOLTIP}}}
		<img alt="{CAPTION=~}" title="{$STRIP_TAGS,{CAPTION^*~}}" src="{URL*}" />
	{+END}
	{+START,IF,{JS_TOOLTIP}}
		<img alt="" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{CAPTION^;*~}','40%');" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" src="{URL*}" />
	{+END}
{+END}
