{$,This template is used for things like iframes used for previewing or for creating independent navigation areas in the site}
{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">{+END}
{+START,IF,{$VALUE_OPTION,html5}}<!DOCTYPE html>{+END}
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$LANG*}" lang="{$LANG*}" dir="{!dir}">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
{+END}
<meta name="GENERATOR" content="{$BRAND_NAME*}" />
<meta name="description" content="{TITLE*}" />
{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<meta name="language" content="{$LANG*}" />{+END}
{+START,IF_PASSED,TARGET}
	{+START,IF,{$NOT,{$DEV_MODE}}}<base href="{$BASE_URL*}/{$ZONE*}" target="{TARGET}" />{+END}
	{+START,IF,{$DEV_MODE}}<base href="http://example.com/" target="{TARGET}" /><!-- Totally break relative URLs so we know if they're used - we shouldn't ever use them, as they reflect path assumptions -->{+END}
{+END}
{+START,IF_NON_PASSED,TARGET}
	{+START,IF,{$DEV_MODE}}<base href="http://example.com/" /><!-- Totally break relative URLs so we know if they're used - we shouldn't ever use them, as they reflect path assumptions -->{+END}
{+END}

{$CSS_TEMPCODE}

{$,Javascript code (usually) from ocPortal page}
{$EXTRA_HEAD}

{$JS_TEMPCODE,header}

<title>{TITLE*}</title>
</head>
<body class="{+START,IF,{$EQ,{$_GET,opens_below},1}}opens_below {+END}re_body fake_middle_continuation{+START,IF_PASSED,CSS} {CSS*}{+END}">
	{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
		<div class="global_message">
			{MESSAGE_TOP}
		</div>
	{+END}{+END}

	{$SET,in_panel,0}{+START,IF,{$_GET,in_panel}}{$SET,in_panel,1}{+END}{+START,IF,{$_GET,interlock}}{$SET,interlock,1}{+END}

	{CONTENT}

	{+START,IF_PASSED,NEXT_LINK}
		<hr />
		<p>
			&raquo; <a href="{NEXT_LINK*}">{!MORE}</a>
		</p>
	{+END}

	{$JS_TEMPCODE,footer}

	{+START,IF_PASSED,FRAME}
		<script type="text/javascript">// <![CDATA[
			addEventListenerAbstract(window,'real_load',function () {
				if (typeof window.trigger_resize!='undefined') trigger_resize();
			} );
			scriptLoadStuff();
			{+START,IF,{$RUNNING_SCRIPT,preview}}
				{$JAVASCRIPT_INCLUDE,javascript_validation}
				disable_preview_scripts();
			{+END}
		//]]></script>
	{+END}
	{$EXTRA_FOOT}
</body>
</html>

