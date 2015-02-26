{$SET,flv_url,{URL}}
{$REQUIRE_JAVASCRIPT,javascript_jwplayer}
{$SET,rand_id,{$RAND}}

<div class="xhtml_validator_off">
	<{$?,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},audio,video} width="{WIDTH*}" height="{$?*,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},24,{HEIGHT*}}" id="flv_container_{$GET%,rand_id}" poster="{$REPLACE,.webm,.jpg,{$REPLACE,.mp4,.jpg,{$REPLACE,.flv,.jpg,{$GET*,flv_url}}}}">
		<source src="{$GET*,flv_url}" />
		{!VIDEO}
	</{$?,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},audio,video}>
</div>

<script type="text/javascript">// <![CDATA[
	jwplayer("flv_container_{$GET%,rand_id}").setup({
		autostart: false,
		players: [
			{ type: "html5" },
			{ type: "flash", src: "{$BASE_URL#}/data/flvplayer.swf" }
		],
		provider: '{$?,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3},sound,video}'
		{+START,IF,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3}}
			,controlbar: 'bottom'
		{+END}
	});
	{+START,IF,{$EQ,{$LCASE,{$SUBSTR,{URL},-4}},.mp3}}
		jwplayer("flv_container_{$GET%,rand_id}").onReady(function() {
			document.getElementById("flv_container_{$GET%,rand_id}_jwplayer_display_iconBackground").style.visibility='hidden';
			document.getElementById("flv_container_{$GET%,rand_id}_jwplayer_logo").style.visibility='hidden';
		});
	{+END}
//]]></script>
