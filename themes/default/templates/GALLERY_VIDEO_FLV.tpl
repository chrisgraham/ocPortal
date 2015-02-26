{$SET,player_id,player_{$RAND}}

{$SET,flv_url,{URL}}
{$REQUIRE_JAVASCRIPT,javascript_jwplayer}
{$SET,rand_id,{$RAND}}

<meta itemprop="width" content="{WIDTH*}" />
<meta itemprop="height" content="{HEIGHT*}" />
<meta itemprop="duration" content="T{LENGTH*}S" />
<meta itemprop="thumbnailURL" content="{THUMB_URL*}" />
<meta itemprop="embedURL" content="{$GET*,flv_url}" />

<div class="xhtml_validator_off">
	{$,Even use video for audio, as we have thumbnail to show}
	<video width="{WIDTH*}" height="{HEIGHT*}" id="flv_container_{$GET%,rand_id}" poster="{THUMB_URL*}">
		<source src="{$GET*,flv_url}" itemprop="contentURL" />
		{!VIDEO}
	</video>
</div>

{$,API: http://www.longtailvideo.com/support/jw-player/jw-player-for-flash-v5/12540/javascript-api-reference}

<script type="text/javascript">// <![CDATA[
	{$,Carefully tuned to avoid this problem: http://www.longtailvideo.com/support/forums/jw-player/setup-issues-and-embedding/8439/sound-but-no-video}
	add_event_listener_abstract(window,'load',function () {
		jwplayer("flv_container_{$GET%,rand_id}").setup({
			width: {$?*,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},{$MAX,300,{$IMAGE_WIDTH,{THUMB_URL}}},{WIDTH}},
			height: {$?*,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},{$MAX,60,{$IMAGE_HEIGHT,{THUMB_URL}}},{HEIGHT}},
			autostart: false,
			duration: {LENGTH*},
			players: [
				{ type: "flash", src: "{$BASE_URL#}/data/flvplayer.swf{+START,IF,{$NOT,{$BROWSER_MATCHES,bot}}}?rand={$RAND*}{+END}" },
				{ type: "html5" }
			],
			provider: '{$?,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},sound,video}',
			events: {
				onComplete: function() { if (document.getElementById('next_slide')) playerStopped(); },
				onReady: function() { if (document.getElementById('next_slide')) { stop_slideshow_timer('{!STOPPED;/}'); jwplayer("flv_container_{$GET%,rand_id}").play(true); } }
			}
		});
	} );
//]]></script>
