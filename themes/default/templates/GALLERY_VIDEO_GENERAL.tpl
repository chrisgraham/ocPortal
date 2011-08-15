<object width="{WIDTH*}" height="{$ADD,{HEIGHT*},64}" type="application/x-mplayer2" classid="clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab">
	<param name="filename" value="{URL*}" />
	<param name="src" value="{URL*}" />
	<param name="Url" value="{URL*}" />
	<param name="enabled" value="true" />
	<param name="autoStart" value="false" />
	<param name="uiMode" value="mini" />
	<param name="ShowControls" value="1" />
	<param name="width" value="{WIDTH*}" />
	<param name="height" value="{$ADD,{HEIGHT*},64}" />

	<!--[if !IE]> -->
		<object width="{WIDTH*}" height="{HEIGHT*}" data="{URL*}" type="{MIME_TYPE*}">
			<param name="filename" value="{URL*}" />
			<param name="src" value="{URL*}" />
			<param name="Url" value="{URL*}" />
	 		<param name="enabled" value="true" />
			<param name="ShowControls" value="1" />
			<param name="autoplay" value="false" />
			<param name="autostart" value="false" />
			<param name="controls" value="ImageWindow,ControlPanel" />
			<param name="controller" value="true" />
			<param name="scale" value="ASPECT" />
			<param name="pluginspage" value="http://www.apple.com/quicktime/download/" />
			<param name="width" value="{WIDTH*}" />
			<param name="height" value="{HEIGHT*}" />
		</object>
	<!-- <![endif]-->
</object>
