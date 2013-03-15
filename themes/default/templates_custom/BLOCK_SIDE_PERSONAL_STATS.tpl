<section class="box box___block_side_personal_stats"><div class="box_inner">
	<h3>{USERNAME*}</h3>

	{+START,IF_NON_EMPTY,{AVATAR_URL}}
		<div class="personal_stats_avatar"><img src="{AVATAR_URL*}" title="{!AVATAR}" alt="{!AVATAR}" /></div>
	{+END}

	{+START,IF_NON_EMPTY,{DETAILS}}
		<ul class="compact_list">
			{DETAILS}
		</ul>
	{+END}

	{+START,IF_NON_EMPTY,{LINKS}}
		<ul class="associated_links_block_group">
			{LINKS}
		</ul>
	{+END}

	{+START,IF,{$OCF}}{+START,IF,{$NEQ,{$CPF_VALUE,m_password_compat_scheme},facebook}}
		{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
			<div class="fb-login-button" data-scope="email,user_birthday"></div>
		{+END}
	{+END}{+END}
</div></section>
