<!DOCTYPE html>

<!--
Powered by {$BRAND_NAME*} version {$VERSION_NUMBER*}, (c) ocProducts Ltd
{$BRAND_BASE_URL*}
-->

{$,We deploy as HTML5 but code and validate strictly to XHTML5}
<html lang="{$LANG*}" dir="{!dir}">
<head>
	{+START,INCLUDE,HTML_HEAD}{+END}
</head>

{$,You can use main_website_inner to help you create fixed width designs; never put fixed-width stuff directly on ".website_body" or "body" because it will affects things like the preview or banner frames or popups/overlays}
<body class="website_body zone_running_{$ZONE*} page_running_{$PAGE*}" id="main_website" itemscope="itemscope" itemtype="http://schema.org/WebPage">
	<div id="main_website_inner">
		{+START,IF,{$SHOW_HEADER}}
			<header itemscope="itemscope" itemtype="http://schema.org/WPHeader" role="banner">
				{$,This allows screen-reader users (e.g. blind users) to jump past the panels etc to the main content}
				<a accesskey="s" class="accessibility_hidden" href="#maincontent">{!SKIP_NAVIGATION}</a>

				{$,The banner}
				{+START,IF,{$NOT,{$MOBILE}}}
					{$SET,BANNER,{$BANNER}} {$,This is to avoid evaluating the banner twice}
					{+START,IF_NON_EMPTY,{$GET,BANNER}}
						<div class="global_banner">{$GET,BANNER}</div>
					{+END}
				{+END}

				{$,The main logo}
				<h1 class="logo_outer"><a target="_self" href="{$PAGE_LINK*,:}" rel="home"><img class="logo" src="{$?*,{$MOBILE},{$IMG,logo/standalone_logo},{$LOGO_URL}}"{+START,IF,{$NOT,{$MOBILE}}} width="{$IMG_WIDTH*,{$LOGO_URL}}" height="{$IMG_HEIGHT*,{$LOGO_URL}}"{+END} title="{!HOME}" alt="{$SITE_NAME*}" /></a></h1>

				{$,Main menu}
				<div class="global_navigation">
					{$BLOCK,block=menu,param={$CONFIG_OPTION,header_menu_call_string},type={$?,{$MOBILE},mobile,dropdown}}

					<div class="global_navigation_inner">
						{$,Login form for guests}
						{+START,IF,{$IS_GUEST}}
							<div class="top_form">
								{$BLOCK,block=top_login}
							</div>
						{+END}

						{$,Search box for logged in users [could show to guests, except space is lacking]}
						{+START,IF,{$AND,{$ADDON_INSTALLED,search},{$NOT,{$MOBILE}},{$NOT,{$IS_GUEST}}}}
							<div class="top_form">
								{$BLOCK,block=top_search,failsafe=1}
							</div>
						{+END}

						{+START,IF,{$NOT,{$IS_GUEST}}}
							<div class="top_buttons">
								{$BLOCK,block=top_notifications}

								{$BLOCK,block=top_personal_stats}
							</div>
						{+END}
					</div>
				</div>
			</header>
		{+END}

		{+START,IF,{$NOT,{$MOBILE}}}
			{$,By default the top panel contains the admin menu, community menu, member bar, etc}
			{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,top}}}
				<div id="panel_top">
					{$LOAD_PANEL,top}
				</div>
			{+END}

			{$,ocPortal may show little messages for you as it runs relating to what you are doing or the state the site is in}
			<div class="global_messages" id="global_messages">
				{$MESSAGES_TOP}
			</div>

			{$,The main panels and content; float_surrounder contains the layout into a rendering box so that the footer etc can sit underneath}
			<div class="global_middle_outer float_surrounder">
				{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,left}}}
					<div id="panel_left" class="global_side_panel" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
						<div class="stuck_nav">{$LOAD_PANEL,left}</div>
					</div>
				{+END}

				{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
					<div id="panel_right" class="global_side_panel" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
						{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
							<div class="stuck_nav">{$LOAD_PANEL,right}</div>
						{+END}
					</div>
				{+END}

				<article class="global_middle" role="main">
					{$,Breadcrumbs}
					{+START,IF,{$IN_STR,{$BREADCRUMBS},<a}}{+START,IF,{$SHOW_HEADER}}
						<nav class="global_breadcrumbs breadcrumbs" itemprop="breadcrumb" role="navigation">
							<img class="breadcrumbs_img" src="{$IMG*,1x/breadcrumbs}" srcset="{$IMG*,2x/breadcrumbs} 2x" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
							{$BREADCRUMBS}
						</nav>
					{+END}{+END}

					{$,Associated with the SKIP_NAVIGATION link defined further up}
					<a id="maincontent"></a>

					{$,The main site, whatever 'page' is being loaded}
					{+END}
					{$,Intentional breakup of directive so that output streaming has a top-level stopping point before MIDDLE}
					{+START,IF,{$NOT,{$MOBILE}}}
						{MIDDLE}
					{+END}
					{+START,IF,{$NOT,{$MOBILE}}}
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
			<div class="global_messages" id="global_messages_2">
				{$LATE_MESSAGES}
			</div>
			<script>merge_global_messages();</script>
		{+END}

		{$,This is the main site footer}
		{+START,IF,{$SHOW_FOOTER}}
			<footer class="float_surrounder" itemscope="itemscope" itemtype="http://schema.org/WPFooter" role="contentinfo">
				<div class="global_footer_left">
					{+START,SET,FOOTER_BUTTONS}
						{+START,IF,{$CONFIG_OPTION,bottom_show_top_button}}
							<li><a accesskey="g" href="#">{$?,{$MOBILE},{!_BACK_TO_TOP},<img title="{!BACK_TO_TOP}" alt="{!BACK_TO_TOP}" src="{$IMG*,icons/24x24/tool_buttons/top}" srcset="{$IMG*,icons/48x48/tool_buttons/top} 2x" />}</a></li>
						{+END}
						{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$ADDON_INSTALLED,realtime_rain}}{+START,IF,{$CONFIG_OPTION,bottom_show_realtime_rain_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_realtime_rain}}
							<li><a id="realtime_rain_button" onclick="if (typeof window.load_realtime_rain!='undefined') return load_realtime_rain(); else return false;" href="{$PAGE_LINK*,adminzone:admin_realtime_rain}">{$?,{$MOBILE},{!realtime_rain:REALTIME_RAIN},<img id="realtime_rain_img" title="{!realtime_rain:REALTIME_RAIN}" alt="{!realtime_rain:REALTIME_RAIN}" src="{$IMG*,icons/24x24/tool_buttons/realtime_rain_on}" srcset="{$IMG*,icons/48x48/tool_buttons/realtime_rain_on} 2x" />}</a></li>
						{+END}{+END}{+END}{+END}
						{+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
							{+START,IF,{$ADDON_INSTALLED,occle}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_occle}}{+START,IF,{$CONFIG_OPTION,bottom_show_occle_button}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},adminzone:admin_occle}}
								<li><a id="occle_button" accesskey="o"{+START,IF,{$NOT,{$MOBILE}}} onclick="if (typeof window.load_occle!='undefined') return load_occle(); else return false;"{+END} href="{$PAGE_LINK*,adminzone:admin_occle}">{$?,{$MOBILE},{!occle:OCCLE},<img id="occle_img" title="{!occle:OCCLE_DESCRIPTIVE_TITLE}" alt="{!occle:OCCLE_DESCRIPTIVE_TITLE}" src="{$IMG*,icons/24x24/tool_buttons/occle_on}" srcset="{$IMG*,icons/48x48/tool_buttons/occle_on} 2x" />}</a></li>
							{+END}{+END}{+END}{+END}
							{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$EQ,{$BRAND_NAME},ocPortal}}
								<li><a id="software_chat_button" accesskey="-" onclick="if (typeof window.load_software_chat!='undefined') return load_software_chat(event); else return false;" href="#">{$?,{$MOBILE},{!SOFTWARE_CHAT},<img id="software_chat_img" title="{!SOFTWARE_CHAT}" alt="{!SOFTWARE_CHAT}" src="{$IMG*,icons/24x24/tool_buttons/software_chat}" srcset="{$IMG*,icons/48x48/tool_buttons/software_chat} 2x" />}</a></li>
							{+END}{+END}
						{+END}
					{+END}
					{+START,IF_NON_EMPTY,{$TRIM,{$GET,FOOTER_BUTTONS}}}{+START,IF,{$NOT,{$MOBILE}}}
						<ul class="horizontal_buttons">
							{$GET,FOOTER_BUTTONS}
						</ul>
					{+END}{+END}

					{+START,IF,{$HAS_SU}}
						<form title="{!SU_2} {!LINK_NEW_WINDOW}" class="inline su_form" method="get" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" target="_blank">
							{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},keep_su}

							<div class="inline">
								<div class="accessibility_hidden"><label for="su">{!SU}</label></div>
								<input onkeypress="if (enter_pressed(event)) this.form.submit();" accesskey="w" size="10" onfocus="placeholder_focus(this);" onblur="placeholder_blur(this);" class="field_input_non_filled" type="text" value="{$USERNAME;*}" id="su" name="keep_su" /><input onclick="disable_button_just_clicked(this);" class="menu__site_meta__user_actions__login button_micro" type="submit" value="{!SU}" />
							</div>
						</form>
					{+END}

					{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{$STAFF_ACTIONS}}{+START,IF,{$CONFIG_OPTION,show_staff_page_actions}}
						<form onsubmit="return staff_actions_select(this);" title="{!SCREEN_DEV_TOOLS} {!LINK_NEW_WINDOW}" class="inline special_page_type_form" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get" target="_blank">
							{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1,0,cache_blocks=0,keep_no_xhtml=1,special_page_type=<null>,keep_cache=<null>}}

							<div class="inline">
								<p class="accessibility_hidden"><label for="special_page_type">{!SCREEN_DEV_TOOLS}</label></p>
								<select id="special_page_type" name="special_page_type">{$STAFF_ACTIONS}</select><input class="buttons__proceed button_micro" type="submit" value="{!PROCEED_SHORT}" />
							</div>
						</form>
					{+END}{+END}{+END}
				</div>

				<div class="global_footer_right">
					<div class="global_copyright">
						{$,Uncomment to show user's time {$DATE} {$TIME}}

						{$COPYRIGHT`}

						{+START,IF,{$NOT,{$MOBILE}}}
							{+START,INCLUDE,FONT_SIZER}{+END}
						{+END}
					</div>

					<nav class="global_minilinks" role="navigation">
						<ul class="{+START,IF,{$NOT,{$MOBILE,1}}}horizontal_links {+END}footer_links">
							{+START,IF,{$MOBILE}}
								{$GET,FOOTER_BUTTONS}
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_sitemap_button}}
								<li><a accesskey="3" rel="site_map" href="{$PAGE_LINK*,_SEARCH:sitemap}">{!SITEMAP}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_rules_link}}
								<li><a onclick="return open_link_as_overlay(this);" rel="site_rules" accesskey="7" href="{$PAGE_LINK*,_SEARCH:rules}">{!RULES}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_privacy_link}}
								<li><a onclick="return open_link_as_overlay(this);" rel="site_privacy" accesskey="8" href="{$PAGE_LINK*,_SEARCH:privacy}">{!PRIVACY}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,bottom_show_feedback_link}}
								<li><a onclick="return open_link_as_overlay(this);" rel="site_contact" accesskey="9" href="{$?,{$OR,{$ADDON_INSTALLED,staff_messaging},{$NOT,{$ADDON_INSTALLED,tickets}}},{$PAGE_LINK*,_SEARCH:feedback:redirect={$SELF_URL&,1}},{$PAGE_LINK*,_SEARCH:tickets}}">{!_FEEDBACK}</a></li>
							{+END}
							{+START,IF,{$NOR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}
								<li><form title="{!LOGOUT}" class="inline" method="post" action="{$PAGE_LINK*,_SELF:login:logout}"><input class="button_hyperlink" type="submit" title="{!_LOGOUT,{$USERNAME*}}" value="{!LOGOUT}" /></form></li>
							{+END}
							{+START,IF,{$OR,{$IS_HTTPAUTH_LOGIN},{$IS_GUEST}}}
								<li><a onclick="return open_link_as_overlay(this);" href="{$PAGE_LINK*,_SELF:login:{$?,{$NOR,{$GET,login_screen},{$EQ,{$PAGE},login}},redirect={$SELF_URL&*,1}}}">{!_LOGIN}</a></li>
							{+END}
							{+START,IF,{$CONFIG_OPTION,mobile_support}}
								{+START,IF,{$MOBILE,1}}
									<li><a href="{$SELF_URL*,1,0,0,keep_mobile=0}">{!NONMOBILE_VERSION}</a>
								{+END}
								{+START,IF,{$NOT,{$MOBILE,1}}}
									<li><a href="{$SELF_URL*,1,0,0,keep_mobile=1}">{!MOBILE_VERSION}</a></li>
								{+END}
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

		{$EXTRA_FOOT}

		{$JS_TEMPCODE,footer}
		<script>// <![CDATA[
			script_load_stuff();

			{+START,IF,{$EQ,{$_GET,wide_print},1}}try { window.print(); } catch (e) {};{+END}
		//]]></script>
	</div>
</body>
</html>
