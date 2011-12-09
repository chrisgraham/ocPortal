"use strict";

function detect_change(change_detection_url,refresh_if_changed)
{
	var response=load_XML_doc(change_detection_url,false,'refresh_if_changed='+window.encodeURIComponent(refresh_if_changed)).responseText;
	if (response=='1')
	{
		if (typeof window.getAttention!='undefined') window.getAttention();
		if (typeof window.focus!='undefined') window.focus();

		if (typeof window.soundManager!='undefined')
		{
			soundManager.play('message_received');
		}

		window.clearInterval(window.detect_interval);

		return true;
	}
	return false;
}
