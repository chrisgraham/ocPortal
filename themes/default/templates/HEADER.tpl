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
<body class="website_body" id="main_website" itemscope="itemscope" itemtype="http://schema.org/WebPage">
	<div id="main_website_inner">
		{$,This is the main site header; if you like your layout in one place you can move it to GLOBAL.tpl}
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
								<input type="search" id="search_content" name="search_content" style="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},,color: gray}" onblur="if (this.value=='') { this.value='{!ADMINZONE_SEARCH;}'; this.style.color='gray'; }" onkeyup="if (typeof update_ajax_admin_search_list!='undefined') update_ajax_admin_search_list(this,event);" onfocus="require_javascript('javascript_ajax_people_lists'); require_javascript('javascript_ajax'); if (this.value=='{!ADMINZONE_SEARCH;}') this.value=''; this.style.color='black';" value="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},{$_GET*,search_content},{!ADMINZONE_SEARCH}}" title="{!ADMIN_ZONE_SEARCH_SYNTAX}" />
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
