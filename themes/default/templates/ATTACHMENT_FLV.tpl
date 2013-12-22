<figure>
	{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}
		{+START,IF_EMPTY,{$META_DATA,video}}
			{$META_DATA,video,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&for_session={$SESSION_HASHED}{+END}&no_count=1}
			{$META_DATA,video:height,{A_HEIGHT}}
			{$META_DATA,video:width,{A_WIDTH}}
			{$META_DATA,video:type,{MIME_TYPE}}
		{+END}
	{+END}

	{$,NB: Filename is appended so jwplayer can read the file extension to determine native playability}
	{$SET,flv_url,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&for_session={$SESSION_HASHED}&filename={A_ORIGINAL_FILENAME&}}
	{$REQUIRE_JAVASCRIPT,javascript_jwplayer}
	{$SET,rand_id,{$RAND}}

	<div class="xhtml_validator_off">
		<{$?,{$EQ,{$LCASE,{$SUBSTR,{A_URL},-4}},.mp3},audio,video} width="{$MIN*,{A_WIDTH},600}" {+START,IF,{$EQ,{A_WIDTH},{$MIN,{A_WIDTH},600}}}height="{A_HEIGHT*}" {+END}id="flv_container_{$GET%,rand_id}"{+START,IF_PASSED,A_THUMB_URL}{+START,IF_NON_EMPTY,{A_THUMB_URL}} poster="{SCRIPT*}?id={ID*}{SUP_PARAMS*}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;thumb=1&amp;for_session={$SESSION_HASHED*}{+END}&amp;no_count=1"{+END}{+END}>
			<source type="{MIME_TYPE*}" src="{$GET*,flv_url}" />
			{!VIDEO}{+START,IF_NON_EMPTY,{A_DESCRIPTION}}; {A_DESCRIPTION}{+END}
		</{$?,{$EQ,{$LCASE,{$SUBSTR,{A_URL},-4}},.mp3},audio,video}>
	</div>

	<script type="text/javascript">// <![CDATA[
		{$,Carefully tuned to avoid this problem: http://www.longtailvideo.com/support/forums/jw-player/setup-issues-and-embedding/8439/sound-but-no-video}
		add_event_listener_abstract(window,'load',function () {
			jwplayer("flv_container_{$GET%,rand_id}").setup({
				autostart: false,
				width: {A_WIDTH*},
				height: {A_HEIGHT*},
				players: [
					{ type: "flash", src: "{$BASE_URL#}/data/flvplayer.swf{+START,IF,{$NOT,{$BROWSER_MATCHES,bot}}}?rand={$RAND*}{+END}" },
					{ type: "html5" }
				],
				provider: '{$?,{$EQ,{$LCASE,{$SUBSTR,{A_URL},-4}},.mp3},sound,video}'
				{+START,IF_PASSED,A_THUMB_URL}{+START,IF_NON_EMPTY,{A_THUMB_URL}} image: "{SCRIPT*}?id={ID*}{SUP_PARAMS*}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;thumb=1&amp;for_session={$SESSION_HASHED*}{+END}&amp;no_count=1"{+END}{+END}
			});
		} );
	//]]></script>

	{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
		<figcaption class="associated_details">
			{A_DESCRIPTION}
		</figcaption>
	{+END}
</figure>
