<br />

{+START,BOX,{!_STATISTICS},,light}
	<div class="ocf_stats_1">
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="ocf_stats_2 wide_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 135px" />
					<col style="width: 100%" />
				</colgroup>
			{+END}

			<tbody>
				{+START,IF_NON_EMPTY,{USERS_ONLINE}}
					<tr>
						<th class="de_th ocf_row1 ocf_stats_usersonline_1">
							<span class="field_name">{!USERS_ONLINE}:</span><br />
							<span class="community_block_tagline">[ {+START,IF_NON_EMPTY,{USERS_ONLINE_URL}}<a href="{USERS_ONLINE_URL*}">{+END}{+START,IF_NON_EMPTY,{USERS_ONLINE_URL}}{!DETAILS}</a>{+END} ]</span>
						</th>
						<td class="ocf_stats_usersonline_2">
							{USERS_ONLINE}

							{+START,IF_NON_EMPTY,{GROUPS}}
							<p>
								{!USERGROUPS}:
								{$SET,doing_first_group,1}
								{+START,LOOP,GROUPS}{+START,IF,{$NOT,{$GET,doing_first_group}}}, {+END}<a class="{GCOLOUR*}" href="{$PAGE_LINK*,_SEARCH:groups:view:{GID}}">{GTITLE*}</a>{$SET,doing_first_group,0}{+END}
							</p>
							{+END}
						</td>
					</tr>
				{+END}
				<tr>
					<th class="de_th ocf_row1 ocf_stats_main_1">
						<span class="field_name">{!FORUM_STATISTICS}:</span>
					</th>
					<td class="ocf_stats_main_2">
					{!FORUM_NUM_TOPICS,{NUM_TOPICS*}}, {!FORUM_NUM_POSTS,{NUM_POSTS*}}, {!FORUM_NUM_MEMBERS,{NUM_MEMBERS*}}<br />
					{!NEWEST_MEMBER,<a href="{NEWEST_MEMBER_PROFILE_URL*}">{NEWEST_MEMBER_USERNAME*}</a>}<br />
					{BIRTHDAYS}
					</td>
				</tr>
			</tbody>
		</table></div>
	</div>
{+END}

<br />
