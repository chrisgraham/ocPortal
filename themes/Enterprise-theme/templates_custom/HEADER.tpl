{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">{+END}
{+START,IF,{$VALUE_OPTION,html5}}<!DOCTYPE html>{+END}

<!--
Powered by {$BRAND_NAME*}
{VERSION_NUMBER*} version
Copyright ocProducts Limited
{$BRAND_BASE_URL*}
-->

<html id="main_website_html" xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="{$LANG*}" lang="{$LANG*}" dir="{!dir}">
<head{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} profile="http://www.w3.org/2003/g/data-view http://dublincore.org/documents/dcq-html/ http://gmpg.org/xfn/11 http://www.w3.org/2006/03/hcard http://microformats.org/profile/hcalendar"{+END}>
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
		<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
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
	{$SET,panel_left,{$SET,in_panel,1}{$SET,interlock,0}{$LOAD_PANEL,left}{$SET,interlock,0}{$SET,in_panel,0}}
	{$SET,panel_right,{$SET,in_panel,1}{$SET,interlock,0}{$LOAD_PANEL,right}{$SET,interlock,0}{$SET,in_panel,0}}

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
			_gaq.push(['_setAccount','{$TRIM,{$CONFIG_OPTION;*,google_analytics}}']);
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

<body class="re_body" id="main_website"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/WebPage"}>
	<div id="container">
		{+START,IF,{SHOW_TOP}}
			<div id="logo">
				<h1><a href="{$PAGE_LINK*,:start}">{$SITE_NAME*}</a></h1> <h4>{$HEADER_TEXT*}</h4>
			</div>
	
			{$BLOCK,block=side_stored_menu,param=main_features,type=zone}

			<div class="search"><div class="sea">{$BLOCK,block=main_search}</div></div>

			{$BLOCK,block=side_stored_menu,param=main_content,type=top}
		{+END}
