{+START,BOX,{!SHOUTBOX},,{$?,{$GET,in_panel},panel,classic},tray_closed}
	{+START,IF_NON_PASSED,CONTENT}
		{$SET,sbid,{$FIX_ID,{$RAND}}}
		<iframe{$?,{$BROWSER_MATCHES,ie}, frameBorder="0" scrolling="no"} title="{!SHOUTBOX}" id="the_shoutbox{$GET%,sbid}" name="the_shoutbox{$GET%,sbid}" class="expandable_iframe" src="{$FIND_SCRIPT*,shoutbox}?room_id={ROOM_ID*}&amp;num_messages={NUM_MESSAGES*}{$KEEP*}&amp;utheme={$THEME*}">{!SHOUTBOX}</iframe>
		<script type="text/javascript">// <![CDATA[
			//setInterval('resizeFrame(\'the_shoutbox\')',5000);
		//]]></script>
	{+END}
	{+START,IF_PASSED,CONTENT}
		{CONTENT}
	{+END}
{+END}
