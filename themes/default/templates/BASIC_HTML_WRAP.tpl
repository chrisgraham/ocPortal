{$,This template is used for very raw output like banner frames}
{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">{+END}
{+START,IF,{$VALUE_OPTION,html5}}<!DOCTYPE html>{+END}
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$LANG*}" lang="{$LANG*}" dir="{!dir}">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
<title>{TITLE*}</title>
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

{+START,IF_PASSED,NOFOLLOW}
	<meta name="robots" content="noindex, nofollow" />
{+END}
</head>
<body class="re_body">
	<div>{CONTENT}</div>
</body>
</html>

