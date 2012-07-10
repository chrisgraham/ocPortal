{$SET,player_id,player_{$RAND}}

{$SET,flv_url,{URL}}
{$JAVASCRIPT_INCLUDE,javascript_jwplayer}
{$SET,rand_id,{$RAND}}

{+START,IF,{$VALUE_OPTION,html5}}
	<meta itemprop="width" content="{WIDTH*}" />
	<meta itemprop="height" content="{HEIGHT*}" />
	<meta itemprop="duration" content="T{LENGTH*}S" />
	<meta itemprop="thumbnailURL" content="{THUMB_URL*}" />
	<meta itemprop="embedURL" content="{$GET*,flv_url}" />
{+END}

<div class="xhtml_validator_off">
	{$,Even use video for audio, as we have thumbnail to show}
	<video width="{WIDTH*}" height="{HEIGHT*}" id="flv_container_{$GET%,rand_id}" poster="{THUMB_URL*}">
		<source src="{$GET*,flv_url}"{$?,{$VALUE_OPTION,html5}, itemprop="contentURL"} />
		{!VIDEO}
	</video>
</div>

{$,API: http://www.longtailvideo.com/support/jw-player/jw-player-for-flash-v5/12540/javascript-api-reference}

<script type="text/javascript">// <![CDATA[
{$,Carefully tuned to avoid this problem: http://www.longtailvideo.com/support/forums/jw-player/setup-issues-and-embedding/8439/sound-but-no-video}
addEventListenerAbstract(window,'load',function () {
	jwplayer("flv_container_{$GET%,rand_id}").setup({
		width: {$?*,{$EQ,{$SUBSTR,{URL},-4},.mp3},{$MAX,320,{$IMAGE_WIDTH,{THUMB_URL}}},{WIDTH}},
		height: {$?*,{$EQ,{$SUBSTR,{URL},-4},.mp3},{$IMAGE_HEIGHT,{THUMB_URL}},{HEIGHT}},
		autostart: false,
		duration: {LENGTH*},
		players: [
			{ type: "flash", src: "{$BASE_URL#}/data/flvplayer.swf{+START,IF,{$NOT,{$BROWSER_MATCHES,bot}}}?rand={$RAND*}{+END}" },
			{ type: "html5" }
		],
		provider: '{$?,{$EQ,{$SUBSTR,{URL},-4},.mp3},sound,video}',
		events: {
			onComplete: function() { if (document.getElementById('next_slide')) playerStopped(); },
			onReady: function() { if (document.getElementById('next_slide')) { stop_slideshow_timer('{!STOPPED;}'); jwplayer("flv_container_{$GET%,rand_id}").play(true); } }
		}
	});
} );
//]]></script>
