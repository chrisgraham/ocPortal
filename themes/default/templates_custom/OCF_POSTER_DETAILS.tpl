{$SET,fancy_screen,{$OR,{$RUNNING_SCRIPT,iframe},{$MATCH_KEY_MATCH,site:members},{$MATCH_KEY_MATCH,site:search}}}

{+START,IF,{$GET,fancy_screen}}
	{+START,SET,ADDITIONAL_DETAILS}
		{+START,IF,{$NOT,{$MATCH_KEY_MATCH,_WILD:galleries}}}
			{+START,IF_PASSED,WARNINGS}
				<tr><th class="de_th">{!MODULE_TRANS_NAME_warnings}:</th><td>{WARNINGS*}</td></tr>
			{+END}
			{+START,IF_PASSED,GALLERIES}
				<tr><th class="de_th">{!galleries:GALLERIES}:</th><td>{GALLERIES*}</td></tr>
			{+END}
			{+START,IF_PASSED,AGE}
				<tr><th class="de_th">Age:</th><td><strong>{AGE*}</strong> ({DATE_OF_BIRTH*})</td></tr>
			{+END}
		{+END}
		<tr>
			<th class="de_th">{!USERGROUPS}:</th>
			<td>{+START,LOOP,OTHER_USERGROUPS}{_loop_var*}{+START,IF,{$NEQ,{_loop_key},0}}, {+END}{+END}</td>
		</tr>
	{+END}

	{+START,SET,CONTENTS}
		{$SET,AVATAR_URL,{$?,{$GET,fancy_screen},{$THUMBNAIL,{$?,{$IS_EMPTY,{$PHOTO,{POSTER}}},{$IMG,no_image},{$PHOTO,{POSTER}}},80x80,uploads/website_specific,,,pad,both,#faf5ef},{AVATAR_URL}}}

		{$SET,main,0}
		<a onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'&lt;table class=&quot;tooltip_fields variable_table&quot; summary=&quot;{!MAP_TABLE}&quot;&gt;&lt;tbody&gt;{CUSTOM_FIELDS_FULL^;*}{$GET^;*,ADDITIONAL_DETAILS}&lt;/tbody&gt;&lt;/table&gt;','auto');" href="{$MEMBER_PROFILE_LINK*,{POSTER}}"><img class="ocf_member_box_avatar" src="{$GET*,AVATAR_URL}" alt="" /></a>

		<div{+START,IF_NON_EMPTY,{$GET,AVATAR_URL}} class="ocf_member_box_avatar"{+END} style="float: left; width: 95px; word-wrap: break-word; margin-right: 0">
			<a href="{$MEMBER_PROFILE_LINK*,{POSTER}}">{$TRUNCATE_LEFT,{$USERNAME,{POSTER}},18,1}</a>
			{$SET,main,1}
			{CUSTOM_FIELDS}

			<p class="community_block_tagline">
				{+START,IF,{$NEQ,{$USER},{POSTER}}}
					[ <a href="{$PAGE_LINK*,site:pointstore:action:ocgifts:username={$USERNAME,{POSTER}}}">Give a gift</a> ]
				{+END}
				{+START,IF,{$EQ,{$USER},{POSTER}}}
					[ <em>This is you</em> ]
				{+END}
			</p>
		</div>
	{+END}

	<div style="width: 188px; float: left; padding: 5px; margin: 5px" class="lightborder">
		{$GET,CONTENTS}
	</div>
{+END}

{+START,IF,{$NOT,{$GET,fancy_screen}}}
	{+START,IF_NON_EMPTY,{AVATAR_URL}}
		<img class="ocf_member_box_avatar" src="{AVATAR_URL*}" alt="{!AVATAR}" title="{!AVATAR}" />
	{+END}

	<div{+START,IF_NON_EMPTY,{AVATAR_URL}} class="ocf_member_box_avatar"{+END}>
		<table class="tooltip_fields variable_table" summary="{!MAP_TABLE}">
			<tbody>
				<tr><th class="de_th">{!USERNAME}:</th><td><a href="{$MEMBER_PROFILE_LINK*,{POSTER}}">{$USERNAME*,{POSTER}}</a></td></tr>
				<tr><th class="de_th">{!ocf:SPECIFIC_FORUM_POSTS}:</th><td>{POSTS*}</td></tr>
				{+START,IF_NON_EMPTY,{POINTS}}
					<tr><th class="de_th">{!POINTS}:</th><td>{POINTS*}</td></tr>
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
{+END}
