{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">{+END}
{+START,IF,{$VALUE_OPTION,html5}}<!DOCTYPE html>{+END}

<!--
Powered by {$BRAND_NAME*}
{VERSION_NUMBER*} version
Copyright ocProducts Limited
{$BRAND_BASE_URL*}
-->

<html id="main_website_html" xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="{$LANG*}" lang="{$LANG*}" dir="{!dir}">
<head{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} profile="http://www.w3.org/2003/g/data-view http://dublincore.org/documents/dcq-html/ http://gmpg.org/xfn/11 http://www.w3.org/2006/03/hcard"{+END}>
	{$,The character set of the page}
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={CHARSET}" />

	{$,We make use of Internet Explorer's ability to say what version the site has been tested against, so that future IE upgrades cannot kill the site before it is fixed}
	{+START,IF,{$NOT,{$GET,chrome_frame}}}<meta http-equiv="X-UA-Compatible" content="IE=9" />{+END}

	{$,Pages may recommend using Chrome Frame, if the page uses advanced markup IE cannot understand}
	{+START,IF,{$GET,chrome_frame}}<meta http-equiv="X-UA-Compatible" content="chrome=1" />{+END}

	{$,Meta data for the page: standard meta data, Dublin Core meta data, and ocPortal meta data extensions}
	<title>{+START,IF_NON_EMPTY,{HEADER_TEXT}}{HEADER_TEXT*} &ndash; {+END}{$SITE_NAME*}</title>
	<meta name="description" content="{+START,IF,{$NEQ,{DESCRIPTION},{!NA}}}{DESCRIPTION*}{+END}" />
	<meta name="keywords" content="{KEYWORDS*}" />
	<meta name="copyright" content="{$COPYRIGHT`}" />
	<meta name="author" content="{$SITE_NAME*}" />
	{+START,IF,{$MOBILE}}
		<meta name="viewport" content="width=320;" />
	{+END}
	<link rel="canonical" href="{SELF_URL*}" />
	<link rel="baseurl" href="{$BASE_URL*}" />
	<link rel="schema.OCPCORE" href="http://ocportal.com/ocpcore.rdf" />{+START,IF_NON_EMPTY,{$META_DATA,rating}}<meta name="OCPCORE.Rating" content="{$META_DATA*,rating}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,numcomments}}<meta name="OCPCORE.NumComments" content="{$META_DATA*,numcomments}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,site_newestmember}}<meta name="OCPCORE.Site_NewestMember" content="{$META_DATA*,site_newestmember}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,site_nummembers}}<meta name="OCPCORE.Site_NumMembers" content="{$META_DATA*,site_nummembers}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,site_bestmember}}<meta name="OCPCORE.Site_BestMember" content="{$META_DATA*,site_bestmember}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,forum_numtopics}}<meta name="OCPCORE.Forum_NumTopics" content="{$META_DATA*,forum_numtopics}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,forum_numposts}}<meta name="OCPCORE.Forum_NumPosts" content="{$META_DATA*,forum_numposts}" />{+END}
	<link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" /><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" /><meta name="DC.Language" content="{$LANG*}" />{+START,IF_NON_EMPTY,{$META_DATA,created}}<meta name="DCTERMS.Created" content="{$META_DATA*,created}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,publisher}}<meta name="DC.Publisher" content="{$META_DATA*,publisher}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,created}}<meta name="DC.Creator" content="{$META_DATA*,creator}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,modified}}<meta name="DCTERMS.Modified" content="{$META_DATA*,modified}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,type}}<meta name="DC.Type" content="{$META_DATA*,type}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,title}}<meta name="DC.Title" content="{$META_DATA*,title}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,identifier}}<meta name="DC.Identifier" content="{$FIND_SCRIPT*,pagelink_redirect}?id={$META_DATA*&,identifier}" />{+END}{+START,IF_NON_EMPTY,{$META_DATA,description}}<meta name="DC.Description" content="{$META_DATA*,description}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,title}}<meta property="og:title" content="{$META_DATA*,title}"/>{+END}{+START,IF_NON_EMPTY,{$META_DATA,type}}<meta property="og:type" content="{$REPLACE*, ,_,{$LCASE,{$META_DATA,type}}}"/>{+END}<meta property="og:url" content="{SELF_URL*}"/><meta property="og:site_name" content="{$SITE_NAME*}"/>{+START,IF_NON_EMPTY,{$CONFIG_OPTION*,facebook_uid}}<meta property="fb:admins" content="{$CONFIG_OPTION*,facebook_uid}"/>{+END}{+START,IF_NON_EMPTY,{$META_DATA,description}}<meta property="og:description" content="{$META_DATA*,description}"/>{+END}{+START,IF_NON_EMPTY,{$META_DATA,image}}<meta property="og:image" content="{$META_DATA*,image}"/>{+END}{+START,IF_EMPTY,{$META_DATA,image}}<meta property="og:image" content="{$IMG*,logo/trimmed-logo}"/>{+END}{+START,IF_NON_EMPTY,{$META_DATA,video}}<meta property="og:video" content="{$META_DATA*,video}" /><meta property="og:video:height" content="{$META_DATA*,video:height}" /><meta property="og:video:width" content="{$META_DATA*,video:width}" /><meta property="og:video:type" content="{$META_DATA*,video:type}" />{+END}
	{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<meta name="language" content="{$LANG*}" />{+END}

	{$,What technologies the page is using}
	{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
	{+END}
	<meta name="GENERATOR" content="{$BRAND_NAME*}" />

	{$,If the page is doing a refresh include the markup for that}
	{REFRESH}
	
	{$,In developer mode we totally break relative URLs so we know if they're used - we shouldn't ever use them, as they reflect path assumptions}
	{+START,IF,{$DEV_MODE}}<base href="http://example.com/" />{+END}

	{$,Favicon and iOS icon for site, managed as theme images}
	<link rel="icon" href="{$IMG*,appleicon}" /> {$,Used on Opera speed dial}
	<link rel="apple-touch-icon" href="{$IMG*,appleicon}" />
	<link rel="shortcut icon" href="{$IMG*,favicon}" type="image/x-icon" />

	{$,Inclusion of help semantic data, so smart browsers can provide native links to it}
	{+START,IF,{$HAS_SPECIFIC_PERMISSION,see_software_docs}}{+START,IF_NON_EMPTY,{$DOCUMENT_HELP}}<link rel="help" href="{$DOCUMENT_HELP*}" />{+END}{+END}

	{$,Inclusion of search semantic data, so smart browsers can automatically allow native-browser searching of the site}
	{+START,IF,{$ADDON_INSTALLED,search}}
		{+START,IF,{$EQ,{$ZONE},docs}}
			<link rel="search" type="application/opensearchdescription+xml" title="{$SITE_NAME*} {$ZONE*}" href="{$FIND_SCRIPT*,opensearch}?filter=:id=comcode_pages:search_under=docs" />
		{+END}
		{+START,IF,{$NEQ,{$ZONE},docs}}
			<link rel="search" type="application/opensearchdescription+xml" title="{$SITE_NAME*} {$ZONE*}" href="{$FIND_SCRIPT*,opensearch}?filter=" />
		{+END}
		{+START,IF_NON_EMPTY,{$META_DATA,opensearch_totalresults}}<meta name="totalResults" content="{$META_DATA*,opensearch_totalresults}" />{+END}
		{+START,IF_NON_EMPTY,{$META_DATA,opensearch_startindex}}<meta name="startIndex" content="{$META_DATA*,opensearch_startindex}" />{+END}
		{+START,IF_NON_EMPTY,{$META_DATA,opensearch_itemsperpage}}<meta name="itemsPerPage" content="{$META_DATA*,opensearch_itemsperpage}" />{+END}
	{+END}

	{$,Preload all the panels so that the CSS and JS is known for them. Technically not needed (pre-processing would get it) but this also increases the efficiency.}
	{$SET,panel_top,{$LOAD_PANEL,top}}
	{$SET,panel_bottom,{$LOAD_PANEL,bottom}}
	{$SET,panel_left,{$SET,in_panel,_true}{$SET,interlock,_false}{$LOAD_PANEL,left}{$SET,interlock,_false}{$SET,in_panel,_false}}
	{$SET,panel_right,{$SET,in_panel,_true}{$SET,interlock,_false}{$LOAD_PANEL,right}{$SET,interlock,_false}{$SET,in_panel,_false}}

	{$,Detecting of Timezones and Javascript support}
	<script type="text/javascript">// <![CDATA[
		{+START,IF,{$CONFIG_OPTION,detect_javascript}}
			{+START,IF,{$AND,{$EQ,,{$_GET,keep_has_js}},{$NOT,{$JS_ON}}}}
				if ((window.location.href.indexOf('upgrader.php')==-1) && (window.location.href.indexOf('webdav.php')==-1) && (window.location.search.indexOf('keep_has_js')==-1)) {$,Redirect with JS on, and then hopefully we can remove keep_has_js after one click. This code only happens if JS is marked off, no infinite loops can happen.}
					window.location=window.location.href+((window.location.search=='')?(((window.location.href.indexOf('.htm')==-1)&&(window.location.href.indexOf('.php')==-1))?(((window.location.href.substr(window.location.href.length-1)!='/')?'/':'')+'index.php?'):'?'):'&')+'keep_has_js=1{+START,IF,{$DEV_MODE}}&keep_devtest=1{+END}';
			{+END}
		{+END}
		{+START,IF,{$NOT,{$BROWSER_MATCHES,ie}}}{+START,IF,{$HAS_SPECIFIC_PERMISSION,sees_javascript_error_alerts}}window.take_errors=true;{+END}{+END}
		var {+START,IF,{$CONFIG_OPTION,is_on_timezone_detection}}server_timestamp={$FROM_TIMESTAMP%},{+END}ocp_lang='{$LANG;}',ocp_theme='{$THEME;}',ocp_username='{$USERNAME;}';
	//]]></script>

	{$,CSS includes from ocPortal page}
	{$CSS_TEMPCODE}

	{$,Javascript code (usually) from ocPortal page}
	{$EXTRA_HEAD}

	{$,Javascript includes from ocPortal page}
	{$JS_TEMPCODE,header}
	{+START,IF,{$VALUE_OPTION,html5}}
		<!--[if lt IE 9]>
		<script src="{$BASE_URL*}/data/html5.js"></script>
		<![endif]-->
	{+END}

	{$,Google Analytics account, if one set up}
	{+START,IF_NON_EMPTY,{$CONFIG_OPTION,google_analytics}}{+START,IF,{$NOR,{$IS_STAFF},{$IS_SUPER_ADMIN}}}
		<script type="text/javascript">
			var _gaq=_gaq || [];
			_gaq.push(['_setAccount','{$CONFIG_OPTION;*,google_analytics}']);
			_gaq.push(['_trackPageview']);
			{+START,IF,{$NOT,{$CONFIG_OPTION,long_google_cookies}}}
				_gaq.push(['_setVisitorCookieTimeout', 0]);
				_gaq.push(['_setSessionCookieTimeout', 0]);
				_gaq.push(['_setCampaignCookieTimeout', 0]);
			{+END}

			(function() {
				var ga=document.createElement('script'); ga.type='text/javascript'; ga.async=true;
				ga.src=('https:'==document.location.protocol?'https://ssl':'http://www')+'.google-analytics.com/ga.js';
				var s=document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga,s);
			})();
		</script>
	{+END}{+END}
</head>

{$,You can use body_inner to help you create fixed width designs; never put fixed-width stuff directory on ".re_body" or "body" because it will affects things like the preview or banner frames or popups}
<body class="re_body" id="main_website"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/WebPage"}><div id="body_inner">

{+START,IF,{SHOW_TOP}}
	<{$?,{$VALUE_OPTION,html5},header,div} class="global_top float_surrounder"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/WPHeader"}>
		<h1><a class="logo_outer" target="_self" href="{$PAGE_LINK*,:}" rel="home"><img class="logo" src="{$?,{$MOBILE},{$IMG*,logo/trimmed-logo},{LOGOURL*}}" title="{!FRONT_PAGE}" alt="{$SITE_NAME*}" /></a></h1>

		<a accesskey="s" class="accessibility_hidden">{!SKIP_NAVIGATION}</a>

		{$,Zone menu}
		<div id="global_zones">
			{+START,IF,{$CONFIG_OPTION,use_custom_zone_menu}}
				{$BLOCK,block=side_stored_menu,param=zone_menu,type=zone}
			{+END}
			{+START,IF,{$NOT,{$CONFIG_OPTION,use_custom_zone_menu}}}
				{$BLOCK,block=side_stored_menu,param=_zone_menu,type=zone}
			{+END}
		</div>
		
		{$,Admin Zone options}
		{+START,IF,{$AND,{$HAS_ACTUAL_PAGE_ACCESS,admin,adminzone},{$OR,{$EQ,{$ZONE},adminzone},{$EQ,{$ZONE},cms}}}}
			<div class="adminzone_search">
				<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,adminzone:admin:search}}" method="get" class="inline">
					{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,adminzone:admin:search}}

					<div>
						<label for="search_content">{!ADMINZONE_SEARCH_LOST}</label> <span class="arr">&rarr;</span>
						<input type="text" id="search_content" name="search_content" style="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},,color: gray}" onblur="if (this.value=='') { this.value='{!ADMINZONE_SEARCH;}'; this.style.color='gray'; }" onkeyup="if (typeof update_ajax_admin_search_list!='undefined') update_ajax_admin_search_list(this,event);" onfocus="require_javascript('javascript_ajax_people_lists'); require_javascript('javascript_ajax'); if (this.value=='{!ADMINZONE_SEARCH;}') this.value=''; this.style.color='black';" value="{$?,{$MATCH_KEY_MATCH,adminzone:admin:search},{$_GET*,search_content},{!ADMINZONE_SEARCH}}" title="{!ADMIN_ZONE_SEARCH_SYNTAX}" />
						{+START,IF,{$JS_ON}}
						<div class="accessibility_hidden"><label for="new_window">{!NEW_WINDOW}</label></div>
						<input title="{!NEW_WINDOW}" type="checkbox" value="1" id="new_window" name="new_window" />
						{+END}
						<input onclick="if ((form.new_window) &amp;&amp; (form.new_window.checked)) form.target='_blank'; else form.target='_top';" id="search_button" class="button_micro" type="image" src="{$IMG*,admin-search}" alt="{!SEARCH}" value="{!SEARCH}" />
					</div>
				</form>
			</div>

			{$,Various animations in Admin Zone}
			{+START,IF,{$NOT,{$VALUE_OPTION,disable_animations}}}
				<script type="text/javascript">// <![CDATA[
					if ((window.location+'').indexOf('js_cache=1')==-1) addEventListenerAbstract(window,'beforeunload',function() { staff_unload_action(); } );
					var sb=document.getElementById('search_button');
					setOpacity(sb,0.6);
					sb.onmouseover=function() { setOpacity(sb,1.0); };
					sb.onmouseout=function() { setOpacity(sb,0.6); };
				//]]></script>
			{+END}
		{+END}
		
		{$,Out side Admin Zone we have the banner}
		{+START,IF,{$NOT,{$OR,{$EQ,{$ZONE},adminzone},{$AND,{$HAS_ZONE_ACCESS,adminzone},{$EQ,{$ZONE},cms}}}}}{+START,IF,{$NOT,{$MOBILE}}}
			{$SET,BANNER,{$BANNER}} {$,This is to avoid evaluating the banner parameter twice}
			{+START,IF_NON_EMPTY,{$GET,BANNER}}
				<div class="global_banner" style="text-align: {!en_right}">{$GET,BANNER}</div>
			{+END}
		{+END}{+END}
	</{$?,{$VALUE_OPTION,html5},header,div}>
{+END}
