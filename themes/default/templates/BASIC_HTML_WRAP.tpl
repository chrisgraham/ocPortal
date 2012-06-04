{$,This template is used for very raw output like banner frames}
<!DOCTYPE html>

<html lang="{$LANG*}" dir="{!dir}">
	<head>
		{+START,INCLUDE,HTML_HEAD}{+END}
	</head>

	<body class="website_body" id="basic_html_wrap" itemscope="itemscope" itemtype="http://schema.org/WebPage">
		<div>{CONTENT}</div>
	</body>
</html>

