"use strict";

function load_realtime_rain()
{
	if ((typeof window.realtime_rain_button_load_handler=='undefined') || (!window.ajax_supported))
	{
		if (document.getElementById('realtime_rain_img_loader'))
		{
			setTimeout(load_realtime_rain,200);
			return false;
		}

		var img=document.getElementById('realtime_rain_img');
		setOpacity(img,0.4);
		var tmp_element=document.createElement('img');
		tmp_element.src="{$IMG,bottom/loading}".replace(/^http:/,window.location.protocol);
		tmp_element.style.position='absolute';
		tmp_element.style.left=findPosX(img)+'px';
		tmp_element.style.top=findPosY(img)+'px';
		tmp_element.id='realtime_rain_img_loader';
		img.parentNode.appendChild(tmp_element);
		fixImage(img);

		require_javascript("javascript_ajax");
		require_javascript("javascript_realtime_rain");
		require_javascript("javascript_more");
		require_css("realtime_rain");
		window.setTimeout(load_realtime_rain,200);
		return false;
	}
	if ((window.ajax_supported) && (ajax_supported()) && (typeof window.realtime_rain_button_load_handler!='undefined'))
	{
		return realtime_rain_button_load_handler();
	}
	window.location.href=document.getElementById('realtime_rain_button').href;
	return false;
}
