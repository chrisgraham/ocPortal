{TITLE}

{MESSAGE}

<p>{!USE_CHAT_RULES,{$PAGE_LINK*,:rules},{$PAGE_LINK*,:privacy}}</p>

<div class="box box___chat_lobby_screen_rooms"><div class="box_inner">
	<h2>{!ROOMS_LOBBY_TITLE}</h2>

	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{ADD_ROOM_URL}{PRIVATE_ROOM}{BLOCKING_LINK}{MOD_LINK}{SETEFFECTS_LINK}}
			<nav class="chat_actions" role="navigation">
				<h2>{!ADVANCED_ACTIONS}</h2>

				<ul role="navigation" class="actions_list spaced_list">
					{+START,IF_NON_EMPTY,{ADD_ROOM_URL}}
						<li><a href="{ADD_ROOM_URL*}" rel="add">{!ADD_CHATROOM}</a></li>
					{+END}
					{+START,IF_NON_EMPTY,{PRIVATE_ROOM}}
						<li>{PRIVATE_ROOM}</li>
					{+END}
					{+START,IF_NON_EMPTY,{BLOCKING_LINK}}
						<li>{BLOCKING_LINK}</li>
					{+END}
					{+START,IF_NON_EMPTY,{MOD_LINK}}
						<li>{MOD_LINK}</li>
					{+END}
					{+START,IF_NON_EMPTY,{SETEFFECTS_LINK}}
						<li>{SETEFFECTS_LINK}</li>
					{+END}
				</ul>
			</nav>
		{+END}

		<div class="chat_rooms">
			<h2>{!SELECT_ROOM}</h2>

			{+START,IF_NON_EMPTY,{ROOMS}}
				<ul class="spaced_list">
					{ROOMS}
				</ul>

				<p class="chat_multi_tab">{!OPEN_ROOMS_IN_TABS}</p>
			{+END}
			{+START,IF_EMPTY,{ROOMS}}
				<p class="nothing_here">{!NO_CATEGORIES}</p>
			{+END}
		</div>
	</div>
</div></div>

