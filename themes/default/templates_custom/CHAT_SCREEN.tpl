{TITLE}
{+START,IF_NON_EMPTY,{INTRODUCTION}}<p>{INTRODUCTION}</p>{+END}

{CHAT_SOUND}

<div class="chat_you_are">{!LOGGED_IN_AS,{YOUR_NAME*}}</div>
<h2>{ROOM_ID*}</h2>

<div class="float_surrounder">
	<div style="float: {!en_left};">
		<form title="{!MESSAGE}" onsubmit="return false;" action="#" method="post" style="display: inline;">
			<div style="display: inline;">
				<p style="display: none;"><label for="post">{!MESSAGE}</label></p>
				<textarea class="input_text_required"{+START,IF,{$NOT,{$MOBILE}}} onkeyup="manageScrollHeight(this);"{+END} onkeypress="if (enter_pressed(event)) return chat_post(event,'{ROOM_ID*}','post'); return true;" id="post" name="message" onfocus="if (typeof window.picker_node!='undefined') picker_node.style.visibility='hidden';" cols="42" rows="1"></textarea>
			</div>
		</form>
	</div>
	<div class="left">
		<form title="{SUBMIT_VALUE*}" action="{MESSAGES_PHP*}?action=post&amp;room_id={ROOM_ID*}" method="post" style="display: inline;">
			<input type="button" name="post_now" onclick="return chat_post(event,'{ROOM_ID*}','post');" value="{SUBMIT_VALUE*}" />
		</form>
		&nbsp;
		{+START,IF,{$OCF}}
		<span class="associated_details">[ <a tabindex="6" href="#" onclick="window.faux_open(maintain_theme_in_link('{$FIND_SCRIPT*,emoticons}?field_name=post{$KEEP*;}'),'emoticon_chooser','width=300,height=320,status=no,resizable=yes,scrollbars=no'); return false;">{!EMOTICONS_POPUP}</a> ]</span>
		{+END}
	</div>
	<div class="right">
		<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('chat_comcode_panel','block'); return false;"><img id="e_chat_comcode_panel" src="{$IMG*,expand}" alt="{!CHAT_TOGGLE_COMCODE_BOX}" title="{!CHAT_TOGGLE_COMCODE_BOX}" /></a>
	</div>
</div>

<div style="display: {$JS_ON,none,block}" id="chat_comcode_panel">
	<form title="{!SOUND_EFFECTS}" action="{OPTIONS_URL*}" method="post" class="inline">
		<div>
			<label for="play_sound">{!SOUND_EFFECTS}</label> <input type="checkbox" id="play_sound" name="play_sound" checked="checked" />
		</div>
	</form>
</div>

<div class="messages_window"><div id="messages_window">&nbsp;</div></div>

<p>
	{!USERS_IN_ROOM} <span id="chat_members_update"><img{$?,{$VALUE_OPTION,html5}, aria-busy="true"} class="inline_image_2" src="{$IMG*,bottom/loading}" title="{!LOADING}" alt="{!LOADING}" /> {!LOADING}</span>
</p>

<script type="text/javascript">
// <![CDATA[
function onLoginCompletedRoom()
{
	var messages=document.getElementById('messages_window');
	setInnerHTML(messages,'');
	
	chat_load('{ROOM_ID%}');
	window.con.jid='{$REPLACE;*, ,.,{$USERNAME}}@{$DOMAIN;*}';
	window.room = mucMan.getRoom( "{ROOM_ID*}" ).createState();
	window.room.join('{$REPLACE;*, ,.,{$USERNAME}}');
	function loadRoomMembers()
	{
		window.room.getParticipants(
			function(room, participants) {
				var inThere='';
				for (var i=0;i<participants.length;i++)
				{
					var username=participants[i].realJid.replace(/\./g,' ').replace(/@.*/,'');
					if (inThere!='') inThere=inThere+', ';
					inThere=inThere+"<a href=\"{$BASE_URL*}/site/index.php?page=members&amp;type=view&amp;id="+escape_html(username)+"\">"+escape_html(username)+"<\/a>";
				}
				if (inThere=='') inThere='none';

				setInnerHTML(document.getElementById("chat_members_update"), inThere);
			}
		);
	}
	window.setInterval(loadRoomMembers, 15000);
	window.setTimeout(loadRoomMembers, 5000);
}

addEventListenerAbstract(window,'load',function () {
	xmpp_connect("{$REPLACE*, ,.,{$USERNAME}}","{PASSWORD_HASH*}",onLoginCompletedRoom);
} );
// ]]>
</script>

{+START,IF_NON_EMPTY,{LINKS}}
	<p>{!ACTIONS}:</p>
	<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list">
		{+START,LOOP,LINKS}
			{+START,IF_NON_EMPTY,{_loop_var}}
			<li>&raquo; {_loop_var}</li>
			{+END}
		{+END}
	</ul>
{+END}
