	</div>

	{+START,IF,{SHOW_BOTTOM}}
		<div id="footer">
			<div class="float_surrounder">
				<div id="footer-in">
					<div class="footer-in2">
						<ul>
							<li>
								<p>Powered by <a href="http://ocportal.com" target="_blank">ocPortal</a> and designed by <a href="http://ocproducts.com" target="_blank">ocProducts</a></p>
							</li>
						</ul>
					</div>
					<div class="footer-in2">
						<ul>
							<li>{$BLOCK,block=side_stored_menu,param=main_website,type=zone}</li>
						</ul>
					</div>
					<div class="footer-in2">
						<ul>
							<li>{$BLOCK,block=side_stored_menu,param=member_features,type=zone}</li>
						</ul>
					</div>
					<div class="footer-in2">
						<ul>
							<li>{$BLOCK,block=side_stored_menu,param=zone_menu,type=zone}</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	{+END}

	{$JS_TEMPCODE,footer}
	<script type="text/javascript">// <![CDATA[
		script_load_stuff();
		if (typeof window.script_page_rendered!='undefined') script_page_rendered();

		{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
	//]]></script>
	{$EXTRA_FOOT}
</body>
</html>

