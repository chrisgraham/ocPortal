	{+START,IF,{SHOW_BOTTOM}}
		<div id="footer">
			<div class="footer-in">
				<ul class="footer1">
					<li>
						<p>Powered by <a href="http://ocportal.com" target="_blank">ocPortal</a> and designed by <a href="http://ocproducts.com" target="_blank">ocProducts</a></p>
					</li>
					<li class="rights"><p>{$COPYRIGHT`}</p></li>
				</ul>
				<ul class="footer2">
					<li>{$BLOCK,block=side_stored_menu,param=main_website,type=tree}</li>
				</ul>
			</div>
		</div>
	{+END}

	{$JS_TEMPCODE,footer}
	<script type="text/javascript">// <![CDATA[
		scriptLoadStuff();
		if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

		{+START,IF,{$EQ,{$_GET,wide_print},1}}window.print();{+END}
	//]]></script>
	{$EXTRA_FOOT}
</body>
</html>
