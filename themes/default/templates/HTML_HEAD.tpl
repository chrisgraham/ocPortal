{$,Want a nice Google font? Try uncommenting the below}
{$,<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" type="text/css" />}

{$,The character set of the page}
<meta http-equiv="Content-Type" content="text/html; charset={$CHARSET*}" />

{$,Force IE to not use compatiblity mode}
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

{$,Page title}
<title>{+START,IF_NON_PASSED,TITLE}{+START,IF_NON_EMPTY,{$HEADER_TEXT}}{$HEADER_TEXT*} &ndash; {+END}{$SITE_NAME*}{+END}{+START,IF_PASSED,TITLE}{TITLE}{+END}</title>

{$,In developer mode we totally break relative URLs so we know if they're used - we shouldn't ever use them, as they reflect path assumptions}
{+START,IF,{$NOT,{$DEV_MODE}}}{+START,IF_PASSED,TARGET}<base href="{$BASE_URL*}/{$ZONE*}" target="{TARGET}" />{+END}{+END}
{+START,IF,{$DEV_MODE}}<base href="http://example.com/"{+START,IF_PASSED,TARGET} target="{TARGET}"{+END} />{+END}

{$,Hints to Google etc that may be set by ocPortal code}
{+START,IF_PASSED_AND_TRUE,NOFOLLOW}
	<meta name="robots" content="noindex, nofollow" />
{+END}

{$,iPhone/Android/etc should know they have an optimised design heading to them}
{+START,IF,{$MOBILE}}
	{+START,IF,{$NOT,{$_GET,overlay}}}
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	{+END}
	{+START,IF,{$_GET,overlay}}
		<meta name="viewport" content="width=280, initial-scale=1, user-scalable=yes" />
	{+END}
{+END}
{+START,IF,{$NOT,{$MOBILE}}}
	{+START,IF,{$CONFIG_OPTION,fixed_width}}
		<meta name="viewport" content="width=982, user-scalable=yes" />
	{+END}
	{+START,IF,{$NOT,{$CONFIG_OPTION,fixed_width}}}
		<meta name="viewport" content="width=device-width, user-scalable=yes" />
	{+END}
{+END}

{$,Meta data for the page: standard meta data, Dublin Core meta data, Facebook Open Graph, and ocPortal meta data extensions [OCPCORE]}
{+START,IF,{$NEQ,{$PAGE},404}}<link rel="canonical" href="{$CANONICAL_URL*}" />{+END}
<link rel="baseurl" href="{$BASE_URL*}" />
<link rel="sitemap" href="{$BASE_URL*}/ocp_sitemap.xml" />
<meta name="description" content="{+START,IF,{$NEQ,{$META_DATA,meta_description},{!NA},???}}{$META_DATA*,meta_description}{+END}" />
<meta name="keywords" content="{$META_DATA*,keywords}" />
{+START,SET,Commented out by default to save bandwidth}
	<meta name="GENERATOR" content="{$BRAND_NAME*}" />
	<meta name="publisher" content="{$COPYRIGHT`}" />
	<meta name="author" content="{$SITE_NAME*}" />
{+END}
{+START,SET,Commented out by default to save bandwidth - schema.org and HTML5 semantics is probably the best default approach for most sites}
	<link rel="schema.OCPCORE" href="http://ocportal.com/ocpcore.rdf" />
	{+START,IF_NON_EMPTY,{$META_DATA,rating}}<meta name="OCPCORE.Rating" content="{$META_DATA*,rating}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,numcomments}}<meta name="OCPCORE.NumComments" content="{$META_DATA*,numcomments}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,site_newestmember}}<meta name="OCPCORE.Site_NewestMember" content="{$META_DATA*,site_newestmember}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,site_nummembers}}<meta name="OCPCORE.Site_NumMembers" content="{$META_DATA*,site_nummembers}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,site_bestmember}}<meta name="OCPCORE.Site_BestMember" content="{$META_DATA*,site_bestmember}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,forum_numtopics}}<meta name="OCPCORE.Forum_NumTopics" content="{$META_DATA*,forum_numtopics}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,forum_numposts}}<meta name="OCPCORE.Forum_NumPosts" content="{$META_DATA*,forum_numposts}" />{+END}
	<link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" /><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" />
	<meta name="DC.Language" content="{$LANG*}" />{+START,IF_NON_EMPTY,{$META_DATA,created}}<meta name="DCTERMS.Created" content="{$META_DATA*,created}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,publisher}}<meta name="DC.Publisher" content="{$META_DATA*,publisher}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,created}}<meta name="DC.Creator" content="{$META_DATA*,creator}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,modified}}<meta name="DCTERMS.Modified" content="{$META_DATA*,modified}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,type}}<meta name="DC.Type" content="{$META_DATA*,type}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,title}}<meta name="DC.Title" content="{$META_DATA*,title}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,identifier}}<meta name="DC.Identifier" content="{$FIND_SCRIPT*,pagelink_redirect}?id={$META_DATA&*,identifier}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,description}}<meta name="DC.Description" content="{$META_DATA*,description}" />{+END}
{+END}
{+START,IF_NON_EMPTY,{$META_DATA,title}}<meta property="og:title" content="{$META_DATA*,title}"/>{+END}
<meta property="og:url" content="{$CANONICAL_URL*}"/><meta property="og:site_name" content="{$SITE_NAME*}"/>
{+START,SET,Commented out by default to save bandwidth}
	Only do this if you have a real uid, not a page id... {+START,IF_NON_EMPTY,{$CONFIG_OPTION*,facebook_uid}}<meta property="fb:admins" content="{$CONFIG_OPTION*,facebook_uid}"/>{+END}
	this is usually better... {+START,IF_NON_EMPTY,{$CONFIG_OPTION*,facebook_appid}}<meta property="fb:app_id" content="{$CONFIG_OPTION*,facebook_appid}"/>{+END}
	Facebook does not like unregistered types so best to just leave it out {+START,IF_NON_EMPTY,{$META_DATA,type}}<meta property="og:type" content="{$REPLACE*, ,_,{$LCASE,{$META_DATA,type}}}"/>{+END}
{+END}
{+START,IF_NON_EMPTY,{$META_DATA,description}}<meta property="og:description" content="{$META_DATA*,description}"/>{+END}
{+START,IF_NON_EMPTY,{$META_DATA,image}}<meta property="og:image" content="{$META_DATA*,image}"/>{+END}{+START,IF_EMPTY,{$META_DATA,image}}<meta property="og:image" content="{$IMG*,logo/trimmed_logo}"/>{+END}
{+START,IF_NON_EMPTY,{$META_DATA,video}}<meta property="og:video" content="{$META_DATA*,video}" /><meta property="og:video:height" content="{$META_DATA*,video:height}" /><meta property="og:video:width" content="{$META_DATA*,video:width}" /><meta property="og:video:type" content="{$META_DATA*,video:type}" />{+END}

