{TITLE}

<div class="wide_table_wrap"><table class="columned_table wide_table solidborder">
	<tr>
		<th><a href="{$PAGE_LINK*,_SELF:admin_ocpusers:type=users:sortby=name{NAMEORD}}">{!OC_WEBSITE_NAME}</a></th>
		<th><a href="{$PAGE_LINK*,_SELF:admin_ocpusers:type=users:sortby=acp{ACPORD}}">{!OC_LAST_ADMIN_ACCESS}</a></th>
		<th>{!OC_STILL_INSTALLED}</th>
		<th><a href="{$PAGE_LINK*,_SELF:admin_ocpusers:type=users:sortby=version{VERORD}}">{!VERSION}</a></th>
		<th>{!OC_PRIVACY}</th>
	</tr>

	{ROWS}
</table></div>
