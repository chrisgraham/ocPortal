{+START,SET,media}
	{$SET,player_id,player_{$RAND}}

	{$REQUIRE_JAVASCRIPT,javascript_jwplayer}

	{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}
		{+START,IF_EMPTY,{$META_DATA,video}}
			{$META_DATA,video,{URL}}
			{$META_DATA,video:height,{HEIGHT}}
			{$META_DATA,video:width,{WIDTH}}
			{$META_DATA,video:type,{MIME_TYPE}}
		{+END}
	{+END}

	<meta itemprop="width" content="{WIDTH*}" />
	<meta itemprop="height" content="{HEIGHT*}" />
	<meta itemprop="duration" content="T{LENGTH*}S" />
	<meta itemprop="thumbnailURL" content="{THUMB_URL*}" />
	<meta itemprop="embedURL" content="{URL*}" />

	<div class="xhtml_validator_off">
		{$,Even use video for audio, as we have thumbnail to show}
		<audio width="{WIDTH*}" height="{HEIGHT*}" id="{$GET%,player_id}" poster="{THUMB_URL*}">
			<source src="{URL*}" itemprop="contentURL" />
			{!AUDIO}
		</audio>
	</div>

	{$,API: http://www.longtailvideo.com/support/jw-player/jw-player-for-flash-v5/12540/javascript-api-reference}

	<script>// <![CDATA[
		{$,Carefully tuned to avoid this problem: http://www.longtailvideo.com/support/forums/jw-player/setup-issues-and-embedding/8439/sound-but-no-video}
		add_event_listener_abstract(window,'load',function () {
			jwplayer('{$GET%,player_id}').setup({
				width: {$?*,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},{$MAX,320,{$IMAGE_WIDTH,{THUMB_URL}}},{WIDTH}},
				height: {$?*,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},{$IMAGE_HEIGHT,{THUMB_URL}},{HEIGHT}},
				autostart: false,
				duration: {LENGTH*},
				players: [
					{ type: 'flash', src: '{$BASE_URL;}/data/flvplayer.swf{+START,IF,{$NOT,{$BROWSER_MATCHES,bot}}}?rand={$RAND*}{+END}' },
					{ type: 'html5' }
				],
				provider: 'audio',
				events: {
					{+START,IF,{$NOT,{$INLINE_STATS}}}onPlay: function() { ga_track(null,'{!VIDEO;*}','{URL;*}'); },{+END}
					onComplete: function() { if (document.getElementById('next_slide')) player_stopped(); },
					onReady: function() { if (document.getElementById('next_slide')) { stop_slideshow_timer(); jwplayer('{$GET%,player_id}').play(true); } }
				}
			});
		} );
	//]]></script>

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<figcaption class="associated_details">
			{DESCRIPTION}
		</figcaption>
	{+END}

	{$,Uncomment for a download link <ul class="actions_list" role="navigation"><li class="actions_list_strong"><a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{ORIGINAL_FILENAME*}} {!LINK_NEW_WINDOW}" href="{URL*}">{!_DOWNLOAD,{ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}\{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE\}\{+START,IF,{$INLINE_STATS}\}\{+START,IF_PASSED,NUM_DOWNLOADS\}, {!DOWNLOADS_SO_FAR,{NUM_DOWNLOADS*}}\{+END\}\{+END\}\{+END\})</li></ul>}
{+END}
{+START,IF_PASSED_AND_TRUE,FRAMED}
	<figure>
		{$GET,media}
	</figure>
{+END}
{+START,IF_NON_PASSED_OR_TRUE,FRAMED}
	{$GET,media}
{+END}
