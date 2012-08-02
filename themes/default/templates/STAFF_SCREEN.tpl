{TITLE}

<h2>{!DETAILS}</h2>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="results_table wide_table">
	<colgroup>
		<col class="field_name_column" />
		<col class="field_value_column" />
	</colgroup>

	<tbody>
		{+START,IF_NON_EMPTY,{REAL_NAME}}
			<tr>
				<th>{!REALNAME}</th>
				<td>{REAL_NAME*}</td>
			</tr>
		{+END}
		{+START,IF_NON_EMPTY,{ROLE}}
			<tr>
				<th>{!ROLE}</th>
				<td>{ROLE*}</td>
			</tr>
		{+END}
		<tr>
			<th>{!USERNAME}</th>
			<td><a class="associated_link suggested" href="{PROFILE_URL*}">{NAME*}</a></td>
		</tr>
		{+START,IF_NON_EMPTY,{ADDRESS}}
			{+START,IF,{$OCF}}
				<tr>
					<th>{!ocf:ADD_PRIVATE_TOPIC}</th>
					<td><span class="associated_link"><a href="{$PAGE_LINK*,_SEARCH:topics:new_pt:{MEMBER_ID}}">{!ocf:ADD_PRIVATE_TOPIC}</a></span></td>
				</tr>
			{+END}
			{+START,IF,{$NOT,{$OCF}}}
				<tr>
					<th>{!EMAIL}</th>
					<td><span class="associated_link"><a href="{$MAILTO}{$OBFUSCATE,{ADDRESS}}">{!EMAIL}</a></span></td>
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>

<div class="buttons_group">
	{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_staff}}
		<a rel="edit" href="{$PAGE_LINK*,_SEARCH:admin_staff}"><img class="button_page" src="{$IMG*,page/edit}" title="{!EDIT}" alt="{!EDIT}" /></a>
	{+END}

	<a href="{ALL_STAFF_URL*}"><img class="button_page" src="{$IMG*,page/all2}" title="{!VIEW_ALL_STAFF}" alt="{!VIEW_ALL_STAFF}" /></a>
</div>

