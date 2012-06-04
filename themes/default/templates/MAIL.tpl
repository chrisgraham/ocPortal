{$,It is advisable to edit this MAIL template in the default theme, as this will ensure that all mail sent from the website will be formatted consistently, whatever theme happens to be running at the time}

<!DOCTYPE html>
<html xml:lang="{LANG*}" lang="{LANG*}">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={$CHARSET*}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>{TITLE*}</title>
{CSS}
</head>
<body style="font-size: 12px">
	<div style="font-size: 12px">
		<p><a href="{$BASE_URL*}"><img src="{$IMG*,logo/trimmed_logo}" title="{$SITE_NAME*}" alt="{$SITE_NAME*}" /></a></p>

		<div class="box box___mail"><div class="box_inner">
			{CONTENT}
		</div></div>
	</div>
</body>
</html>

