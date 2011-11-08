{$,It is advisable to edit this MAIL template in the default theme, as this will ensure that all mail sent from the website will be formatted consistently, whatever theme happens to be running at the time}

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{LANG*}" lang="{LANG*}">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>{TITLE*}</title>
{CSS}
</head>
<body class="re_body">
	{+START,BOX}
		<a href="{$BASE_URL*}"><img src="{$IMG*,logo/trimmed-logo}" title="{$SITE_NAME*}" alt="{$SITE_NAME*}" /></a>
	{+END}
	
	<br />

	{+START,BOX}
		{CONTENT}
	{+END}
</body>
</html>

