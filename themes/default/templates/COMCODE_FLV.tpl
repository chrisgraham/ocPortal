{$SET,flv_url,{URL}}
{$JAVASCRIPT_INCLUDE,javascript_jwplayer}
{$SET,rand_id,{$RAND}}

<div class="xhtml_validator_off">
	<{$?,{$EQ,{$SUBSTR,{A_URL},-4},.mp3},audio,video} width="{WIDTH*}" height="{HEIGHT*}" id="flv_container_{$GET%,rand_id}" poster="{$REPLACE,.webm,.jpg,{$REPLACE,.mp4,.jpg,{$REPLACE,.flv,.jpg,{$GET*.,flv_url}}}}">
		<source src="{$GET*,flv_url}" />
		{!VIDEO}
	</{$?,{$EQ,{$SUBSTR,{A_URL},-4},.mp3},audio,video}>
</div>

<script type="text/javascript">// <![CDATA[
	jwplayer("flv_container_{$GET%,rand_id}").setup({
		autostart: false,
      players: [
          { type: "html5" },
          { type: "flash", src: "{$BASE_URL#}/data/flvplayer.swf" }
      ],
		provider: '{$?,{$EQ,{$SUBSTR,{URL},-4},.mp3},sound,video}'
	});
//]]></script>
