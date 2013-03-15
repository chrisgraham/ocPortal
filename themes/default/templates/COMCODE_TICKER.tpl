{$SET,RAND_ID_TICKER,rand{$RAND}}

{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}
<div{$?,{$VALUE_OPTION,html5}, role="marquee"} id="ticktickticker{$GET%,RAND_ID_TICKER}">&nbsp;</div>
<script type="text/javascript">// <![CDATA[
addEventListenerAbstract(window,'load',function () {
	var ticktickticker=document.getElementById('ticktickticker{$GET%,RAND_ID_TICKER}');
	if ((browser_matches('opera')) || (browser_matches('chrome'))) // Slower, but chrome does not support marquee's
	{
		var my_id=parseInt(Math.random()*10000);
		tick_pos[my_id]={WIDTH%};
		setInnerHTML(ticktickticker,'<div onmouseover="this.mouseisover=true;" onmouseout="this.mouseisover=false;" class="ticker" style="text-indent: {WIDTH|}px; width: {WIDTH|}px;" id="'+my_id+'"><span>{TEXT/;~}<\/span><\/div>');
		window.focused=true;
		addEventListenerAbstract(window,"focus",function() { window.focused=true; });
		addEventListenerAbstract(window,"blur",function() { window.focused=false; });
		timer=window.setInterval(function() { ticker_tick(my_id,{WIDTH%}); },100/{SPEED%});
	} else
	{
		setInnerHTML(ticktickticker,'<marquee style="display: block" class="ticker" onmouseover="this.setAttribute(\'scrolldelay\',\'10000\');" onmouseout="this.setAttribute(\'scrolldelay\',(100/{SPEED%}));" scrollamount="2" scrolldelay="'+(100/{SPEED%})+'" width="{WIDTH|}">{TEXT/;~}<\/marquee>');
	}
} );
//]]></script>
<noscript>
	{TEXT}
</noscript>

