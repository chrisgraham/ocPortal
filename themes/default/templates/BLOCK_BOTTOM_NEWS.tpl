{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

{+START,SET,news_ticker_text}
	{$SET,done_a_ticker,0}
	{+START,LOOP,POSTS}
		{+START,IF,{$GET,done_a_ticker}} &middot; {+END}<a title="{NEWS_TITLE}: {DATE*}" class="nvn" href="{FULL_URL*}">{NEWS_TITLE}</a>{$SET,done_a_ticker,1}
	{+END}
{+END}

{$SET,bottom_news_id,{$RAND}}

<div id="ticktickticker_news{$GET%,bottom_news_id}">&nbsp;</div>
<script type="text/javascript">// <![CDATA[
	(function() {
		var ticktickticker=document.getElementById('ticktickticker_news{$GET%,bottom_news_id}');
		if ((browser_matches('opera')) || (browser_matches('chrome'))) // Slower, but chrome does not support marquee's
		{
			var my_id=parseInt(Math.random()*10000);
			tick_pos[my_id]=400;
			setInnerHTML(ticktickticker,'<div onmouseover="this.mouseisover=true;" onmouseout="this.mouseisover=false;" class="ticker" style="text-indent: 400px; width: 400px;" id="'+my_id+'"><span>{$GET/;~,news_ticker_text}<span><\/span><\/div>');
			window.focused=true;
			addEventListenerAbstract(window,"focus",function() { window.focused=true; });
			addEventListenerAbstract(window,"blur",function() { window.focused=false; });
			timer=window.setInterval(function() { ticker_tick(my_id,400); }, 50);
		} else
		{
			setInnerHTML(ticktickticker,'<marquee style="display: block" class="ticker" onmouseover="this.setAttribute(\'scrolldelay\',\'10000\');" onmouseout="this.setAttribute(\'scrolldelay\',50);" scrollamount="2" scrolldelay="'+(50)+'" width="400">{$GET/;~,news_ticker_text}<\/marquee>');
		}
	}) ();
//]]></script>
<noscript>
	{$GET,news_ticker_text}
</noscript>

