		{+START,IF,{SHOW_BOTTOM}}
			<div id="foot">
				{$BLOCK,block=side_stored_menu,param=main_website,type=tree}
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
