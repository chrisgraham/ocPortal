<section class="box box___block_main_news"><div class="box_inner">
	{+START,IF,{$NOT,{BLOG}}}{+START,IF_NON_EMPTY,{TITLE}}
		<h3>{TITLE}</h3>
	{+END}{+END}

	{CONTENT}

	{+START,IF_NON_EMPTY,{BRIEF}}
		<div>
			<h2>{$?,{BLOG},{!BLOG_OLDER_NEWS},{!OLDER_NEWS}}</h2>

			{BRIEF}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{ARCHIVE_URL}{SUBMIT_URL}{RSS_URL}{ATOM_URL}}
		<ul class="horizontal_links associated_links_block_group force_margin">
			{+START,IF_NON_EMPTY,{ARCHIVE_URL}}
				<li><a rel="archives" href="{ARCHIVE_URL*}">{!VIEW_ARCHIVE}</a></li>
			{+END}
			{+START,IF_NON_EMPTY,{SUBMIT_URL}}
				<li><a rel="add" href="{SUBMIT_URL*}">{$?,{BLOG},{!ADD_NEWS_BLOG},{!ADD_NEWS}}</a></li>
			{+END}
			{+START,IF_NON_EMPTY,{RSS_URL}}
				<li><a href="{RSS_URL*}"><abbr title="Really Simple Syndication">RSS</abbr></a></li>
			{+END}
			{+START,IF_NON_EMPTY,{ATOM_URL}}
				<li><a href="{ATOM_URL*}">Atom</a></li>
			{+END}
		</ul>
	{+END}
</div></section>
