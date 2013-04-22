<tr>
	<th>
		<a href="{PROFILE_URL*}">{NAME*}</a>
	</th>
	<td>
		<a href="{POINTS_URL*}" title="{$TRUNCATE_LEFT*,{POINTS},25,1}: {NAME*}">{$TRUNCATE_LEFT*,{POINTS},25,1}</a>
	</td>
	{+START,IF,{HAS_RANK_IMAGES}}
		<td>
			{$OCF_RANK_IMAGE,{ID}}
		</td>
	{+END}
</tr>
