		{+START,IF,{SHOW_BOTTOM}}
			<div id="footer">
				<div class="footer-in">
					<ul class="footer1">
						<li>
							<p>Powered by <a href="http://ocportal.com" target="_blank">ocPortal</a> and designed by <a href="http://ocproducts.com" target="_blank">ocProducts</a></p>
							<div class="rights"><p>{$COPYRIGHT`}</p></div>
						</li>
						<li class="footer-divider"> </li>
						<li>{$BLOCK,block=side_stored_menu,param=main_features,type=zone}</li>
						<li class="footer-divider"> </li>
						<li>{$BLOCK,block=side_stored_menu,param=main_content,type=zone}</li>
						<li class="footer-divider"> </li>
						<li>{$BLOCK,block=side_stored_menu,param=forum_features,type=zone}</li>
					</ul>
				</div>
			</div>
		{+END}
	</div>

	{$JS_TEMPCODE,footer}
	<script type="text/javascript">// <![CDATA[
		script_load_stuff();
		if (typeof window.script_page_rendered!='undefined') script_page_rendered();

		{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
	//]]></script>
	{$EXTRA_FOOT}
</body>
</html>
