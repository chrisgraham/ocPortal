{$SET,RAND_ID_IMG,rand{$RAND}}

<img{+START,IF_NON_EMPTY,{ALIGN}} style="vertical-align: {ALIGN|}"{+END} src="{URL*}" {+START,IF_PASSED,ROLLOVER}id="{$GET%,RAND_ID_IMG}" {+END}title="{+START,IF_PASSED,TOOLTIP}{$STRIP_TAGS,{TOOLTIP}}{+END}{+START,IF_NON_PASSED,TOOLTIP}{$STRIP_TAGS,{CAPTION}}{+END}" alt="{$STRIP_TAGS,{CAPTION}}" />
{+START,IF_PASSED,ROLLOVER}
	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			create_rollover('{$GET,RAND_ID_IMG}','{ROLLOVER;~}');
		} );
	//]]></script>
{+END}
{+START,IF_PASSED,REFRESH_TIME}
	{+START,IF,{$NEQ,{REFRESH_TIME},0}}
		<script type="text/javascript">// <![CDATA[
			window.setInterval(function() {
				var ob=document.getElementById('{$GET,RAND_ID_IMG}')
				if (!ob.timer) ob.timer=0;
				ob.timer+={REFRESH_TIME%};
				if (ob.src.indexOf('?')==-1)
				{
					ob.src+='?time='+ob.timer;
				} else if (ob.src.indexOf('time=')==-1)
				{
					ob.src+='&time='+ob.timer;
				} else
				{
					ob.src=ob.src.replace(/time=\d+/,'time='+ob.timer);
				}
			},{REFRESH_TIME%})
		//]]></script>
	{+END}
{+END}
