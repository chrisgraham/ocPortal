{TITLE}

{+START,IF_PASSED,BLOGGER}
	{+START,IF,{$OCF}}
		{+START,BOX,{!WELCOME_BLOG_OF,{$USERNAME*,{BLOGGER}},{$MEMBER_PROFILE_LINK*,{BLOGGER}}},,med}
			{+START,IF_NON_EMPTY,{$AVATAR,{BLOGGER}}}
				<img style="float: left" src="{$AVATAR*,{BLOGGER}}" alt="{!AVATAR}" title="" />
			{+END}
			{$OCF_MEMBER_HTML,{BLOGGER}}
		{+END}
		<br />
		
		<h2>{!BLOGS_POSTS}</h2>
	{+END}
{+END}

<div class="float_surrounder">
	<!--<div class="chicklets">
		{+START,INCLUDE,NEWS_CHICKLETS}RSS_URL={$FIND_SCRIPT*,backend}{+END}
	</div>-->
	
	<!--<div class="chicklets_spacer">-->
		{CONTENT}
	<!--</div>-->
</div>

{BROWSE}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={SUBMIT_URL*}
	1_TITLE={$?,{BLOG},{!ADD_NEWS_BLOG},{!ADD_NEWS}}
	1_REL=add
{+END}
