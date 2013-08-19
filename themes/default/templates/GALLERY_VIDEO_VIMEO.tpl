{$SET,player_id,player_{$RAND}}

<div class="xhtml_validator_off">
	<iframe id="{$GET*,player_id}" src="http://player.vimeo.com/video/{URL*}?api=1" {+START,IF,{$_GET,slideshow}}autoplay="1" {+END}width="425" height="350" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
</div>

{$,Tie into callback event to see when finished, for our slideshows}
<script>// <![CDATA[
	add_event_listener_abstract(window,'real_load',function () {
		if (document.getElementById('next_slide'))
		{
			stop_slideshow_timer('{!STOPPED;}');
			window.setTimeout(function() {
				if (typeof window.addEventListener!='undefined')
				{
					window.addEventListener('message',player_stopped,false);
				} else
				{
					window.attachEvent('onmessage',player_stopped,false);
				}

				var player=document.getElementById('{$GET*,player_id}');
				player.contentWindow.postMessage(JSON.stringify({ method: 'addEventListener', value: 'finish' }),'http://player.vimeo.com/video/{URL;/}');
			}, 1000);
		}
	} );
//]]></script>
