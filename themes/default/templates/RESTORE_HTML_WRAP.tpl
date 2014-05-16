<!DOCTYPE html>

<html lang="{$LCASE*,{$LANG}}" dir="{!dir}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset={$CHARSET*}" />
		<link href="restore.php?type=css" rel="stylesheet" type="text/css" />
		{+START,IF_NON_EMPTY,{CSS_NOCACHE}}
			<style type="text/css">/*<![CDATA[*/
				{CSS_NOCACHE*}
			/*]]>*/</style>
		{+END}
		<title>Backup restorer</title>
	</head>

	<body id="installer_body" class="website_body">
		<div class="installer_main">
			<img alt="ocPortal" src="{$BASE_URL*}/themes/default/images/EN/logo/trimmed_logo.png" />
		</div>

		<div class="installer_main_inner">
			<div class="box box___restore_html_wrap"><div class="box_inner">
				<h1>Restoring the website</h1>

				{MESSAGE}
			</div></div>
		</div>
	</body>
</html>


