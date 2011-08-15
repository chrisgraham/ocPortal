<script type="text/javascript">
// <![CDATA[
	if ((typeof window.im_area_template=='undefined') && (!window.load_from_room_id)) // Only if not in chat lobby or chat room, so as to avoid conflicts
	{
		var im_area_template='{IM_AREA_TEMPLATE/^;}';
		var im_participant_template='{IM_PARTICIPANT_TEMPLATE/^;}';
		var all_conversations=[];
		var top_window=window;
		var lobby_link='{$PAGE_LINK;,_SEARCH:chat:misc:enter_im=!!}';

		function begin_im_chatting()
		{
			window.load_from_room_id=-1;
			if ((window.chat_check) && (window.load_XML_doc)) chat_check(true,0); else window.setTimeout(begin_im_chatting,500);
		}
		window.setTimeout(begin_im_chatting,6000); // To give chance for any existing popups to reopen
	}
// ]]>
</script>

{CHAT_SOUND}
