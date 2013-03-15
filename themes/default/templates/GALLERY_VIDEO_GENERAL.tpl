{$SET,player_id,player_{$RAND}}

<div class="xhtml_validator_off">
	<object style="display: none" id="qt_event_source_{$GET*,player_id}" classid="clsid:CB927D12-4FF7-4a9e-A169-56E4B8A75598" codebase="http://www.apple.com/qtactivex/qtplugin.cab#version=7,2,1,0"></object>
	<embed id="{$GET*,player_id}" style="behavior:url(#qt_event_source_{$GET*,player_id});" name="{$GET*,player_id}" type="video/quicktime"
		{$,Quicktime}
		src="{URL*}"
		autoplay="false"
		enablejavascript="true"
		postdomevents="true"
		controller="true"
		pluginspage="http://www.apple.com/quicktime/download/"
		scale="ASPECT"
		width="{WIDTH*}"
		height="{$ADD,{HEIGHT*},16}"

		{$,WMP}
		filename="{URL*}"
		Url="{URL*}"
 		enabled="true"
		ShowControls="1"
		autostart="false"
	/>
</div>

{$,Tie into callback event to see when finished, for our slideshows}
{$,API: http://developer.apple.com/library/safari/#documentation/QuickTime/Conceptual/QTScripting_JavaScript/bQTScripting_JavaScri_Document/QuickTimeandJavaScri.html}
{$,API: http://msdn.microsoft.com/en-us/library/windows/desktop/dd563945(v=vs.85).aspx}
<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'real_load',function () {
		if (document.getElementById('next_slide'))
		{
			stop_slideshow_timer('{!STOPPED;}');

			window.setTimeout(function() {
				var player=document.getElementById('{$GET*,player_id}');

				{$,WMP}
				add_event_listener_abstract(player,'playstatechange',function(newState) { if (newState==1) { playerStopped(); } } );

				{$,Quicktime}
				add_event_listener_abstract(player,'qt_ended',function() { playerStopped(); } );

				try { player.Play(); } catch (e) {};
				try { player.controls.play(); } catch (e) {};
			}, 1000);
		}
	} );
//]]></script>

