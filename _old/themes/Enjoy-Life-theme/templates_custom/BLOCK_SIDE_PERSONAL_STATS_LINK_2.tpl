{+START,IF_PASSED,POST}
	<form class="inline" method="post" action="{URL*}"><input title="{DESCRIPTION*}" class="buttonhyperlink" type="submit" value="{NAME*}" /></form><br />
{+END}
{+START,IF_NON_PASSED,POST}
	<a title="{NAME*}: {DESCRIPTION*}" href="{URL*}">{NAME*}</a><br />
{+END}
