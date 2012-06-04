{+START,IF,{SHOW_BOTTOM}}
	<div class="bottom float_surrounder">
		<div class="bottom_under">
			<div class="global_copyright">
				{$,Uncomment to show user's time {$DATE} {$TIME}}
				{$COPYRIGHT`}
				<div class="global_minilinks">
					<span class="accessibility_hidden"><a accesskey="1" href="{$PAGE_LINK*,:}">{$SITE_NAME*}</a> <span class="linkcolor">&middot;</span></span>
					<span class="accessibility_hidden"><a accesskey="0" href="{$PAGE_LINK*,:keymap}">{!KEYBOARD_MAP}</a> <span class="linkcolor">&middot;</span></span>
					{+START,IF,{$CONFIG_OPTION,bottom_show_sitemap_button}}<a accesskey="3" rel="site_map" href="{$PAGE_LINK*,_SEARCH:sitemap}">{!SITE_MAP}</a> <span class="linkcolor">&middot;</span>{+END}
					{+START,IF,{$CONFIG_OPTION,bottom_show_privacy_link}}<a rel="site_privacy" accesskey="8" href="{$PAGE_LINK*,:privacy}">{!PRIVACY}</a> <span class="linkcolor">&middot;</span>{+END}
					{+START,IF,{$CONFIG_OPTION,bottom_show_feedback_link}}<a rel="site_contact" accesskey="9" href="{$PAGE_LINK*,_SEARCH:feedback}{+START,IF,{$NOT,{$IN_STR,{$PAGE_LINK,_SEARCH:feedback},?}}}?{+END}{+START,IF,{$NOT,{$NOT,{$IN_STR,{$PAGE_LINK,_SEARCH:feedback},?}}}}&amp;{+END}redirect={$SELF_URL*&,1}">{!FEEDBACK}</a> <span class="linkcolor">&middot;</span>{+END}
					{+START,IF,{$CONFIG_OPTION,mobile_support}}{+START,IF,{$MOBILE,1}}<a href="{$SELF_URL*,1,0,0,keep_mobile=0}">{!NONMOBILE_VERSION}</a>{+END}{+START,IF,{$NOT,{$MOBILE,1}}}<a href="{$SELF_URL*,1,0,0,keep_mobile=1}">{!MOBILE_VERSION}</a>{+END} <span class="linkcolor">&middot;</span>{+END}
					{+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}<form title="{!LOGOUT}" class="inline" method="post" action="{$PAGE_LINK*,:login:logout}"><input class="buttonhyperlink" type="submit" title="{!_LOGOUT,{$USERNAME*}}" value="{!LOGOUT}" /></form>{+END}{+START,IF,{$OR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}<a href="{$PAGE_LINK*,:login:{$?,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,:login}},redirect={$SELF_URL*&,1}}}">{!_LOGIN}</a>{+END}
	
					{+START,IF,{$AND,{$NOT,{$_GET,keep_has_js}},{$JS_ON}}}
						<noscript>&middot; <a href="{$SELF_URL*,1,0,1}&amp;keep_has_js=0">{!MARK_JAVASCRIPT_DISABLED}</a></noscript>
					{+END}
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
</div></body>
</html>
