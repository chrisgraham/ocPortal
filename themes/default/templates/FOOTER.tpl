{+START,IF_PASSED,ERROR_MESSAGES_DURING_OUTPUT}
	{+START,IF,{$OR,{BAIL_OUT},{$IS_NON_EMPTY,{ERROR_MESSAGES_DURING_OUTPUT}}}}
		{ERROR_MESSAGES_DURING_OUTPUT}
		
		{+START,IF,{$DEV_MODE}}
			<script type="text/javascript">// <![CDATA[
				{+START,IF,{$IS_NON_EMPTY,{ERROR_MESSAGES_DURING_OUTPUT}}}try { window.scrollTo(0,1000000); } catch (e) {};{+END}
				window.fauxmodal_alert('{!PLEASE_REVIEW_ERRORS_AT_BOTTOM;}'); // Before Firefox dies with an XHTML error, let the developer see what is wrong
			//]]></script>
		{+END}
	{+END}
{+END}
{+START,IF,{SHOW_BOTTOM}}
<{$?,{$VALUE_OPTION,html5},footer,div} class="bottom float_surrounder"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/WPFooter"}>
	<div class="bottom_under">
		<div class="global_bottom">
			{+START,IF,{$CONFIG_OPTION,bottom_show_top_button}}<a accesskey="g" href="#"><img title="{!BACK_TO_TOP}" alt="{!BACK_TO_TOP}" src="{$IMG*,bottom/top}" /></a>{+END}
			{+START,IF,{$ADDON_INSTALLED,bookmarks}}{+START,IF,{$NOT,{$IS_GUEST}}}
				<span class="global_bottom_button_ref_point" id="bookmarks_menu_rel">&nbsp;</span><a accesskey="n" id="bookmarks_menu_button" onclick="if (typeof window.load_management_menu=='undefined') { require_javascript('javascript_staff'); window.setTimeout(document.getElementById('bookmarks_menu_button').onclick,10); return false; } else return load_management_menu('bookmarks',true);" href="{$PAGE_LINK*,_SEARCH:bookmarks}&amp;url={$SELF_URL*&}"><img id="bookmarks_menu_img" class="no_theme_img_click" title="{!BOOKMARKS}" alt="{!BOOKMARKS}" src="{$IMG*,bottom/bookmarksmenu}" /></a>&nbsp;
			{+END}{+END}
			{+START,IF,{$ADDON_INSTALLED,realtime_rain}}{+START,IF,{$CONFIG_OPTION,bottom_show_realtime_rain_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_realtime_rain}}{+START,IF,{$NOT,{$BROWSER_MATCHES,ie6}}}
				<a id="realtime_rain_button" onclick="if (typeof window.load_realtime_rain!='undefined') return load_realtime_rain(); else return false;" href="{$PAGE_LINK*,adminzone:admin_realtime_rain}"><img id="realtime_rain_img" title="{!realtime_rain:REALTIME_RAIN}" alt="{!realtime_rain:REALTIME_RAIN}" src="{$IMG*,bottom/realtime_rain}" /></a>&nbsp;
			{+END}{+END}{+END}{+END}
			{+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
				{+START,IF,{$ADDON_INSTALLED,occle}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_occle}}{+START,IF,{$CONFIG_OPTION,bottom_show_occle_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_occle}}
					<a id="occle_button" accesskey="o" onclick="if (typeof window.load_occle!='undefined') return load_occle(); else return false;" href="{$PAGE_LINK*,adminzone:admin_occle}"><img id="occle_img" title="OcCLE" alt="OcCLE" src="{$IMG*,bottom/occle}" /></a>&nbsp;
				{+END}{+END}{+END}{+END}
				{+START,IF,{$CONFIG_OPTION,bottom_show_admin_menu}}<span class="global_bottom_button_ref_point" id="management_menu_rel">&nbsp;</span><a accesskey="m" id="management_menu_button" onclick="if (typeof window.load_management_menu!='undefined') return load_management_menu(); else return false;" href="{$PAGE_LINK*,adminzone:admin}"><img id="management_menu_img" class="no_theme_img_click" title="{!MENU}" alt="{!MENU}" src="{$IMG*,bottom/managementmenu}" /></a>&nbsp;{+END}
				{+START,IF,{$EQ,{$BRAND_NAME},ocPortal}}<a id="ocpchat_button" accesskey="-" onclick="if (typeof window.load_ocpchat!='undefined') return load_ocpchat(event); else return false;" href="#"><img id="ocpchat_img" title="{!OCP_CHAT}" alt="{!OCP_CHAT}" src="{$IMG*,bottom/ocpchat}" /></a>&nbsp;{+END}
			{+END}

			{+START,IF,{HAS_SU}}
				<form title="{!SU_2} {!LINK_NEW_WINDOW}" class="inline" method="get" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" target="_blank">
					<div class="inline">
						{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},keep_su}

						<div class="accessibility_hidden"><label for="su">{!SU}</label></div>
						<input accesskey="w" size="10" onfocus="if (this.value=='{$USERNAME*;}') this.value='';" alt="{!SU}" type="text" value="{$USERNAME*;}" id="su" name="keep_su" />
						{+START,IF,{$NOT,{$JS_ON}}}
							<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SU}" />
						{+END}
					</div>
				</form>
			{+END}

			{+START,IF_NON_EMPTY,{STAFF_ACTIONS}}{+START,IF,{$CONFIG_OPTION,ocp_show_staff_page_actions}}
				<form onsubmit="return staff_actions_select(this);" title="{!SCREEN_DEV_TOOLS} {!LINK_NEW_WINDOW}" class="inline" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get" target="_blank">
					{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1,0,cache_blocks=0,keep_no_xhtml=1,keep_cache=<null>}}

					<div class="inline">
						<p class="accessibility_hidden"><label for="special_page_type">{!SCREEN_DEV_TOOLS}</label></p>
						<select id="special_page_type" name="special_page_type">
							{STAFF_ACTIONS}
						</select>
						<input class="button_micro" type="submit" value="{!PROCEED_SHORT}" />
					</div>
				</form>
			{+END}{+END}
		</div>
		{+START,IF,{$ADDON_INSTALLED,flagrant}}{+START,IF_NON_EMPTY,{$FLAGRANT}}
			<div class="global_flagrant">
				{$FLAGRANT`}
			</div>
		{+END}{+END}
		<div class="global_copyright">
			{$,Uncomment to show user's time {$DATE} {$TIME}}
			{$COPYRIGHT`}
			<{$?,{$VALUE_OPTION,html5},nav,div} class="global_minilinks"{$?,{$VALUE_OPTION,html5}, role="navigation"}>
				<span class="accessibility_hidden"><a accesskey="1" href="{$PAGE_LINK*,:}">{$SITE_NAME*}</a> <span class="linkcolor">&middot;</span></span>
				<span class="accessibility_hidden"><a accesskey="0" href="{$PAGE_LINK*,:keymap}">{!KEYBOARD_MAP}</a> <span class="linkcolor">&middot;</span></span>
				{+START,IF,{$CONFIG_OPTION,bottom_show_sitemap_button}}<a accesskey="3" rel="site_map" href="{$PAGE_LINK*,_SEARCH:sitemap}">{!SITE_MAP}</a> <span class="linkcolor">&middot;</span>{+END}
				{+START,IF,{$CONFIG_OPTION,bottom_show_privacy_link}}<a rel="site_privacy" accesskey="8" href="{$PAGE_LINK*,:privacy}">{!PRIVACY}</a> <span class="linkcolor">&middot;</span>{+END}
				{+START,IF,{$CONFIG_OPTION,bottom_show_feedback_link}}<a rel="site_contact" accesskey="9" href="{$PAGE_LINK*,:feedback}{+START,IF,{$NOT,{$IN_STR,{$PAGE_LINK,:feedback},?}}}?{+END}{+START,IF,{$NOT,{$NOT,{$IN_STR,{$PAGE_LINK,:feedback},?}}}}&amp;{+END}redirect={$SELF_URL*&,1}">{!FEEDBACK}</a> <span class="linkcolor">&middot;</span>{+END}
				{+START,IF,{$CONFIG_OPTION,mobile_support}}{+START,IF,{$MOBILE,1}}<a href="{$SELF_URL*,1,0,0,keep_mobile=0}">{!NONMOBILE_VERSION}</a>{+END}{+START,IF,{$NOT,{$MOBILE,1}}}<a href="{$SELF_URL*,1,0,0,keep_mobile=1}">{!MOBILE_VERSION}</a>{+END} <span class="linkcolor">&middot;</span>{+END}
				{+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}<form title="{!LOGOUT}" class="inline" method="post" action="{$PAGE_LINK*,:login:logout}"><input class="buttonhyperlink" type="submit" title="{!_LOGOUT,{$USERNAME*}}" value="{!LOGOUT}" /></form>{+END}{+START,IF,{$OR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}<a href="{$PAGE_LINK*,:login:{$?,{$NOR,{$GET,login_screen},{$EQ,{$ZONE}:{$PAGE},:login}},redirect={$SELF_URL*&,1}}}">{!_LOGIN}</a>{+END}

				{+START,IF,{$AND,{$NOT,{$_GET,keep_has_js}},{$JS_ON}}}
					<noscript>&middot; <a href="{$SELF_URL*,1,0,1}&amp;keep_has_js=0">{!MARK_JAVASCRIPT_DISABLED}</a></noscript>
				{+END}
			</{$?,{$VALUE_OPTION,html5},nav,div}>
		</div>
	</div>
</{$?,{$VALUE_OPTION,html5},footer,div}>
{+END}
{$JS_TEMPCODE,footer}
<script type="text/javascript">// <![CDATA[
	scriptLoadStuff();
	if (typeof window.scriptPageRendered!='undefined') scriptPageRendered();

	{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
//]]></script>
{$EXTRA_FOOT}
</div></body>
</html>

