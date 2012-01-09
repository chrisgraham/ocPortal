{+START,IF_NON_EMPTY,{$USER_FB_CONNECT,{MEMBER_ID}}}
	<div class="wide_table_wrap">
		<table class="wide_table ocf_profile_details" summary="{!MAP_TABLE}">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 130px" />
					<col style="width: 100%" />
				</colgroup>
			{+END}

			<tbody>
				<tr>
					<th class="de_th">Facebook:</th>
					<td>
						<a rel="me" target="_blank" title="{$USERNAME*,{MEMBER_ID}}'s Facebook ({!LINK_NEW_WINDOW})" href="http://www.facebook.com/profile.php?id={$USER_FB_CONNECT*,{MEMBER_ID}}"><img title="" alt="Facebook" src="{$IMG*,recommend/facebook}" /></a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
{+END}
