{+START,IF_PASSED,POST}
	[&nbsp;<form title="{NAME*}" class="inline" method="post" action="{URL*}"><input title="{DESCRIPTION*}" class="buttonhyperlink" type="submit" value="{NAME*}" /></form>&nbsp;]<br />
{+END}
{+START,IF_NON_PASSED,POST}
	[&nbsp;<a title="{NAME*}: {DESCRIPTION*}" href="{URL*}">{NAME*}</a>&nbsp;]<br />
{+END}
