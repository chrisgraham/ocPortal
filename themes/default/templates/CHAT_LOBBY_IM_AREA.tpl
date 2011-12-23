<div id="room_{ROOM_ID*}" class="chat_lobby_convos_area">
	<form title="{!MESSAGE}" action="{MESSAGES_PHP*}?action=post" method="post">
		<div class="chat_lobby_convos_area_bar">
			<h3>{!PARTICIPANTS}</h3>

			<div class="chat_lobby_convos_area_participants" id="participants__{ROOM_ID*}">
				<em>{!NONE}</em>
			</div>
			<div class="im_close_button">
				<input id="close_button_{ROOM_ID*}" class="button_micro" type="button" value="{!CLOSE}" onclick="close_chat_conversation(this);" />
			</div>
		</div>

		<div class="chat_lobby_convos_area_main">
			<div class="im_post_bits">
				<label class="accessibility_hidden" for="post_{ROOM_ID*}">{!MESSAGE}</label>
				<textarea class="input_required im_post_field" onkeypress="if (enter_pressed(event)) { cancelBubbling(event); return false; } return true;" onkeyup="manageScrollHeight(this); if (enter_pressed(event)) { return chat_post(event,{ROOM_ID*},'post_{ROOM_ID*}','',''); SetCookie('last_chat_msg_{ROOM_ID;}',''); return true; } else { SetCookie('last_chat_msg_{ROOM_ID;}',this.value); } " id="post_{ROOM_ID*}" name="post_{ROOM_ID*}" cols="30" rows="1"></textarea><br />
				{+START,IF,{$AND,{$OCF},{$JS_ON}}}
				<span class="associated_link_to_small">[ <a href="#" title="{!EMOTICONS}: {!LINK_NEW_WINDOW}" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name=post_{ROOM_ID*}{$KEEP*;,0,1}'),'emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;">{!EMOTICONS}</a> ]</span>
				{+END}
				<input class="button_micro" type="button" onclick="return chat_post(event,{ROOM_ID*},'post_{ROOM_ID*}','','');" value="{!_POST}" />
			</div>

			<div class="chat_lobby_convos_area_messages messages_window" id="messages_window_{ROOM_ID*}">&nbsp;</div>
		</div>
	</form>

	<script type="text/javascript">
	// <![CDATA[
	window.setTimeout(function() { /* Needed for IE */
		addEventListenerAbstract(window,'real_load',function () {
			try
			{
				document.getElementById("post_{ROOM_ID#}").focus();
			} catch (e)
			{
			};
			document.getElementById("post_{ROOM_ID#}").value=ReadCookie('last_chat_msg_{ROOM_ID;}');
		} );
	}, 1000);
	// ]]>
	</script>
</div>

