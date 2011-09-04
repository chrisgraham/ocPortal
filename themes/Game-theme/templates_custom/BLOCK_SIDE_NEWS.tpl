{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic}}
	{+START,IF_EMPTY,{CONTENT}}
		<p class="block_no_entries">&raquo; {$?,{BLOG},{!BLOG_NO_NEWS},{!NO_NEWS}}</p>
	{+END}
	{+START,IF_NON_EMPTY,{CONTENT}}
		{CONTENT}
	{+END}

	<div class="more"><a href="{ARCHIVE_URL*}">More</a></div>
{+END}
