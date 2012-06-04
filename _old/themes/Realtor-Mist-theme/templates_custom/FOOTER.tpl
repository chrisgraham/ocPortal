			<div class="content-top"> </div>
		
			{+START,IF,{SHOW_BOTTOM}}
				<div id="footer-part">
					<div class="footer-in">
						<ul class="footer1">
							<li>
								<p>Powered by <a href="http://ocportal.com" target="_blank">ocPortal</a> and designed by <a href="http://ocproducts.com" target="_blank">ocProducts</a></p>
								<p>
									<a class="associated_details" href="{$PAGE_LINK*,adminzone}">[Admin Zone]</a>
								</p>
							</li>
							<li class="rights"><p>{$COPYRIGHT`}</p></li>
						</ul>
						{$BLOCK,block=side_stored_menu,param=main_website,type=tree}
					</div>
				</div>
			{+END}
		
			<div class="content-bot"> </div>
		
			{$JS_TEMPCODE,footer}
			<script type="text/javascript">// <![CDATA[
				script_load_stuff();
				if (typeof window.script_page_rendered!='undefined') script_page_rendered();
		
				{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
			//]]></script>
			{$EXTRA_FOOT}
		</div>
	</div>
</body>
</html>
