"use strict";

var thumbnail_fading_timers=[];

function thumbnail_fade(fadeElement,destPercentOpacity,periodInMsecs,increment,destroyAfter)
{
	if (!fadeElement) return;

	{+START,IF,{$VALUE_OPTION,disable_animations}}
		set_opacity(fadeElement,destPercentOpacity/100.0);
		return;
	{+END}

	if (typeof thumbnail_fading_timers=='undefined') return;
	if (typeof fadeElement.faderKey=='undefined') fadeElement.faderKey=fadeElement.id+'_'+Math.round(Math.random()*1000000);

	if (thumbnail_fading_timers[fadeElement.faderKey])
	{
		window.clearTimeout(thumbnail_fading_timers[fadeElement.faderKey]);
		thumbnail_fading_timers[fadeElement.faderKey]=null;
	}

	var again;

	if (fadeElement.style.opacity)
	{
		var diff=(destPercentOpacity/100.0)-fadeElement.style.opacity;
		var direction=1;
		if (increment>0)
		{
			if (fadeElement.style.opacity>destPercentOpacity/100.0)
			{
				direction=-1;
			}
			var new_increment=Math.min(direction*diff,increment/100.0);
		} else
		{
			if (fadeElement.style.opacity<destPercentOpacity/100.0)
			{
				direction=-1;
			}
			var new_increment=Math.max(direction*diff,increment/100.0);
		}
		var temp=parseFloat(fadeElement.style.opacity)+direction*new_increment;
		if (temp<0.0) temp=0.0;
		if (temp>1.0) temp=1.0;
		fadeElement.style.opacity=temp;
		again=(Math.round(temp*100)!=Math.round(destPercentOpacity));
	} else again=true; // Opacity not set yet, need to call back in an event timer

	if (again)
	{
		thumbnail_fading_timers[fadeElement.faderKey]=window.setTimeout(function() { thumbnail_fade(fadeElement,destPercentOpacity,periodInMsecs,increment,destroyAfter); },periodInMsecs);
	} else
	{
		if (destroyAfter) fadeElement.parentNode.removeChild(fadeElement);
	}
}

