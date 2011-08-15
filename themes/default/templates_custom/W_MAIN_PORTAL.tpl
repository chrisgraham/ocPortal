<div>
	<a href="{$PAGE_LINK*,_SELF:_SELF:type=portal:param={DEST_REALM}}">{NAME*}</a>

	{+START,IF,{EDITABLE}}
	&ndash; <a title="{!EDIT}: #{NAME*}" href="{$PAGE_LINK*,_SELF:_SELF:type=editportal:param={DEST_REALM}}">{!EDIT}</a>
	&ndash; <form class="inline" action="{$PAGE_LINK*,_SELF:_SELF:type=confirm:btype=deleteportal:param={DEST_REALM}}" method="post"><input class="buttonhyperlink" type="submit" value="{!DELETE}" /></form>
	{+END}
</div>
