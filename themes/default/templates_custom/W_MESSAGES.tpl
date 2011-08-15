{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">{+END}
{+START,IF,{$VALUE_OPTION,html5}}<!DOCTYPE html>{+END}
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$LANG*}" dir="{!dir}">
<head>
<meta http-equiv="Refresh" content="30; URL={$FIND_SCRIPT*,wmessages}{$KEEP*,1}" />
<meta name="GENERATOR" content="ocPortal" />
<meta name="description" content="{!MESSAGES}" />
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
{CSS}
<title>ocPortal</title>
</head>

<body class="re_body">
{MESSAGES}
</body>
</html>

