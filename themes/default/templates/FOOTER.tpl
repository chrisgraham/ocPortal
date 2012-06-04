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

		{$,This is the main site footer; if you like your layout in one place you can move it to GLOBAL.tpl}
		{+START,IF,{$SHOW_FOOTER}}
			<footer class="float_surrounder" itemscope="itemscope" itemtype="http://schema.org/WPFooter">
				<div class="global_footer_left">
					{+START,SET,FOOTER_BUTTONS}
						{+START,IF,{$CONFIG_OPTION,bottom_show_top_button}}
							<li><a accesskey="g" href="#"><img width="20" height="20" title="{!BACK_TO_TOP}" alt="{!BACK_TO_TOP}" src="{$IMG*,footer/top}" /></a></li>
						{+END}
						{+START,IF,{$ADDON_INSTALLED,bookmarks}}{+START,IF,{$NOT,{$IS_GUEST}}}
							<li>
								<span class="global_footer_button_ref_point" id="bookmarks_menu_rel"></span>
								<a accesskey="n" id="bookmarks_menu_button" onclick="if (typeof window.load_management_menu=='undefined') { require_javascript('javascript_staff'); window.setTimeout(document.getElementById('bookmarks_menu_button').onclick,10); return false; } else return load_management_menu('bookmarks',true);" href="{$PAGE_LINK*,_SEARCH:bookmarks}&amp;url={$SELF_URL*&}"><img width="20" height="20" id="bookmarks_menu_img" class="no_theme_img_click" title="{!BOOKMARKS}" alt="{!BOOKMARKS}" src="{$IMG*,footer/bookmarksmenu}" /></a>
							</li>
						{+END}{+END}
						{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$ADDON_INSTALLED,realtime_rain}}{+START,IF,{$CONFIG_OPTION,bottom_show_realtime_rain_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_realtime_rain}}
							<li><a id="realtime_rain_button" onclick="if (typeof window.load_realtime_rain!='undefined') return load_realtime_rain(); else return false;" href="{$PAGE_LINK*,adminzone:admin_realtime_rain}"><img width="20" height="20" id="realtime_rain_img" title="{!realtime_rain:REALTIME_RAIN}" alt="{!realtime_rain:REALTIME_RAIN}" src="{$IMG*,footer/realtime_rain}" /></a></li>
						{+END}{+END}{+END}{+END}
						{+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
							{+START,IF,{$ADDON_INSTALLED,occle}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_occle}}{+START,IF,{$CONFIG_OPTION,bottom_show_occle_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_occle}}
								<li><a id="occle_button" accesskey="o" onclick="if (typeof window.load_occle!='undefined') return load_occle(); else return false;" href="{$PAGE_LINK*,adminzone:admin_occle}"><img width="20" height="20" id="occle_img" title="OcCLE" alt="OcCLE" src="{$IMG*,footer/occle}" /></a></li>
							{+END}{+END}{+END}{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_admin_menu}}
								<li>
									<span class="global_footer_button_ref_point" id="management_menu_rel"></span>
									<a accesskey="m" id="management_menu_button" onclick="if (typeof window.load_management_menu!='undefined') return load_management_menu(); else return false;" href="{$PAGE_LINK*,adminzone:admin}"><img width="20" height="20" id="management_menu_img" class="no_theme_img_click" title="{!MENU}" alt="{!MENU}" src="{$IMG*,footer/managementmenu}" /></a>
								</li>
							{+END}
							{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$EQ,{$BRAND_NAME},ocPortal}}
								<li><a id="ocpchat_button" accesskey="-" onclick="if (typeof window.load_ocpchat!='undefined') return load_ocpchat(event); else return false;" href="#"><img width="20" height="20" id="ocpchat_img" title="{!OCP_CHAT}" alt="{!OCP_CHAT}" src="{$IMG*,footer/ocpchat}" /></a></li>
							{+END}{+END}
						{+END}
					{+END}
					{+START,IF_NON_EMPTY,{$TRIM,{$GET,FOOTER_BUTTONS}}}
						<ul class="horizontal_buttons">
							{$GET,FOOTER_BUTTONS}
						</ul>
					{+END}

					{+START,IF,{$HAS_SU}}
						<form title="{!SU_2} {!LINK_NEW_WINDOW}" class="inline su_form" method="get" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" target="_blank">
							<div class="inline">
								{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},keep_su}

								<div class="accessibility_hidden"><label for="su">{!SU}</label></div>
								<input accesskey="w" size="10" onfocus="if (this.value=='{$USERNAME*;}') this.value='';" type="text" value="{$USERNAME*;}" id="su" name="keep_su" />
								{+START,IF,{$NOT,{$JS_ON}}}
									<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SU}" />
								{+END}
							</div>
						</form>
					{+END}

					{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{$STAFF_ACTIONS}}{+START,IF,{$CONFIG_OPTION,ocp_show_staff_page_actions}}
						<form onsubmit="return staff_actions_select(this);" title="{!SCREEN_DEV_TOOLS} {!LINK_NEW_WINDOW}" class="inline special_page_type_form" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get" target="_blank">
							{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1,0,cache_blocks=0,keep_no_xhtml=1,special_page_type=<null>,keep_cache=<null>}}

							<div class="inline">
								<p class="accessibility_hidden"><label for="special_page_type">{!SCREEN_DEV_TOOLS}</label></p>
								<select id="special_page_type" name="special_page_type">
									{$STAFF_ACTIONS}
								</select>
								<input class="button_micro" type="submit" value="{!PROCEED_SHORT}" />
							</div>
						</form>
					{+END}{+END}{+END}
				</div>

				<div class="global_footer_right">
					{+START,IF,{$ADDON_INSTALLED,flagrant}}{+START,IF_NON_EMPTY,{$FLAGRANT}}
						<div class="global_community_message">
							{$FLAGRANT`}
						</div>
					{+END}{+END}

					<div class="global_copyright">
						{$,Uncomment to show user's time {$DATE} {$TIME}}
						{$COPYRIGHT`}
					</div>

					<nav class="global_minilinks" role="navigation">
						<ul class="horizontal_links">
							{+START,IF,{$CONFIG_OPTION,bottom_show_sitemap_button}}
								<li><a accesskey="3" rel="site_map" href="{$PAGE_LINK*,_SEARCH:sitemap}">{!SITE_MAP}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_privacy_link}}
								<li><a rel="site_privacy" accesskey="8" href="{$PAGE_LINK*,:privacy}">{!PRIVACY}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_feedback_link}}
								<li><a rel="site_contact" accesskey="9" href="{$PAGE_LINK*,:feedback}{+START,IF,{$NOT,{$IN_STR,{$PAGE_LINK,:feedback},?}}}?{+END}{+START,IF,{$NOT,{$NOT,{$IN_STR,{$PAGE_LINK,:feedback},?}}}}&amp;{+END}redirect={$SELF_URL*&,1}">{!FEEDBACK}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,mobile_support}}{+START,IF,{$MOBILE,1}}
								<li><a href="{$SELF_URL*,1,0,0,keep_mobile=0}">{!NONMOBILE_VERSION}</a>{+END}
							{+END}
							{+START,IF,{$NOT,{$MOBILE,1}}}
								<li><a href="{$SELF_URL*,1,0,0,keep_mobile=1}">{!MOBILE_VERSION}</a></li>
							{+END}
							{+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}
								<li><form title="{!LOGOUT}" class="inline" method="post" action="{$PAGE_LINK*,:login:logout}"><input class="button_hyperlink" type="submit" title="{!_LOGOUT,{$USERNAME*}}" value="{!LOGOUT}" /></form></li>
							{+END}
							{+START,IF,{$OR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}
								<li><a href="{$PAGE_LINK*,:login:{$?,{$NOR,{$GET,login_screen},{$EQ,{$ZONE}:{$PAGE},:login}},redirect={$SELF_URL*&,1}}}">{!_LOGIN}</a></li>
							{+END}
							{+START,IF_NON_EMPTY,{$HONEYPOT_LINK}}
								<li class="accessibility_hidden">{$HONEYPOT_LINK}</li>
							{+END}
							<li class="accessibility_hidden"><a accesskey="1" href="{$PAGE_LINK*,:}">{$SITE_NAME*}</a></li>
							<li class="accessibility_hidden"><a accesskey="0" href="{$PAGE_LINK*,:keymap}">{!KEYBOARD_MAP}</a></li>
						</ul>

						{+START,IF,{$AND,{$NOT,{$_GET,keep_has_js}},{$JS_ON}}}
							<noscript><a href="{$SELF_URL*,1,0,1}&amp;keep_has_js=0">{!MARK_JAVASCRIPT_DISABLED}</a></noscript>
						{+END}
					</nav>
				</div>
			</footer>
		{+END}

		{$JS_TEMPCODE,footer}
		<script type="text/javascript">// <![CDATA[
			script_load_stuff();

			{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
		//]]></script>

		{$EXTRA_FOOT}
	</div>
</body>
</html>
