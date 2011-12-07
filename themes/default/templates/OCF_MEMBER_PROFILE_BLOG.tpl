{RECENT_BLOG_POSTS}

{+START,IF_EMPTY,{RECENT_BLOG_POSTS}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={ADD_BLOG_POST_URL*}
	1_TITLE={!ADD_NEWS_BLOG}
{+END}
