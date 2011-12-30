{+START,IF_NON_PASSED,WYSIWYG_SAFE}
	{+START,IF_EMPTY,{$META_DATA,video}}
		{$META_DATA,video,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED*}&no_count=1}
		{$META_DATA,video:height,{A_HEIGHT}}
		{$META_DATA,video:width,{A_WIDTH}}
		{$META_DATA,video:type,{MIME_TYPE}}
	{+END}
{+END}

{$SET,flv_url,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&for_session={$SESSION_HASHED}}
{$JAVASCRIPT_INCLUDE,javascript_jwplayer}
{$SET,rand_id,{$RAND}}

<div class="xhtml_validator_off">
	<{$?,{$EQ,{$SUBSTR,{A_URL},-4},.mp3},audio,video} width="{$MIN*,{A_WIDTH},600}" {+START,IF,{$EQ,{A_WIDTH},{$MIN,{A_WIDTH},600}}}height="{A_HEIGHT*}" {+END}id="flv_container_{$GET%,rand_id}"{+START,IF_PASSED,A_THUMB_URL}{+START,IF_NON_EMPTY,{A_THUMB_URL}} poster="{SCRIPT*}?id={ID*}{SUP_PARAMS*}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;thumb=1&amp;for_session={$SESSION_HASHED*}{+END}&amp;no_count=1"{+END}{+END}>
		<source type="{MIME_TYPE*}" src="{$GET*,flv_url}" />
		{!VIDEO}{+START,IF_NON_EMPTY,{A_DESCRIPTION}}; {A_DESCRIPTION}{+END}
	</{$?,{$EQ,{$SUBSTR,{A_URL},-4},.mp3},audio,video}>
</div>

<script type="text/javascript">// <![CDATA[
{$,Carefully tuned to avoid this problem: http://www.longtailvideo.com/support/forums/jw-player/setup-issues-and-embedding/8439/sound-but-no-video}
addEventListenerAbstract(window,'load',function () {
	jwplayer("flv_container_{$GET%,rand_id}").setup({
		autostart: false,
		width: {A_WIDTH*},
		height: {A_HEIGHT*},
		players: [
			{ type: "flash", src: "{$BASE_URL#}/data/flvplayer.swf?rand={$RAND*}" },
			{ type: "html5" }
		],
		provider: '{$?,{$EQ,{$SUBSTR,{A_URL},-4},.mp3},sound,video}'
	});
} );
//]]></script>

{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
	<p class="associated_caption">
		{A_DESCRIPTION}
	</p>
{+END}