{$,Define the Microformats we support}
{+START,SET,Commented out by default to save bandwidth}
	<link rel="profile" href="http://www.w3.org/2003/g/data-view" />
	<link rel="profile" href="http://dublincore.org/documents/dcq-html/" />
	<link rel="profile" href="http://gmpg.org/xfn/11" />
	<link rel="profile" href="http://www.w3.org/2006/03/hcard" />
	<link rel="profile" href="http://microformats.org/profile/hcalendar" />
	<link rel="profile" href="http://ns.inria.fr/grddl/ogp/" />
{+END}
{$,NB: We also support standard metadata, schema.org, semantic HTML5, ARIA, OpenSearch, and OCPCORE}

{$,Favicon and iOS icon for site, managed as theme images}
<link rel="icon" href="{$IMG*,appleicon}" sizes="64x64 128x128" /> {$,Used on Opera speed dial}
<link rel="apple-touch-icon" href="{$IMG*,appleicon}" />
<link rel="shortcut icon" href="{$IMG*,favicon}" type="image/x-icon" sizes="16x16 32x32" />

{$,Inclusion of help semantic data, so smart browsers can provide native links to it}
{+START,IF,{$HAS_PRIVILEGE,see_software_docs}}{+START,IF_NON_EMPTY,{$DOCUMENT_HELP}}<link rel="help" href="{$DOCUMENT_HELP*}" />{+END}{+END}

