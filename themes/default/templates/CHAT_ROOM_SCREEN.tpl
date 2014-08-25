{TITLE}

{+START,IF_NON_EMPTY,{INTRODUCTION}}<p>{INTRODUCTION}</p>{+END}

{CHAT_SOUND}

<div class="chat_you_are">{!LOGGED_IN_AS,{YOUR_NAME*}}</div>

<h2>{ROOM_NAME*}</h2>

<div class="chat_posting_area">
	<div class="float_surrounder">
		<div class="left">
			<form autocomplete="off" title="{!MESSAGE}" action="{MESSAGES_PHP*}?action=post&amp;room_id={ROOM_ID*}" method="post" style="display: inline;">
				{$INSERT_SPAMMER_BLACKHOLE}

				<div style="display: inline;">
					<p class="accessibility_hidden"><label for="post">{!MESSAGE}</label></p>
					<textarea style="font-family: {FONT_NAME_DEFAULT*;}" class="input_text_required"{+START,IF,{$NOT,{$MOBILE}}} onkeyup="manage_scroll_height(this);"{+END} onkeypress="if (enter_pressed(event)) return chat_post(event,{ROOM_ID*},'post',document.getElementById('font_name').options[document.getElementById('font_name').selectedIndex].value,document.getElementById('text_colour').value); return true;" id="post" name="message" onfocus="if (typeof window.picker_node!='undefined') picker_node.style.visibility='hidden';" cols="{$?,{$MOBILE},37,39}" rows="1"></textarea>
					<input type="hidden" name="font" id="font" value="{FONT_NAME_DEFAULT*}" />
					<input type="hidden" name="colour" id="colour" value="{TEXT_COLOUR_DEFAULT*}" />
				</div>
			</form>
		</div>
		<div class="left">
			<form autocomplete="off" title="{SUBMIT_VALUE*}" action="{MESSAGES_PHP*}?action=post&amp;room_id={ROOM_ID*}" method="post" style="display: inline;">
				<input type="button" class="button_micro" name="post_now" onclick="return chat_post(event,{ROOM_ID*},'post',document.getElementById('font_name').options[document.getElementById('font_name').selectedIndex].value,document.getElementById('text_colour').value);" value="{SUBMIT_VALUE*}" />
			</form>
			{+START,IF,{$NOT,{$MOBILE}}}
				{MICRO_BUTTONS}
				{+START,IF,{$OCF}}
					<a rel="nofollow" class="horiz_field_sep" tabindex="6" href="#" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT;*,emoticons}?field_name=post{$KEEP*;}'),'emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;" title="{!EMOTICONS_POPUP}"><img alt="" src="{$IMG*,ocf_emoticons/smile}" /></a>
				{+END}
			{+END}
		</div>
		<div class="right">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray('chat_comcode_panel');"><img id="e_chat_comcode_panel" src="{$IMG*,expand}" alt="{!CHAT_TOGGLE_COMCODE_BOX}" title="{!CHAT_TOGGLE_COMCODE_BOX}" /></a>
		</div>
	</div>

	<div style="display: {$JS_ON,none,block}" id="chat_comcode_panel">
		{BUTTONS}

		<p>
			<span class="associated_link"<a href="{COMCODE_HELP*}" title="{!COMCODE_HELP=}: {!LINK_NEW_WINDOW}" target="_blank">{!COMCODE_HELP=}</a> | <a href="{CHATCODE_HELP*}" title="{!CHATCODE_HELP=}: {!LINK_NEW_WINDOW}" target="_blank">{!CHATCODE_HELP=}</a></span>
		</p>

		<form title="{!SOUND_EFFECTS}" action="{OPTIONS_URL*}" method="post" class="inline">
			<div>
				<label for="play_sound">{!SOUND_EFFECTS}:</label> <input type="checkbox" id="play_sound" name="play_sound" checked="checked" />
			</div>
		</form>
	</div>
</div>

<div class="messages_window"><div role="marquee" class="messages_window_full_chat" id="messages_window"></div></div>

<div class="box box___chat_screen_chatters"><div class="box_inner">
	<p>
		{!USERS_IN_ROOM} <span id="chat_members_update">{CHATTERS}</span>
	</p>
