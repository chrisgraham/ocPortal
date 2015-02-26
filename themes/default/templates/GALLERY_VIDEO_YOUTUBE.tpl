{$SET,player_id,player_{$RAND}}

<div class="xhtml_validator_off">
	<embed id="{$GET,player_id}" type="application/x-shockwave-flash" width="560" height="315"
		src="http://www.youtube.com/v/{URL*}?enablejsapi=1"
		data="http://www.youtube.com/v/{URL*}?enablejsapi=1"
		wmode="transparent"
		allowscriptaccess="always" allowfullscreen="true"
	/>
</div>

{$,Tie into callback event to see when finished, for our slideshows}
{$,API: http://code.google.com/apis/youtube/js_api_reference.html#Events}
<script type="text/javascript">// <![CDATA[
	function youtubeStateChanged(newState)
	{
		if (newState==0) playerStopped();
	}

	add_event_listener_abstract(window,'real_load',function () {
		if (document.getElementById('next_slide'))
		{
			stop_slideshow_timer('{!STOPPED;/}');
			window.setTimeout(function() {
				document.getElementById('{$GET;,player_id}').addEventListener('onStateChange','youtubeStateChanged');
				document.getElementById('{$GET;,player_id}').playVideo();
			}, 1000);
		}
	} );
//]]></script>
