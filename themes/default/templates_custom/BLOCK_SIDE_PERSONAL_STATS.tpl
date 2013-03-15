{+START,BOX,{USERNAME*},,{$?,{$GET,in_panel},panel,classic},tray_open}
	{+START,IF_NON_EMPTY,{AVATAR_URL}}
		<div class="personal_stats_avatar"><img src="{AVATAR_URL*}" title="{!AVATAR}" alt="{!AVATAR}" /></div>
	{+END}

	{+START,IF_NON_EMPTY,{CONTENT}}
		<ul class="compact_list">
			{CONTENT}
		</ul>
	{+END}
	{+START,IF_NON_EMPTY,{LINKS}}
		<div class="community_block_tagline{+START,IF_NON_EMPTY,{CONTENT}} community_block_tagline_splitter{+END}">
			{LINKS}
		</div>
	{+END}

	{+START,IF,{$OCF}}{+START,IF,{$NEQ,{$CPF_VALUE,m_password_compat_scheme},facebook}}
		{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
			<p class="community_block_tagline">
				<div class="fb-login-button" data-scope="email,user_birthday"></div>
			</p>
		{+END}
	{+END}{+END}
{+END}
