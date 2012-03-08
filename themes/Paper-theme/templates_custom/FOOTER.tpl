	{$JS_TEMPCODE,footer}
	<script type="text/javascript">// <![CDATA[
		scriptLoadStuff();
		if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

		{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
	//]]></script>
	{$EXTRA_FOOT}
</body>
</html>
