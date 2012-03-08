	</div>

	<div id="main-bottom"> </div>

	{+START,IF,{SHOW_BOTTOM}}
		<div id="footer">
			{$BLOCK,block=side_stored_menu,param=main_website,type=zone}
		</div>
	{+END}

	{$JS_TEMPCODE,footer}
	<script type="text/javascript">// <![CDATA[
		scriptLoadStuff();
		if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

		{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
	//]]></script>
	{$EXTRA_FOOT}
</body>
</html>

