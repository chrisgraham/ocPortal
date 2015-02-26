{$SET,player_id,player_{$RAND}}

<div class="xhtml_validator_off">
	<embed id="{$GET*,player_id}" name="{$GET*,player_id}" type="audio/x-pn-realaudio"
		src="{URL*}"
		autostart="false"
		controls="ImageWindow,ControlPanel"
		pluginspage="http://www.real.com"
		width="{WIDTH*}"
		height="{HEIGHT*}"
	/>
</div>

{$,Tie into callback event to see when finished, for our slideshows}
{$,API: http://service.real.com/help/library/guides/realone/ScriptingGuide/PDF/ScriptingGuide.pdf}
<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'real_load',function () {
		if (document.getElementById('next_slide'))
		{
			stop_slideshow_timer('{!STOPPED;/}');
			window.setTimeout(function() {
				add_event_listener_abstract(document.getElementById('{$GET;,player_id}'),'stateChange',function(newState) { if (newState==0) { playerStopped(); } } );
				document.getElementById('{$GET;,player_id}').DoPlay();
			}, 1000);
		}
	} );
//]]></script>
