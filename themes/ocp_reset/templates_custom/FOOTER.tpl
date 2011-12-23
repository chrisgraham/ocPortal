{+START,IF_PASSED,ERROR_MESSAGES_DURING_OUTPUT}
	{+START,IF,{$OR,{BAIL_OUT},{$IS_NON_EMPTY,{ERROR_MESSAGES_DURING_OUTPUT}}}}
		{ERROR_MESSAGES_DURING_OUTPUT}
		
		{+START,IF,{$DEV_MODE}}
			<script type="text/javascript">// <![CDATA[
				{+START,IF,{$IS_NON_EMPTY,{ERROR_MESSAGES_DURING_OUTPUT}}}window.scrollTo(0,1000000);{+END}
				window.fauxmodal_alert('{!PLEASE_REVIEW_ERRORS_AT_BOTTOM;}'); // Before Firefox dies with an XHTML error, let the developer see what is wrong
			//]]></script>
		{+END}
	{+END}
{+END}
{+START,IF,{SHOW_BOTTOM}}

<div class="global_bottom">
    {+START,IF,{$CONFIG_OPTION,bottom_show_top_button}}<a accesskey="g" href="#"><img title="{!BACK_TO_TOP}" alt="{!BACK_TO_TOP}" src="{$IMG*,bottom/top}" /></a>{+END}
    <a class="accessibility_hidden" accesskey="1" href="{$PAGE_LINK*,:}"><img title="{$SITE_NAME*}" alt="{$SITE_NAME*}" src="{$IMG*,bottom/home}" /></a>&nbsp;
    <a class="accessibility_hidden" accesskey="0" href="{$PAGE_LINK*,:keymap}">{!KEYBOARD_MAP}</a>
    {+START,IF,{$CONFIG_OPTION,bottom_show_sitemap_button}}<a accesskey="3" href="{$PAGE_LINK*,_SEARCH:sitemap}"><img title="{!SITE_MAP}" alt="{!SITE_MAP}" src="{$IMG*,bottom/sitemap}" /></a>&nbsp;{+END}
    {+START,IF,{$ADDON_INSTALLED,bookmarks}}{+START,IF,{$NOT,{$IS_GUEST}}}
        <span class="global_bottom_button_ref_point" id="bookmarks_menu_rel">&nbsp;</span><a accesskey="n" id="bookmarks_menu_button" onclick="return false;" href="{$PAGE_LINK*,_SEARCH:bookmarks}&amp;url={$SELF_URL*&}"><img id="bookmarks_menu_img" class="no_theme_img_click" title="{!BOOKMARKS}" alt="{!BOOKMARKS}" src="{$IMG*,bottom/bookmarksmenu}" /></a>&nbsp;
    {+END}{+END}
    {+START,IF,{$ADDON_INSTALLED,realtime_rain}}{+START,IF,{$CONFIG_OPTION,bottom_show_realtime_rain_button}}{+START,IF,{$NOT,{$MATCH_KEY_MATCH,adminzone:admin_realtime_rain}}}{+START,IF,{$NOT,{$BROWSER_MATCHES,ie6}}}
        <a id="realtime_rain_button" onclick="if (typeof window.load_realtime_rain!='undefined') return load_realtime_rain(); else return false;" href="{$PAGE_LINK*,adminzone:admin_realtime_rain}"><img id="realtime_rain_img" title="{!realtime_rain:REALTIME_RAIN}" alt="{!realtime_rain:REALTIME_RAIN}" src="{$IMG*,bottom/realtime_rain}" /></a>&nbsp;
    {+END}{+END}{+END}{+END}
    {+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
        {+START,IF,{$ADDON_INSTALLED,occle}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_occle}}{+START,IF,{$CONFIG_OPTION,bottom_show_occle_button}}
            <a id="occle_button" accesskey="o" onclick="if (typeof window.load_occle!='undefined') return load_occle(); else return false;" href="{$PAGE_LINK*,adminzone:admin_occle}"><img id="occle_img" title="OcCLE" alt="OcCLE" src="{$IMG*,bottom/occle}" /></a>&nbsp;
        {+END}{+END}{+END}
        {+START,IF,{$CONFIG_OPTION,bottom_show_admin_menu}}<span class="global_bottom_button_ref_point" id="management_menu_rel">&nbsp;</span><a accesskey="m" id="management_menu_button" onfocus="if (typeof window.load_management_menu!='undefined') return load_management_menu(); else return false;" onclick="return false;" href="{$PAGE_LINK*,adminzone:admin}"><img id="management_menu_img" class="no_theme_img_click" title="{!MENU}" alt="{!MENU}" src="{$IMG*,bottom/managementmenu}" /></a>&nbsp;{+END}
    {+START,IF,{$EQ,{$BRAND_NAME},ocPortal}}<a id="ocpchat_button" accesskey="-" onclick="if (typeof window.load_ocpchat!='undefined') return load_ocpchat(event); else return false;" href="#"><img id="ocpchat_img" title="{!OCP_CHAT}" alt="{!OCP_CHAT}" src="{$IMG*,bottom/ocpchat}" /></a>&nbsp;{+END}
    {+END}
</div>

{+START,IF,{$ADDON_INSTALLED,flagrant}}{+START,IF_NON_EMPTY,{$FLAGRANT}}
    <div class="global_flagrant">
        {$FLAGRANT`}
    </div>
{+END}{+END}

<div class="global_copyright">
    {$COPYRIGHT`}
    <div class="global_minilinks">
        {+START,IF,{$CONFIG_OPTION,bottom_show_privacy_link}}<a accesskey="8" href="{$PAGE_LINK*,_SEARCH:privacy}">{!PRIVACY}</a>{+START,IF,{$OR,{$NOT,{$OR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}},{$CONFIG_OPTION,bottom_show_privacy_link}}} <span class="linkcolor">&middot;</span>{+END}{+END}
        {+START,IF,{$CONFIG_OPTION,bottom_show_feedback_link}}<a accesskey="9" href="{$PAGE_LINK*,_SEARCH:feedback}{+START,IF,{$NOT,{$IN_STR,{$PAGE_LINK,_SEARCH:feedback},?}}}?{+END}{+START,IF,{$NOT,{$NOT,{$IN_STR,{$PAGE_LINK,_SEARCH:feedback},?}}}}&amp;{+END}redirect={$SELF_URL*&,1}">{!FEEDBACK}</a>{+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}} <span class="linkcolor">&middot;</span>{+END}{+END}
        {+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}<form title="{!LOGOUT}" class="inline" method="post" action="{$PAGE_LINK*,:login:logout}"><input class="buttonhyperlink" type="submit" title="{!_LOGOUT,{$USERNAME*}}" value="{!LOGOUT}" /></form>{+END}
    </div>
</div>

{+END}
{$JS_TEMPCODE,footer}
<script type="text/javascript">// <![CDATA[
	scriptLoadStuff();
	if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

	{+START,IF,{$EQ,{$_GET,wide_print},1}}window.print();{+END}
//]]></script>
{$EXTRA_FOOT}
</div></body>
</html>

