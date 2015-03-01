<!DOCTYPE html>

<!--
Powered by {$BRAND_NAME*} version {$VERSION_NUMBER*}, (c) ocProducts Ltd
{$BRAND_BASE_URL*}
-->

{$,We deploy as HTML5 but code and validate strictly to XHTML5}
<html lang="{$LCASE*,{$LANG}}" dir="{!dir}">
<head>
	{+START,INCLUDE,HTML_HEAD}{+END}
</head>

{$,You can use main_website_inner to help you create fixed width designs; never put fixed-width stuff directly on ".website_body" or "body" because it will affects things like the preview or banner frames or popups/overlays}
<body class="website_body zone_running_{$ZONE*} page_running_{$PAGE*}" id="main_website" itemscope="itemscope" itemtype="http://schema.org/WebPage">
	<div id="main_website_inner">
		{$,This is the main site header}
		{+START,IF,{$SHOW_HEADER}}
			<header class="float_surrounder" itemscope="itemscope" itemtype="http://schema.org/WPHeader">
				{$,The main logo}
				<h1><a class="logo_outer" target="_self" href="{$PAGE_LINK*,:}" rel="home"><img class="logo" src="{$?,{$MOBILE},{$IMG*,logo/trimmed_logo},{$LOGO_URL*}}" width="{$IMG_WIDTH*,{$?,{$MOBILE},{$IMG,logo/trimmed_logo},{$LOGO_URL}}}" height="{$IMG_HEIGHT*,{$?,{$MOBILE},{$IMG,logo/trimmed_logo},{$LOGO_URL}}}" title="{!FRONT_PAGE}" alt="{$SITE_NAME*}" /></a></h1>

				{$,This allows screen-reader users (e.g. blind users) to jump past the panels etc to the main content}
				<a accesskey="s" class="accessibility_hidden" href="#maincontent">{!SKIP_NAVIGATION}</a>

				{$,Main menu}
				<div class="global_navigation">
					{$BLOCK,block=side_stored_menu,param=zone_menu,type=zone}
				</div>

				{$,Outside the Admin Zone we have a spot for the banner}
				{+START,IF,{$NAND,{$HAS_ACTUAL_PAGE_ACCESS,admin,adminzone},{$EQ,{$ZONE},adminzone,cms}}}{+START,IF,{$NOT,{$MOBILE}}}
					{$SET,BANNER,{$BANNER}} {$,This is to avoid evaluating the banner parameter twice}
					{+START,IF_NON_EMPTY,{$GET,BANNER}}
						<div class="global_banner" style="text-align: {!en_right}">{$GET,BANNER}</div>
					{+END}
				{+END}{+END}

				{$,Inside the Admin Zone we have the Admin Zone search}
				{+START,IF,{$AND,{$HAS_ACTUAL_PAGE_ACCESS,admin,adminzone},{$EQ,{$ZONE},adminzone,cms}}}
					<div class="adminzone_search">
						<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,adminzone:admin:search}}" method="get" class="inline">
							{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,adminzone:admin:search}}

							<div>
								<label for="search_content">{!ADMINZONE_SEARCH_LOST}</label> <span class="arr">&rarr;</span>
								<input size="25" type="search" id="search_content" name="search_content" style="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},,color: gray}" onblur="if (this.value=='') { this.value='{!ADMINZONE_SEARCH;}'; this.style.color='gray'; }" onkeyup="if (typeof update_ajax_admin_search_list!='undefined') update_ajax_admin_search_list(this,event);" onfocus="require_javascript('javascript_ajax_people_lists'); require_javascript('javascript_ajax'); if (this.value=='{!ADMINZONE_SEARCH;}') this.value=''; this.style.color='black';" value="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},{$_GET*,search_content},{!ADMINZONE_SEARCH}}" title="{!ADMIN_ZONE_SEARCH_SYNTAX}" />
								{+START,IF,{$JS_ON}}
									<div class="accessibility_hidden"><label for="new_window">{!NEW_WINDOW}</label></div>
									<input title="{!NEW_WINDOW}" type="checkbox" value="1" id="new_window" name="new_window" />
								{+END}
								<input onclick="if ((form.new_window) &amp;&amp; (form.new_window.checked)) form.target='_blank'; else form.target='_top';" id="search_button" class="button_micro" type="image" src="{$IMG*,admin_search}" alt="{!SEARCH}" value="{!SEARCH}" />
							</div>
						</form>
					</div>
				{+END}
			</header>
		{+END}

		{$,Make sure the system knows we have not rendered our primary title for this output yet}
		{$SET,done_first_title,0}

		{+START,IF,{$NOT,{$MOBILE}}}
			{$,By default the top panel contains the admin menu, community menu, member bar, etc}
			{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,top}}}
				<div id="panel_top">
					{$LOAD_PANEL,top}
				</div>
			{+END}

			{$,ocPortal may show little messages for you as it runs relating to what you are doing or the state the site is in}
			{+START,IF_NON_EMPTY,{$MESSAGES_TOP}}
				<div class="global_messages">
					{$MESSAGES_TOP}
				</div>
			{+END}

			{$,The main panels and content; float_surrounder contains the layout into a rendering box so that the footer etc can sit underneath}
			<div class="global_middle_outer float_surrounder">
				{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,left}}}
					<div id="panel_left" class="global_side_panel" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
						<div class="stuck_nav">{$LOAD_PANEL,left}</div>
					</div>
				{+END}

				{$,Deciding whether/how to show the right panel requires some complex logic}
				{$SET,HELPER_PANEL_TUTORIAL,{$?,{$HAS_PRIVILEGE,see_software_docs},{$HELPER_PANEL_TUTORIAL}}}
				{$SET,helper_panel,{$OR,{$IS_NON_EMPTY,{$GET,HELPER_PANEL_TUTORIAL}},{$IS_NON_EMPTY,{$HELPER_PANEL_PIC}},{$IS_NON_EMPTY,{$HELPER_PANEL_HTML}},{$IS_NON_EMPTY,{$HELPER_PANEL_TEXT}}}}
				{+START,IF,{$OR,{$GET,helper_panel},{$IS_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}}}
					<div id="panel_right" class="global_side_panel{+START,IF_EMPTY,{$TRIM,{$LOAD_PANEL,right}}} helper_panel{+START,IF,{$HIDE_HELP_PANEL}} helper_panel_hidden{+END}{+END}" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
						{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
							{$LOAD_PANEL,right}
						{+END}

						{+START,IF_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
							{+START,INCLUDE,GLOBAL_HELPER_PANEL}{+END}
						{+END}
					</div>
				{+END}

				<article class="global_middle">
					{$,Breadcrumbs}
					{+START,IF,{$IN_STR,{$BREADCRUMBS},<a}}{+START,IF,{$SHOW_HEADER}}
						<nav class="global_breadcrumbs breadcrumbs" itemprop="breadcrumb" role="navigation">
							<img class="breadcrumbs_img" src="{$IMG*,breadcrumbs}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
							{$BREADCRUMBS}
						</nav>
					{+END}{+END}

					{$,Associated with the SKIP_NAVIGATION link defined further up}
					<a id="maincontent"></a>

					{$,The main site, whatever 'page' is being loaded}
					{MIDDLE}
				</article>
			</div>

			{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,bottom}}}
				<div id="panel_bottom" role="complementary">
					{$LOAD_PANEL,bottom}
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{$MESSAGES_BOTTOM}}
				<div class="global_messages">
					{$MESSAGES_BOTTOM}
				</div>
			{+END}
		{+END}

		{+START,IF,{$MOBILE}}
			{+START,INCLUDE,GLOBAL_HTML_WRAP_mobile}{+END}
		{+END}

		{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}

		{$,Late messages happen if something went wrong during outputting everything (i.e. too late in the process to show the error in the normal place)}
		{+START,IF_NON_EMPTY,{$LATE_MESSAGES}}
			<div class="global_messages">
				{$LATE_MESSAGES}
			</div>

			{+START,IF,{$DEV_MODE}}
				<script type="text/javascript">// <![CDATA[
					try { window.scrollTo(0,1000000); } catch (e) {};
					window.fauxmodal_alert('{!PLEASE_REVIEW_ERRORS_AT_BOTTOM;/}'); // Before Firefox dies with an XHTML error, let the developer see what is wrong
				//]]></script>
			{+END}
		{+END}

		{$,This is the main site footer}
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
								<a accesskey="n" id="bookmarks_menu_button" onclick="if (typeof window.load_management_menu=='undefined') { require_javascript('javascript_staff'); window.setTimeout(document.getElementById('bookmarks_menu_button').onclick,10); return false; } else return load_management_menu('bookmarks',true);" href="{$PAGE_LINK*,_SEARCH:bookmarks}&amp;url={$SELF_URL&*}"><img width="20" height="20" id="bookmarks_menu_img" class="no_theme_img_click" title="{!BOOKMARKS}" alt="{!BOOKMARKS}" src="{$IMG*,footer/bookmarksmenu}" /></a>
							</li>
						{+END}{+END}
						{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$ADDON_INSTALLED,realtime_rain}}{+START,IF,{$CONFIG_OPTION,bottom_show_realtime_rain_button}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_realtime_rain}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_realtime_rain}}
							<li><a id="realtime_rain_button" onclick="if (typeof window.load_realtime_rain!='undefined') return load_realtime_rain(); else return false;" href="{$PAGE_LINK*,adminzone:admin_realtime_rain}"><img width="20" height="20" id="realtime_rain_img" title="{!realtime_rain:REALTIME_RAIN}" alt="{!realtime_rain:REALTIME_RAIN}" src="{$IMG*,footer/realtime_rain}" /></a></li>
						{+END}{+END}{+END}{+END}{+END}
						{+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
							{+START,IF,{$ADDON_INSTALLED,occle}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_occle}}{+START,IF,{$CONFIG_OPTION,bottom_show_occle_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_occle}}
								<li><a id="occle_button" accesskey="o" onclick="if (typeof window.load_occle!='undefined') return load_occle(); else return false;" href="{$PAGE_LINK*,adminzone:admin_occle}"><img width="20" height="20" id="occle_img" title="{!occle:OCCLE_DESCRIPTIVE_TITLE}" alt="{!occle:OCCLE_DESCRIPTIVE_TITLE}" src="{$IMG*,footer/occle}" /></a></li>
							{+END}{+END}{+END}{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_admin_menu}}
								<li>
									<span class="global_footer_button_ref_point" id="management_menu_rel"></span>
									<a accesskey="m" id="management_menu_button" onclick="if (typeof window.load_management_menu!='undefined') return load_management_menu(); else return false;" href="{$PAGE_LINK*,adminzone:admin}"><img width="20" height="20" id="management_menu_img" class="no_theme_img_click" title="{!_ADMIN_MENU}" alt="{!MENU}" src="{$IMG*,footer/managementmenu}" /></a>
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
								<input onkeypress="if (enter_pressed(event)) this.form.submit();" accesskey="w" size="10" onfocus="if (this.value=='{$USERNAME*;}') this.value='';" type="text" value="{$USERNAME*;}" id="su" name="keep_su" />
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
						{$,Uncomment to show user"s time {$DATE} {$TIME}}
						{$COPYRIGHT`}

						{+START,INCLUDE,FONT_SIZER}{+END}
					</div>

					<nav class="global_minilinks" role="navigation">
						<ul class="horizontal_links">
							{+START,IF,{$CONFIG_OPTION,bottom_show_sitemap_button}}
								<li><a accesskey="3" rel="site_map" href="{$PAGE_LINK*,_SEARCH:sitemap}">{!SITE_MAP}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_rules_link}}
								<li><a rel="site_rules" accesskey="7" href="{$PAGE_LINK*,_SEARCH:rules}">{!RULES}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_privacy_link}}
								<li><a rel="site_privacy" accesskey="8" href="{$PAGE_LINK*,_SEARCH:privacy}">{!PRIVACY}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_feedback_link}}
								<li><a rel="site_contact" accesskey="9" href="{$PAGE_LINK*,_SEARCH:feedback}{+START,IF,{$NOT,{$IN_STR,{$PAGE_LINK,:feedback},?}}}?{+END}{+START,IF,{$NOT,{$NOT,{$IN_STR,{$PAGE_LINK,:feedback},?}}}}&amp;{+END}redirect={$SELF_URL&*,1}">{!_FEEDBACK}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,mobile_support}}
								{+START,IF,{$MOBILE,1}}
									<li><a href="{$SELF_URL*,1,0,0,keep_mobile=0}">{!NONMOBILE_VERSION}</a>
								{+END}
								{+START,IF,{$NOT,{$MOBILE,1}}}
									<li><a href="{$SELF_URL*,1,0,0,keep_mobile=1}">{!MOBILE_VERSION}</a></li>
								{+END}
							{+END}
							{+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}
								<li><form title="{!LOGOUT}" class="inline" method="post" action="{$PAGE_LINK*,:login:logout}"><input class="button_hyperlink" type="submit" title="{!_LOGOUT,{$USERNAME*}}" value="{!LOGOUT}" /></form></li>
							{+END}
							{+START,IF,{$OR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}
								<li><a href="{$PAGE_LINK*,:login{$?,{$NOR,{$GET,login_screen},{$_POSTED},{$EQ,{$ZONE}:{$PAGE},:login,:join}},:redirect={$SELF_URL&*,1}}}">{!_LOGIN}</a></li>
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
