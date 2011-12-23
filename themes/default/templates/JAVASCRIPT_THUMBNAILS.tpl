"use strict";

var thumbFadeTimers=[];

/* Originally based on a Dynamic Drive Script [with this function name], but no original code remaining */
function nereidFade(fadeElement,destPercentOpacity,periodInMsecs,increment,destroyAfter)
{
	if (!fadeElement) return;

	{+START,IF,{$VALUE_OPTION,disable_animations}}
		setOpacity(fadeElement,destPercentOpacity/100.0);
		return;
	{+END}

	if (typeof thumbFadeTimers=='undefined') return;
	if (typeof fadeElement.faderKey=='undefined') fadeElement.faderKey=fadeElement.id+'_'+Math.round(Math.random()*1000000);

	if (thumbFadeTimers[fadeElement.faderKey])
	{
		window.clearTimeout(thumbFadeTimers[fadeElement.faderKey]);
		thumbFadeTimers[fadeElement.faderKey]=null;
	}

	var again;
	if ((window.is_ie) && (is_ie()) && (typeof fadeElement.style.opacity=='undefined'))
	{
		if ((typeof fadeElement.filters=='undefined') || (typeof fadeElement.filters=='unknown')) fadeElement.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity='100')";
		if ((typeof fadeElement.filters=='undefined') || (typeof fadeElement.filters=='unknown') || (!fadeElement.filters['DXImageTransform.Microsoft.Alpha'])) return;
		var diff=destPercentOpacity-fadeElement.filters['DXImageTransform.Microsoft.Alpha'].opacity;
		fadeElement.filters['DXImageTransform.Microsoft.Alpha'].enabled=1;
		var direction=1;
		if (increment>0)
		{
			if (fadeElement.filters['DXImageTransform.Microsoft.Alpha'].opacity>destPercentOpacity)
			{
				direction=-1;
			}
			increment=Math.min(direction*diff,increment);
		} else
		{
			if (fadeElement.filters['DXImageTransform.Microsoft.Alpha'].opacity<destPercentOpacity)
			{
				direction=-1;
			}
			increment=Math.max(direction*diff,increment);
		}
		fadeElement.filters['DXImageTransform.Microsoft.Alpha'].opacity+=direction*increment;

		again=(fadeElement.filters['DXImageTransform.Microsoft.Alpha'].opacity!=destPercentOpacity);
		if ((!again) && (destPercentOpacity==100))
		{
			fadeElement.filters['DXImageTransform.Microsoft.Alpha'].enabled=0;
		}
	} else
	{
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
		} else again=true;
	}
	if (again)
	{
		thumbFadeTimers[fadeElement.faderKey]=window.setTimeout(function() { nereidFade(fadeElement,destPercentOpacity,periodInMsecs,increment,destroyAfter); },periodInMsecs);
	} else
	{
		if (destroyAfter) fadeElement.parentNode.removeChild(fadeElement);
	}
}

