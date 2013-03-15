{TITLE}

{+START,IF_PASSED,BLOGGER}
	{+START,IF,{$OCF}}
		<div class="box box___news_archive_screen"><div class="box_inner">
			<h2>{!WELCOME_BLOG_OF,{$USERNAME*,{BLOGGER}},{$MEMBER_PROFILE_URL*,{BLOGGER}}}</h2>

			{$OCF_MEMBER_HTML,{BLOGGER}}
		</div></div>

		<h2>{!BLOGS_POSTS}</h2>
	{+END}
{+END}

<div class="float_surrounder" itemprop="significantLinks">
	{+START,SET,commented_out}
		<div class="chicklets">
			{+START,INCLUDE,NEWS_CHICKLETS}RSS_URL={$FIND_SCRIPT*,backend}{+END}
		</div>
	{+END}

	{$,<div class="chicklets_spacer">}
		{CONTENT}

		{+START,IF_EMPTY,{CONTENT}}
			<p class="nothing_here">{!NO_ENTRIES}</p>
		{+END}
	{$,</div>}
</div>

{BROWSE}

{+START,IF_PASSED,CAT}
	{+START,INCLUDE,NOTIFICATION_BUTTONS}
		NOTIFICATIONS_TYPE=news_entry
		NOTIFICATIONS_ID={CAT}
		BREAK=1
		RIGHT=1
	{+END}
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={SUBMIT_URL*}
	1_TITLE={$?,{BLOG},{!ADD_NEWS_BLOG},{!ADD_NEWS}}
	1_REL=add
{+END}
