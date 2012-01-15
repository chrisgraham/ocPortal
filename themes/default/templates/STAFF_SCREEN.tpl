{TITLE}

<h2>{!DETAILS}</h2>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 140px" />
			<col style="width: 100%" />
		</colgroup>
	{+END}

	<tbody>
		<tr>
			<th>{!USERNAME}</th>
			<td><a href="{PROFILE_URL*}">{NAME*}</a></td>
		</tr>
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
		{+START,IF_NON_EMPTY,{ADDRESS}}
			{+START,IF,{$OCF}}
				<tr>
					<th>{!ocf:ADD_PERSONAL_TOPIC}</th>
					<td><a href="{$PAGE_LINK*,_SEARCH:topics:new_pt:{MEMBER_ID}}">{!ocf:ADD_PERSONAL_TOPIC}</a></td>
				</tr>
			{+END}
			{+START,IF,{$NOT,{$OCF}}}
				<tr>
					<th>{!EMAIL}</th>
					<td><a href="{$MAILTO}{$OBFUSCATE,{ADDRESS}}">{!EMAIL}</a></td>
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>

<br />

<div class="button_panel_left">
	<a href="{ALL_LINK*}"><img class="button_page" src="{$IMG*,page/all2}" title="{!VIEW_ALL_STAFF}" alt="{!VIEW_ALL_STAFF}" /></a>

	{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_staff}}
		<a rel="edit" href="{$PAGE_LINK*,_SEARCH:admin_staff}"><img class="button_page" src="{$IMG*,page/edit}" title="{!EDIT}" alt="{!EDIT}" /></a>
	{+END}
</div>

