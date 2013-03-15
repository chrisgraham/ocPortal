{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic},,,{$?,{$IS_NON_EMPTY,{ARCHIVE_URL}},<a rel="archives" href="{ARCHIVE_URL*}">{!VIEW_ARCHIVE}</a>|}{$?,{$IS_NON_EMPTY,{SUBMIT_URL}},<a rel="add" href="{SUBMIT_URL*}">{!ADD_NEWS}</a>|}{$?,{$IS_NON_EMPTY,{RSS_URL}},<a href="{RSS_URL*}"><acronym title="Really Simple Syndication">RSS</acronym></a>|}{$?,{$IS_NON_EMPTY,{ATOM_URL}},<a href="{ATOM_URL*}">Atom</a>|}}
	{CONTENT}
		
	{+START,IF_NON_EMPTY,{BRIEF}}
		<h2>{$?,{BLOG},{!BLOG_OLDER_NEWS},{!OLDER_NEWS}}</h2>
	
		{BRIEF}
	{+END}
{+END}

