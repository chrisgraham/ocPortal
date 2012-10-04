{CONTENT}

<form class="chat_sound_effects_checkbox" title="{!SOUND_EFFECTS}" action="index.php" method="post" class="inline">
	<p>
		<label for="play_sound">{!SOUND_EFFECTS}</label> <input type="checkbox" id="play_sound" name="play_sound" checked="checked" />
	</p>
</form>

<ul class="actions_list">
	<li>{!GOTO_CHAT_LOBBY_FOR_MORE,{$PAGE_LINK*,_SEARCH:chat}}</li>
</ul>

<script type="text/javascript">// <![CDATA[
	window.detect_if_chat_window_closed_checker=window.setInterval(function() {
		detect_if_chat_window_closed();
	},5);
//]]></script>
