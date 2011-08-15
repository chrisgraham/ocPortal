{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">{+END}
{+START,IF,{$VALUE_OPTION,html5}}<!DOCTYPE html>{+END}
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$LANG*}" lang="{$LANG*}" dir="{!dir}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset={!charset}" />
<meta name="GENERATOR" content="{$BRAND_NAME*}" />
<meta name="description" content="{TITLE*}" />
<title>{TITLE*}</title>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
{+END}
{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<meta name="language" content="{$LANG*}" />{+END}
</head>
<body class="re_body">
	<div>{MESSAGES}</div>

	<script type="text/javascript">// <![CDATA[
		scriptLoadStuff();
	//]]></script>
</body>
</html>
