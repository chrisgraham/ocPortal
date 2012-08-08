{+START,IF,{$NOT,{JS_TOOLTIP}}}
	<img alt="{CAPTION^*~}" title="{$STRIP_TAGS,{CAPTION^*~}}" class="img_thumb" src="{URL*}" />
{+END}
{+START,IF,{JS_TOOLTIP}}
	<img alt="" class="img_thumb" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{CAPTION*;^~}','40%');" onmouseout="if (typeof window.deactivate_tooltip!='undefined') deactivate_tooltip(this,event);" src="{URL*}" />
{+END}
