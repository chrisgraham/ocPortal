<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} class="dynamic_iframe" title="{!PAGE}" name="iframe_page" id="iframe_page" src="{IFRAME_URL*}">{!PAGE}</iframe>

{+START,IF_PASSED,CHANGE_DETECTION_URL}{+START,IF_NON_EMPTY,{CHANGE_DETECTION_URL}}
	<script type="text/javascript">
	// <![CDATA[
		if (typeof window.soundManager!='undefined')
		{
			soundManager.onload=function() {
				soundManager.createSound('message_received','{$BASE_URL;/}/data/sounds/message_received.mp3');
			}
		}
	// ]]>
	</script>

	<script type="text/javascript">// <![CDATA[
		//window.setInterval(function() { resize_frame('iframe_page'); },500);
		{+START,IF_NON_EMPTY,{REFRESH_TIME}}
			window.detect_interval=window.setInterval(
				function() {
					{+START,IF_PASSED,CHANGE_DETECTION_URL}
						if ((window.detect_change) && (detect_change('{CHANGE_DETECTION_URL;/}','{REFRESH_IF_CHANGED;/}')) && ((!top.frames['iframe_page'].document.getElementById('post')) || (top.frames['iframe_page'].document.getElementById('post').value=='')))
					{+END}
							top.frames['iframe_page'].location.reload();
				},
				{REFRESH_TIME%}*1000);
		{+END}
	//]]></script>
{+END}{+END}

