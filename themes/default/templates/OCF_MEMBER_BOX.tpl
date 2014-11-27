{+START,IF,{$NOT,{$MOBILE}}}
	{+START,IF_NON_EMPTY,{AVATAR_URL}}
		<img class="ocf_member_box_avatar" src="{AVATAR_URL*}" alt="{!AVATAR}" title="{!AVATAR}" />
	{+END}
{+END}

<div{+START,IF_NON_EMPTY,{AVATAR_URL}} class="ocf_member_box_avatar_touching"{+END}>
	<table class="tooltip_fields autosized_table" summary="{!MAP_TABLE}">
		<tbody>
			<tr><th class="de_th">{!USERNAME}:</th><td><a href="{$MEMBER_PROFILE_URL*,{POSTER}}">{$USERNAME*,{POSTER}}</a></td></tr>
			<tr><th class="de_th">{!ocf:SPECIFIC_FORUM_POSTS}:</th><td>{POSTS*}</td></tr>
			{+START,IF_NON_EMPTY,{POINTS}}
				<tr><th class="de_th"><abbr title="{!LIFETIME_POINTS,{$NUMBER_FORMAT*,{$AVAILABLE_POINTS,{POSTER}}}}">{!POINTS}</abbr>:</th><td>{POINTS*}</td></tr>
			{+END}
			<tr><th class="de_th">{!JOINED}:</th><td>{JOIN_DATE*}</td></tr>
			{+START,IF,{$NOT,{$MATCH_KEY_MATCH,_WILD:galleries}}}
				{+START,IF_PASSED,IP_ADDRESS}
					<tr><th class="de_th">{!IP_ADDRESS}:</th><td>{$TRUNCATE_LEFT,{IP_ADDRESS},15,1}</td></tr>
				{+END}
				{+START,IF_PASSED,WARNINGS}
					<tr><th class="de_th">{!MODULE_TRANS_NAME_warnings}:</th><td>{WARNINGS*}</td></tr>
				{+END}
				{+START,IF_PASSED,GALLERIES}
					<tr><th class="de_th">{!galleries:GALLERIES}:</th><td>{GALLERIES*}</td></tr>
				{+END}
				{+START,IF_PASSED,DATE_OF_BIRTH}
					<tr><th class="de_th">{!DATE_OF_BIRTH}:</th><td>{DATE_OF_BIRTH*}</td></tr>
				{+END}
			{+END}
			<tr>
				<th class="de_th">{!USERGROUPS}:</th>
				<td>{+START,LOOP,OTHER_USERGROUPS}{+START,IF,{$NEQ,{_loop_key},0}}, {+END}{_loop_var*}{+END}</td>
			</tr>
			<tr><th class="de_th">{!ONLINE_NOW}:</th><td>{$?*,{ONLINE},{!YES},{!NO}}</td></tr>
			{CUSTOM_FIELDS}
		</tbody>
	</table>
</div>