{+START,IF,{$NOT,{$IS_GUEST}}}
	<div class="chat_im_convos_wrap">
		<div class="box box___chat_lobby_screen_im"><div class="box_inner">
			<h2>{!INSTANT_MESSAGING}</h2>

			<div class="float_surrounder chat_im_convos_inner">
				<div class="chat_lobby_convos">
					<h3>{!IM_CONVERSATIONS}</h3>

					<div class="chat_lobby_convos_tabs" id="chat_lobby_convos_tabs" style="display: none"></div>
					<div class="chat_lobby_convos_areas" id="chat_lobby_convos_areas">
						<p class="nothing_here">
							{!NO_IM_CONVERSATIONS}
						</p>
					</div>

					<script type="text/javascript"> // <![CDATA[
						var im_area_template='{IM_AREA_TEMPLATE;^/}';
						var im_participant_template='{IM_PARTICIPANT_TEMPLATE;^/}';
						var all_conversations=[];
						var top_window=window;

						function begin_im_chatting()
						{
							window.load_from_room_id=-1;
							if ((window.chat_check) && (window.do_ajax_request)) chat_check(true,0); else window.setTimeout(begin_im_chatting,500);
						}
						begin_im_chatting();
					// ]]></script>
				</div>

				<div class="chat_lobby_friends">
					<h3>{!FRIEND_LIST}</h3>

					{+START,IF_NON_EMPTY,{FRIENDS}}
						<form autocomplete="off" title="{!FRIEND_LIST}" method="post" action="{$?,{$IS_EMPTY,{URL_REMOVE_FRIENDS}},index.php,{URL_REMOVE_FRIENDS*}}">
							<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="results_table wide_table autosized_table">
								<thead>
									<tr>
										<th></th>
										<th>{!NAME}</th>
										<th><a target="_blank" title="{!ONLINE}: {!LINK_NEW_WINDOW}" href="{ONLINE_URL*}">{!ONLINE}</a></th>
										<th>{!CHOOSE}</th>
									</tr>
								</thead>
								<tbody>
									{+START,LOOP,FRIENDS}
										<tr>
											<td><img id="friend_img_{MEMBER_ID*}" alt="" src="{$IMG*,menu_items/community_navigation/members}" /></td>
											<td>
												{+START,IF,{CAN_IM}}
													<a rel="friend" title="{USERNAME*}: {!START_IM}" href="#" onclick="start_im('{MEMBER_ID;*}'); return false;">{USERNAME*}</a>
												{+END}
												{+START,IF,{$NOT,{CAN_IM}}}
													{USERNAME*}
												{+END}
											</td>
											<td id="online_{MEMBER_ID*}">{ONLINE_TEXT*}</td>
											<td>
												<label class="accessibility_hidden" for="select_{MEMBER_ID*}">{!CHOOSE}</label>
												<input type="checkbox" id="select_{MEMBER_ID*}" value="1" name="select_{MEMBER_ID*}" />
											</td>
										</tr>
									{+END}
								</tbody>
							</table></div>

							<div class="friend_actions">
								{+START,IF,{CAN_IM}}
									<input class="button_micro" disabled="disabled" id="invite_ongoing_im_button" type="button" value="{!INVITE_CURRENT_IM}" onclick="var people=get_ticked_people(this.form); if (people) invite_im(people);" />
									<input class="button_micro" type="button" value="{!START_IM}" onclick="var people=get_ticked_people(this.form); if (people) start_im(people);" />
								{+END}
								{+START,IF_NON_EMPTY,{URL_REMOVE_FRIENDS}}
									<input class="button_micro" type="submit" value="{!DUMP_FRIENDS}" onclick="var people=get_ticked_people(this.form); if (!people) return false; var t=this; window.fauxmodal_confirm('{!Q_SURE=;}',function(result) { if (result) { disable_button_just_clicked(t); click_link(t); } }); return false;" />
								{+END}
							</div>
						</form>
					{+END}

					<script type="text/javascript">
					// <![CDATA[
						{+START,LOOP,FRIENDS}
							{+START,IF,{$NEQ,{ONLINE_TEXT*},{!ACTIVE}}}
								document.getElementById('friend_img_{MEMBER_ID;^/}').className='friend_inactive';
							{+END}
						{+END}
					// ]]>
					</script>

					{+START,IF_EMPTY,{FRIENDS}}
						<p class="nothing_here">{!NO_FRIEND_ENTRIES}</p>
					{+END}

					{+START,IF_NON_EMPTY,{URL_ADD_FRIEND}}
						<p>{!MUST_ADD_CONTACTS}</p>

						<form title="{!ADD}: {!FRIEND_LIST}" method="post" action="{URL_ADD_FRIEND*}">
							<label class="accessibility_hidden" for="friend_username">{!USERNAME}: </label><input {+START,IF,{$MOBILE}}autocorrect="off" {+END}autocomplete="off" size="18" maxlength="80" onkeyup="update_ajax_member_list(this,null,false,event);" type="text" onfocus="if (this.value=='{!USERNAME*;}') { this.value=''; this.className='field_input_filled'; }" onblur="if (this.value=='') { this.value='{!USERNAME*;}'; this.className='field_input_non_filled'; }" class="field_input_non_filled" value="{!USERNAME}" id="friend_username" name="friend_username" />
							<input onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" value="{!ADD}" />
						</form>
					{+END}

					<h3 class="chat_lobby_options_header">{!OPTIONS}</h3>

					{CHAT_SOUND}

					<form title="{!SOUND_EFFECTS}" action="index.php" method="post" class="inline">
						<p>
							<label for="play_sound">{!SOUND_EFFECTS}:</label> <input type="checkbox" id="play_sound" name="play_sound" checked="checked" />
						</p>
					</form>

					<div class="alert_box_wrap" id="alert_box_wrap" style="display: none">
						<section class="box"><div class="box_inner">
							<h3>{!ALERT}</h3>

							<div id="alert_box"></div>
						</div></section>
					</div>
				</div>
			</div>
		</div></div>
	</div>
{+END}
