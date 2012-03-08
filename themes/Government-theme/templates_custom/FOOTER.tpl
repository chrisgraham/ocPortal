		{+START,IF,{SHOW_BOTTOM}}
			<div id="footer">
				<ul>
					<li><a href="#">Home</a> </li>
					<li><a href="#">About us</a> </li>
					<li><a href="#">Forum </a></li>
					<li><a href="#">Blog</a></li>
					<li><a href="#">Contact us </a></li>
					<li>
						<a class="associated_details" href="{$PAGE_LINK*,adminzone}">[Admin Zone]</a>
					</li>
				</ul>
			</div>
		{+END}
	</div>

	{$JS_TEMPCODE,footer}
	<script type="text/javascript">// <![CDATA[
		scriptLoadStuff();
		if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

		{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
	//]]></script>
	{$EXTRA_FOOT}
</body>
</html>