</div></div>

<form title="{$STRIP_TAGS,{!CHAT_OPTIONS_DESCRIPTION}}" class="below_main_chat_window" onsubmit="return check_chat_options(this);" method="post" action="{OPTIONS_URL*}">
	<div class="box box___chat_screen_options"><div class="box_inner">
		<div class="float_surrounder">
			<div class="chat_options_title">
				{!CHAT_OPTIONS_DESCRIPTION}
			</div>

			<div class="chat_colour_option">
				<div>
					<span class="field_name">{!CHAT_OPTIONS_COLOUR_NAME}</span>
					<span class="associated_details">{!CHAT_OPTIONS_COLOUR_DESCRIPTION}</span>
				</div>
				<div>
					<p class="accessibility_hidden"><label for="text_colour">{!CHAT_OPTIONS_COLOUR_NAME}</label></p>
					<input size="10" maxlength="7" class="input_line_required" type="text" id="text_colour" name="text_colour" value="{TEXT_COLOUR_DEFAULT*}" onfocus="update_picker_colour(); if (picker_node.style.visibility=='visible') { picker_node.style.visibility='hidden'; this.blur(); } else picker_node.style.visibility='visible';" onkeyup="if (this.form.elements['text_colour'].value.match(/^#[0-9A-F][0-9A-F][0-9A-F]([0-9A-F][0-9A-F][0-9A-F])?$/)) { this.style.color=this.value; document.getElementById('colour').value=this.value; update_picker_colour(); }" />
				</div>
			</div>

			<div class="chat_font_option">
				<div>
					<span class="field_name">{!CHAT_OPTIONS_TEXT_NAME}</span>
					<span class="associated_details">{!CHAT_OPTIONS_TEXT_DESCRIPTION}</span>
				</div>
				<div>
					<p class="accessibility_hidden"><label for="font_name">{!CHAT_OPTIONS_TEXT_NAME}</label></p>
					<select onclick="this.onchange(event);" onchange="onFontChange(this);" id="font_name" name="font_name">
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Arial},selected="selected" ,}value="Arial" style="font-family: 'Arial'">Arial</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Courier},selected="selected" ,}value="Courier" style="font-family: 'Courier'">Courier</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Georgia},selected="selected" ,}value="Georgia" style="font-family: 'Georgia'">Georgia</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Impact},selected="selected" ,}value="Impact" style="font-family: 'Impact'">Impact</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Times},selected="selected" ,}value="Times" style="font-family: 'Times'">Times</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Trebuchet},selected="selected" ,}value="Trebuchet" style="font-family: 'Trebuchet'">Trebuchet</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Verdana},selected="selected" ,}value="Verdana" style="font-family: 'Verdana'">Verdana</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Tahoma},selected="selected" ,}value="Tahoma" style="font-family: 'Tahoma'">Tahoma</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Geneva},selected="selected" ,}value="Geneva" style="font-family: 'Geneva'">Geneva</option>
						<option {$?,{$EQ,{FONT_NAME_DEFAULT*},Helvetica},selected="selected" ,}value="Helvetica" style="font-family: 'Helvetica'">Helvetica</option>
					</select>
				</div>
			</div>

			<div class="chat_options">
				<input class="button_pageitem" onclick="var form=this.form; window.fauxmodal_confirm('{!SAVE_COMPUTER_USING_COOKIE}',function(answer) { if (answer) form.submit(); }); return false;" type="submit" value="{!CHAT_CHANGE_OPTIONS=}" />
			</div>
		</div>
	</div></div>
</form>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'real_load',function () {
		chat_load({ROOM_ID%});
	} );
// ]]></script>

{+START,IF_NON_EMPTY,{LINKS}}
	<p class="lonely_label">{!ACTIONS}:</p>
	<ul role="navigation" class="actions_list">
		{+START,LOOP,LINKS}
			{+START,IF_NON_EMPTY,{_loop_var}}
				<li>{_loop_var}</li>
			{+END}
		{+END}
	</ul>
{+END}

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=member_entered_chatroom
	NOTIFICATIONS_ID={ROOM_ID}
	BREAK=1
	RIGHT=1
{+END}
