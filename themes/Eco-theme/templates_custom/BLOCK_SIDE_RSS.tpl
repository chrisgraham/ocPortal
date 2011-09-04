<ul>
	{+START,IF,{$NOT,{TICKER}}}
		<li class="search-middle">
			{+START,BOX,,,{$?,{$GET,in_panel},panel,classic},tray_open}
				{+START,IF_EMPTY,{CONTENT}}
					<p class="block_no_entries">&raquo; {!NO_NEWS}</p>
				{+END}
				{+START,IF_NON_EMPTY,{CONTENT}}
					<div class="xhtml_validator_off">
						{CONTENT}
					</div>
				{+END}
			{+END}
		</li>
	{+END}
	
	{+START,IF,{TICKER}}
		<li class="search-middle">
		<h6>	{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic},tray_open}
				{+START,IF_EMPTY,{CONTENT}}
					<p class="block_no_entries">&raquo; {!NO_NEWS}</p>
				{+END}
				{+START,IF_NON_EMPTY,{CONTENT}}
					<p><div onmouseover="this.paused=true;" onmouseout="this.paused=false;" class="xhtml_validator_off wide_ticker" id="news_scroller">
						{CONTENT}
					</div></p>
				{+END}
			{+END}</h6>
		</li>
		<li class="search_bottom">.</li>
		<script type="text/javascript">// <![CDATA[
			var scroll_speed=60;
			var scroller=document.getElementById('news_scroller');
			scroller.paused=false;
			if (scroller.scrollHeight<300) scroll_speed=300; // Slow, as not much to scroll
			window.setTimeout(function() {
				window.setInterval(function() {
					var scroller=document.getElementById('news_scroller');
					if (scroller.paused) return;
					if (scroller.scrollTop+findHeight(scroller)>=scroller.scrollHeight-1)
						scroller.scrollTop=0;
					else
						scroller.scrollTop++;
				} , scroll_speed);
			} ,2000);
		//]]></script>
	{+END}
</ul>
