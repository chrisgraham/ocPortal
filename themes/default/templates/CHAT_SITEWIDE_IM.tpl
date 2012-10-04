<script type="text/javascript">// <![CDATA[
	if ((typeof window.im_area_template=='undefined') && (!window.load_from_room_id)) // Only if not in chat lobby or chat room, so as to avoid conflicts
	{
		var im_area_template='{IM_AREA_TEMPLATE;^/}';
		var im_participant_template='{IM_PARTICIPANT_TEMPLATE;^/}';
		var all_conversations=[];
		var top_window=window;
		var lobby_link='{$PAGE_LINK;,_SEARCH:chat:misc:enter_im=!!}';

		function begin_im_chatting()
		{
			window.load_from_room_id=-1;
			if ((window.chat_check) && (window.do_ajax_request)) chat_check(true,0); else window.setTimeout(begin_im_chatting,500);
		}
		add_event_listener_abstract(window,'load',function () {
			begin_im_chatting();
		} );
	}
// ]]></script>

{CHAT_SOUND}
