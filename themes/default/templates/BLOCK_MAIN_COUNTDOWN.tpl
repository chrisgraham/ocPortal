{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}

{$SET,countdown_id,countdown_{$RAND}}

<span id="{$GET,countdown_id}" role="timer">{LANG}</span>

<script type="text/javascript">// <![CDATA[
	window.setInterval(function()
	{
		countdown('{$GET,countdown_id}',{$?,{POSITIVE},-1*{DISTANCE_FOR_PRECISION*},+1*{DISTANCE_FOR_PRECISION*}},{TAILING%});
	},{MILLISECONDS_FOR_PRECISION*});
//]]></script>
