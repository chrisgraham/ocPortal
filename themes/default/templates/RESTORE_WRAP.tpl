<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$LANG*}" lang="{$LANG*}">
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset={!charset}" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta name="language" content="{$LANG*}" />
		<link href="restore.php?type=css" rel="stylesheet" type="text/css" />
		{+START,IF_NON_EMPTY,{CSS_NOCACHE}}
			<style type="text/css">
				{CSS_NOCACHE*}
			</style>
		{+END}
		<title>Backup restorer</title>
	</head>

	<body id="installer_body" class="re_body">
		<div class="installer_main">
			<img title="" alt="ocPortal" src="{$BASE_URL*}/themes/default/images/EN/logo/trimmed-logo.png" />
		</div>

		<br class="tiny_linebreak" />

		<div class="installer_main_internal">
			{+START,BOX,Restoring the website}
				{MESSAGE}
			{+END}
		</div>
	</body>
</html>


