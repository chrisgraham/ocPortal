{TITLE}

<p>
	{!HIGHLIGHT_NAME_A,{COST},{REMAINING}}
</p>

<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list">
	<li class="actions_list_strong">&raquo; <form title="{!PRIMARY_PAGE_FORM}" class="inline" method="post" action="{NEXT_URL*}"><div class="inline"><input type="hidden" name="confirm" value="1" /><input class="buttonhyperlink" type="submit" value="{!PROCEED}" /></div></form></li>
</ul>
<br class="tiny_linebreak" />
