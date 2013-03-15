<section class="box box___block_side_shoutbox_iframe"><div class="box_inner">
	<h3>{!SHOUTBOX}</h3>

	{+START,IF_NON_PASSED,CONTENT}
		{$SET,sbid,{$FIX_ID,{$RAND}}}
		<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} title="{!SHOUTBOX}" id="the_shoutbox{$GET%,sbid}" name="the_shoutbox{$GET%,sbid}" class="expandable_iframe" src="{$FIND_SCRIPT*,shoutbox}?room_id={ROOM_ID*}&amp;num_messages={NUM_MESSAGES*}{$KEEP*}&amp;utheme={$THEME*}">{!SHOUTBOX}</iframe>
		<script type="text/javascript">// <![CDATA[
			//window.setInterval(function() { resize_frame('the_shoutbox'); },5000);
		//]]></script>
	{+END}
	{+START,IF_PASSED,CONTENT}
		{CONTENT}
	{+END}

	<script type="text/javascript">// <![CDATA[
		var sb_room_id={ROOM_ID%};
		add_event_listener_abstract(window,'load',function () {
			{+START,IF_NON_EMPTY,{LAST_MESSAGE_ID}}
				sb_chat_check({LAST_MESSAGE_ID%},-1);
			{+END}
		} );
	//]]></script>
</div></section>
