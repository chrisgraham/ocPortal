		{+START,IF,{SHOW_BOTTOM}}
			<div id="footer-part">
				<div class="adv-box">{$BANNER}</div>
				<ul class="footer">
					<li>
						{$BLOCK,block=main_screen_actions}
						<div class="footer-menu">
							{$BLOCK,block=side_stored_menu,param=member_features,type=top}
						</div>
					</li>
					<li class="powered">
						<p>Powered by <a href="http://ocportal.com" target="_blank">ocPortal</a> and designed by <a href="http://ocproducts.com" target="_blank">ocProducts</a></p>
						<div class="rights"><p>{$COPYRIGHT`}</p></div>
					</li>
				</ul>
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

