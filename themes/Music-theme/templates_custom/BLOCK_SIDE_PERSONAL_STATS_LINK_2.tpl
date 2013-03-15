{+START,IF_PASSED,POST}
	<li><form title="{NAME*}" class="inline" method="post" action="{URL*}"><input title="{DESCRIPTION*}" class="buttonhyperlink" type="submit" value="{NAME*}" /></form></li>
{+END}
{+START,IF_NON_PASSED,POST}
	<li><a title="{NAME*}: {DESCRIPTION*}" href="{URL*}">{NAME*}</a></li>
{+END}
