{TITLE}

{MESSAGE}

<p>{!USE_CHAT_RULES,{$PAGE_LINK*,:rules},{$PAGE_LINK*,:privacy}}</p>

{+START,BOX,{!ROOMS_LOBBY_TITLE}}
	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{ADD_ROOM_URL}{PRIVATE_ROOM}{BLOCKING_LINK}{MOD_LINK}{SETEFFECTS_LINK}}
			<{$?,{$VALUE_OPTION,html5},nav,div} class="chat_actions">
				<h2>{!ADVANCED_ACTIONS}</h2>
			
				<ul class="actions_list spaced_list">
					{+START,IF_NON_EMPTY,{ADD_ROOM_URL}}
						<li>&raquo; <a href="{ADD_ROOM_URL*}" rel="add">{!ADD_CHATROOM}</a></li>
					{+END}
					{+START,IF_NON_EMPTY,{PRIVATE_ROOM}}
						<li>&raquo; {PRIVATE_ROOM}</li>
					{+END}
					{+START,IF_NON_EMPTY,{BLOCKING_LINK}}
						<li>&raquo; {BLOCKING_LINK}</li>
					{+END}
					{+START,IF_NON_EMPTY,{MOD_LINK}}
						<li>&raquo; {MOD_LINK}</li>
					{+END}
					{+START,IF_NON_EMPTY,{SETEFFECTS_LINK}}
						<li>&raquo; {SETEFFECTS_LINK}</li>
					{+END}
				</ul>
			</{$?,{$VALUE_OPTION,html5},nav,div}>
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
{+END}

{+START,IF,{$NOT,{$IS_GUEST}}}
	<div class="chat_im_convos_wrap">
		{+START,BOX,{!INSTANT_MESSAGING}}
			<div class="float_surrounder chat_im_convos_inner">
				<div class="chat_lobby_convos">
					<h2>{!IM_CONVERSATIONS}</h2>
				
					<div id="chat_lobby_convos_tabs" style="display: none">
						&nbsp;
					</div>
					<div id="chat_lobby_convos_areas">
						<p class="nothing_here">
							{!NO_IM_CONVERSATIONS}
						</p>
					</div>

					<script type="text/javascript">
					// <![CDATA[
						var im_area_template='{IM_AREA_TEMPLATE/^;}';
						var im_participant_template='{IM_PARTICIPANT_TEMPLATE/^;}';
						var all_conversations=[];
						var top_window=window;

						function begin_im_chatting()
						{
							window.load_from_room_id=-1;
							if ((window.chat_check) && (window.load_XML_doc)) chat_check(true,0); else window.setTimeout(begin_im_chatting,500);
						}
						begin_im_chatting();
					// ]]>
					</script>
				</div>
			
				<div class="chat_lobby_buddies">
					<h2>{!BUDDY_LIST}</h2>
				
					{+START,IF_NON_EMPTY,{BUDDIES}}
						<form title="{!BUDDY_LIST}" method="post" action="{$?,{$IS_EMPTY,{URL_REMOVE_BUDDIES}},index.php,{URL_REMOVE_BUDDIES*}}">
							<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="solidborder wide_table variable_table">
								<thead>
									<tr>
										<th>&nbsp;</th>
										<th>{!NAME}</th>
										<th><a target="_blank" title="{!ONLINE}: {!LINK_NEW_WINDOW}" href="{ONLINE_URL*}">{!ONLINE}</a></th>
										<th>{!CHOOSE}</th>
									</tr>
								</thead>
								<tbody>
									{+START,LOOP,BUDDIES}
										<tr>
											<td><img id="buddy_img_{MEMBER_ID*}" alt="" src="{$IMG*,menu_items/forum_navigation/members}" /></td>
											<td><a rel="friend" title="{USERNAME*}: {!START_IM}" href="#" onclick="start_im('{MEMBER_ID*}'); return false;">{USERNAME*}</a></td>
											<td id="online_{MEMBER_ID*}">{ONLINE_TEXT*}</td>
											<td>
												<label class="accessibility_hidden" for="select_{MEMBER_ID*}">{!CHOOSE}</label>
												<input type="checkbox" id="select_{MEMBER_ID*}" value="1" name="select_{MEMBER_ID*}" />
											</td>
										</tr>
									{+END}
								</tbody>
							</table></div>

							<div class="buddy_actions">
								{+START,IF,{CAN_IM}}
									<input class="button_pageitem" disabled="disabled" id="invite_ongoing_im_button" type="button" value="{!INVITE_CURRENT_IM}" onclick="var people=get_ticked_people(this.form); if (people) invite_im(people);" />
									<input class="button_pageitem" type="button" value="{!START_IM}" onclick="var people=get_ticked_people(this.form); if (people) start_im(people);" />
								{+END}
								{+START,IF_NON_EMPTY,{URL_REMOVE_BUDDIES}}
									<input class="button_pageitem" type="submit" value="{!DUMP_BUDDIES}" onclick="var people=get_ticked_people(this.form); if ((!people) || (!window.confirm('{!Q_SURE*;}'))) return false; disable_button_just_clicked(this); return true;" />
								{+END}
							</div>
						</form>
					{+END}
			
					<script type="text/javascript">
					// <![CDATA[
						{+START,LOOP,BUDDIES}
							{+START,IF,{$NEQ,{ONLINE_TEXT*},{!ACTIVE}}}
								setOpacity(document.getElementById('buddy_img_{MEMBER_ID/^;}'),0.4);
							{+END}
						{+END}
					// ]]>
					</script>
			
					{+START,IF_EMPTY,{BUDDIES}}
						<p class="nothing_here">{!NO_BUDDY_ENTRIES}</p>
					{+END}
			
					{+START,IF_NON_EMPTY,{URL_ADD_BUDDY}}
						<p>{!MUST_ADD_CONTACTS}</p>
					
						<form title="{!ADD}: {!BUDDY_LIST}" method="post" action="{URL_ADD_BUDDY*}">
							<label class="accessibility_hidden" for="buddy_username">{!USERNAME}: </label><input size="18" maxlength="80" onkeyup="update_ajax_member_list(this,null,false,event);" type="text" onfocus="if (this.value=='{!USERNAME}') { this.value=''; this.style.color='black'; } update_ajax_member_list(this,event);" onblur="if (this.value=='') { this.value='{!USERNAME}'; this.style.color='gray'; }" style="color: gray" value="{!USERNAME}" id="buddy_username" name="buddy_username" />
							<input onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" value="{!ADD}" />
						</form>
					{+END}

					<h2 class="chat_lobby_options_header">{!OPTIONS}</h2>
			
					{CHAT_SOUND}
			
					<form title="{!SOUND_EFFECTS}" action="index.php" method="post" class="inline">
						<p>
							<label for="play_sound">{!SOUND_EFFECTS}</label> <input type="checkbox" id="play_sound" name="play_sound" checked="checked" />
						</p>
					</form>

					<div id="alert_box_wrap" style="display: none">
						{+START,BOX,{!ALERT},220px}
							<div id="alert_box">
								&nbsp;
							</div>
						{+END}
					</div>
				</div>
			</div>
		{+END}
	</div>
{+END}
