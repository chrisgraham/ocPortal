<figure>
	{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}
		{+START,IF_EMPTY,{$META_DATA,video}}
			{$META_DATA,video,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&for_session={$SESSION_HASHED}{+END}&no_count=1}
			{$META_DATA,video:height,{A_HEIGHT}}
			{$META_DATA,video:width,{A_WIDTH}}
			{$META_DATA,video:type,{MIME_TYPE}}
		{+END}
	{+END}

	<object width="{A_WIDTH*}" height="{$ADD,{A_HEIGHT*},64}" type="application/x-mplayer2" classid="clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab">
		<param name="filename" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
		<param name="Url" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
		<param name="src" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
		<param name="enabled" value="true" />
		<param name="autoStart" value="false" />
		<param name="uiMode" value="mini" />
		<param name="ShowControls" value="1" />
		<param name="width" value="{A_WIDTH*}" />
		<param name="height" value="{$ADD,{A_HEIGHT*},64}" />

		<!--[if !IE]> -->
			<object width="{A_WIDTH*}" height="{$ADD,{A_HEIGHT*},16}" data="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" type="{MIME_TYPE*}">
				<param name="filename" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
				<param name="Url" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
				<param name="src" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
				<param name="autoStart" value="false" />
				<param name="uiMode" value="mini" />
				<param name="enabled" value="true" />
				<param name="src" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}" />
				<param name="ShowControls" value="1" />
				<param name="quality" value="high" />
				<param name="autostart" value="false" />
				<param name="controls" value="ControlPanel" />
				<param name="autoplay" value="false" />
				<param name="controller" value="true" />
				<param name="pluginspage" value="http://www.apple.com/quicktime/download/" />
				<param name="width" value="{A_WIDTH*}" />
				<param name="height" value="{$ADD,{A_HEIGHT*},16}" />

				{!MEDIA}{+START,IF_NON_EMPTY,{A_DESCRIPTION}}; {A_DESCRIPTION}{+END}
			</object>
		<!-- <![endif]-->
	</object>

	{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
		<figcaption class="associated_details">
			{A_DESCRIPTION}
		</figcaption>
	{+END}

	{$,Uncomment for a download link <ul class="actions_list" role="navigation"><li class="actions_list_strong"><a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!_ATTACHMENT} #{ID*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}\{+START,IF_PASSED,SUP_PARAMS\}{SUP_PARAMS*}\{+END\}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}\{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE\}\{+START,IF,{$INLINE_STATS}\}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}\{+END\}\{+END\})</li></ul>}
</figure>