{$,Inclusion of search semantic data, so smart browsers can automatically allow native-browser searching of the site}
{+START,SET,Commented out by default to save bandwidth}{+START,IF,{$ADDON_INSTALLED,search}}
	{+START,IF,{$EQ,{$ZONE},docs}}
		<link rel="search" type="application/opensearchdescription+xml" title="{$SITE_NAME*} {$ZONE*}" href="{$FIND_SCRIPT*,opensearch}?filter=:id=comcode_pages:search_under=docs" />
	{+END}
	{+START,IF,{$NEQ,{$ZONE},docs}}
		<link rel="search" type="application/opensearchdescription+xml" title="{$SITE_NAME*} {$ZONE*}" href="{$FIND_SCRIPT*,opensearch}?filter=" />
	{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,opensearch_totalresults}}<meta name="totalResults" content="{$META_DATA*,opensearch_totalresults}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,opensearch_startindex}}<meta name="startIndex" content="{$META_DATA*,opensearch_startindex}" />{+END}
	{+START,IF_NON_EMPTY,{$META_DATA,opensearch_itemsperpage}}<meta name="itemsPerPage" content="{$META_DATA*,opensearch_itemsperpage}" />{+END}
{+END}{+END}

{$,Google Analytics account, if one set up}
{+START,IF_NON_EMPTY,{$CONFIG_OPTION,google_analytics}}{+START,IF,{$NOR,{$IS_STAFF},{$IS_ADMIN}}}
	<script type="text/javascript">
		var _gaq=_gaq || [];
		_gaq.push(['_setAccount','{$TRIM;/,{$CONFIG_OPTION,google_analytics}}']);
		_gaq.push(['_trackPageview']);
		{+START,IF,{$NOT,{$CONFIG_OPTION,long_google_cookies}}}
			_gaq.push(['_setVisitorCookieTimeout', 0]);
			_gaq.push(['_setSessionCookieTimeout', 0]);
			_gaq.push(['_setCampaignCookieTimeout', 0]);
		{+END}

		(function() {
			var ga=document.createElement('script'); ga.type='text/javascript'; ga.async=true;
			ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
			var s=document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga,s);
		})();
	</script>
{+END}{+END}

{$,CSS includes from ocPortal page}
{$CSS_TEMPCODE}

{$,Javascript code (usually) from ocPortal page}
{$EXTRA_HEAD}

{$,Detecting of Timezones and Javascript support. Must go above JS_TEMPCODE because of init settings.}
<script type="text/javascript">// <![CDATA[
	{+START,IF,{$CONFIG_OPTION,detect_javascript}}
		{+START,IF,{$AND,{$EQ,,{$_GET,keep_has_js}},{$NOT,{$JS_ON}}}}
			if ((window.location.href.indexOf('upgrader.php')==-1) && (window.location.href.indexOf('webdav.php')==-1) && (window.location.search.indexOf('keep_has_js')==-1)) {$,Redirect with JS on, and then hopefully we can remove keep_has_js after one click. This code only happens if JS is marked off, no infinite loops can happen.}
				window.location=window.location.href+((window.location.search=='')?(((window.location.href.indexOf('.htm')==-1)&&(window.location.href.indexOf('.php')==-1))?(((window.location.href.substr(window.location.href.length-1)!='/')?'/':'')+'index.php?'):'?'):'&')+'keep_has_js=1{+START,IF,{$DEV_MODE}}&keep_devtest=1{+END}';
		{+END}
	{+END}
	{+START,IF,{$NOT,{$BROWSER_MATCHES,ie}}}{+START,IF,{$HAS_PRIVILEGE,sees_javascript_error_alerts}}window.take_errors=true;{+END}{+END}
	var {+START,IF,{$CONFIG_OPTION,is_on_timezone_detection}}server_timestamp={$FROM_TIMESTAMP%},{+END}ocp_lang='{$LANG;/}',ocp_theme='{$THEME;/}',ocp_username='{$USERNAME;/}'{+START,IF,{$IS_STAFF}},ocp_is_staff=true{+END};
//]]></script>

{$,Javascript includes from ocPortal page}
{$JS_TEMPCODE,header}
<!--[if lt IE 9]>
<script src="{$BASE_URL*}/data/html5.js"></script>
<![endif]-->

{$,jQuery fan? Just uncomment the below and start using all the jQuery plugins you love in the normal way}
{$,<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>}

{$,If the page is doing a refresh include the markup for that}
{$REFRESH}

{$,Feeds}
{$FEEDS}
