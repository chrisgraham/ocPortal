<object width="{WIDTH*}" height="{$ADD,{HEIGHT*},16}" type="video/quicktime" classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" codebase="http://www.apple.com/qtactivex/qtplugin.cab">
	<param name="src" value="{URL*}" />
	<param name="autoplay" value="false" />
	<param name="controller" value="true" />
	<param name="pluginspage" value="http://www.apple.com/quicktime/download/" />
	<param name="scale" value="ASPECT" />
	<param name="width" value="{WIDTH*}" />
	<param name="height" value="{$ADD,{HEIGHT*},16}" />

	<!--[if !IE]> -->
		<object width="{WIDTH*}" height="{$ADD,{HEIGHT*},16}" type="video/quicktime" data="{URL*}">
			<param name="src" value="{URL*}" />
			<param name="autoplay" value="false" />
			<param name="controller" value="true" />
			<param name="pluginspage" value="http://www.apple.com/quicktime/download/" />
			<param name="scale" value="ASPECT" />
			<param name="width" value="{WIDTH*}" />
			<param name="height" value="{$ADD,{HEIGHT*},16}" />
		</object>
	<!-- <![endif]-->

</object>

