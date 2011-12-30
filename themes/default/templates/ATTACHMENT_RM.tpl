{+START,IF_NON_PASSED,WYSIWYG_SAFE}
	{+START,IF_EMPTY,{$META_DATA,video}}
		{$META_DATA,video,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED*}&no_count=1}
		{$META_DATA,video:height,{A_HEIGHT}}
		{$META_DATA,video:width,{A_WIDTH}}
		{$META_DATA,video:type,{MIME_TYPE}}
	{+END}
{+END}

<object width="{A_WIDTH*}" height="{A_HEIGHT*}" type="audio/x-pn-realaudio" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA">
	<param name="src" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}" />
	<param name="quality" value="high" />
	<param name="autostart" value="false" />
	<param name="controls" value="ControlPanel" />
	<param name="pluginspage" value="http://www.real.com" />
	<param name="width" value="{A_WIDTH*}" />
	<param name="height" value="{A_HEIGHT*}" />

	<!--[if !IE]> -->
		<object width="{A_WIDTH*}" height="{A_HEIGHT*}" data="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}" type="audio/x-pn-realaudio">
			<param name="src" value="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}" />
			<param name="quality" value="high" />
			<param name="autostart" value="false" />
			<param name="controls" value="ControlPanel" />
			<param name="pluginspage" value="http://www.real.com" />
			<param name="width" value="{A_WIDTH*}" />
			<param name="height" value="{A_HEIGHT*}" />

			{!VIDEO}{+START,IF_NON_EMPTY,{A_DESCRIPTION}}; {A_DESCRIPTION}{+END}
		</object>
	<!-- <![endif]-->
</object>

{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
	<p class="associated_caption">
		{A_DESCRIPTION}
	</p>
{+END}

{$,Uncomment for a download link <span class="attachment_action">&raquo; <a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!_ATTACHMENT} #{ID*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}\{+START,IF_PASSED,SUP_PARAMS\}{SUP_PARAMS*}\{+END\}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}\{+START,IF_NON_PASSED,WYSIWYG_SAFE\}\{+START,IF,{$INLINE_STATS}\}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}\{+END\}\{+END\})</span>}
