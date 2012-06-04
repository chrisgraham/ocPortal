		<ul class="footer">
			<li><a href="http://twitter.com/{$CONFIG_OPTION*,twitter_login}"><img src="{$IMG*,twitter}" width="35" height="35" alt="twitter" /></a></li>
			<li><a href="http://facebook.com/"><img src="{$IMG*,facebook}" width="35" height="35" alt="facebook" /></a></li>
			{$BLOCK,block=side_stored_menu,type=embossed,param=main_features}
		</ul>

		{$JS_TEMPCODE,footer}
		<script type="text/javascript">// <![CDATA[
			scriptLoadStuff();
			if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

			{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
		//]]></script>
		{$EXTRA_FOOT}
	</div>
</body>
</html>
