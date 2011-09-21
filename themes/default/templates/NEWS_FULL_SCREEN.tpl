<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/{$?,{BLOG},BlogPosting,NewsArticle}"}>
	{TITLE}

	{+START,IF_PASSED,WARNING_DETAILS}
		{WARNING_DETAILS}
	{+END}

	<div class="medborder medborder_detailhead_wrap">
		<div class="float_surrounder">
			<div class="medborder_detailhead">
				{+START,IF,{$INLINE_STATS}}{!VIEWS,{VIEWS*}}<br />{+END}
				{+START,IF,{$VALUE_OPTION,html5}}
					{!ADDED,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" pubdate="pubdate" itemprop="datePublished">{DATE*}</time>}
				{+END}
				{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
					{!ADDED,{DATE*}}
				{+END}
				<br />
				{+START,IF_NON_EMPTY,{AUTHOR_URL}}
					{!AUTHOR}: <a rel="author" href="{AUTHOR_URL*}" title="{!AUTHOR}: {AUTHOR*}">{AUTHOR*}</a><br />
				{+END}
				{+START,IF_EMPTY,{AUTHOR_URL}}{+START,IF_NON_EMPTY,{$USERNAME,{SUBMITTER}}}
					{!BY_SIMPLE,<a href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}"{$?,{$VALUE_OPTION,html5}, itemprop="author"}>{$USERNAME*,{SUBMITTER}}</a>}
				{+END}{+END}
			</div>

			<div{$?,{$VALUE_OPTION,html5}, itemprop="articleBody"}>
				{NEWS_FULL}
			</div>
		</div>
	</div>

	{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,news,{ID}}}
	{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}<br />{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

	<hr class="spaced_rule" />

	<{$?,{$VALUE_OPTION,html5},aside,div}>
		{+START,BOX,,,med}
			<p>
				{$?,{BLOG},{!BLOG_NEWS_UNDER_THESE},{!NEWS_UNDER_THESE}}
			</p>
			<ul>
				{+START,LOOP,CATEGORIES}
					<li><a href="{$PAGE_LINK*,_SELF:news:misc:{_loop_key}{$?,{BLOG},:blog=1,}}">{_loop_var*}</a></li>
				{+END}
			</ul>

			{+START,IF,{$NOT,{$_GET,blog}}}
				<div>
					<a rel="archives" href="{ARCHIVE_URL*}"><img class="button_page" src="{$IMG*,page/all2}" alt="{!VIEW_ARCHIVE}" title="" /></a>
				</div>
			{+END}
		{+END}
	</{$?,{$VALUE_OPTION,html5},aside,div}>

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={SUBMIT_URL*}
		1_TITLE={$?,{BLOG},{!ADD_NEWS_BLOG},{!ADD_NEWS}}
		1_REL=add
		1_NOREDIRECT=1
		2_URL={EDIT_URL*}
		2_ACCESSKEY=q
		2_TITLE={!_EDIT_LINK}
		2_REL=edit
		3_URL={NEWSLETTER_URL*}
		3_TITLE={+START,IF_NON_EMPTY,{NEWSLETTER_URL}}{!newsletter:NEWSLETTER_SEND}{+END}
	{+END}

	<div>
		<div class="float_surrounder">
			{+START,IF_NON_EMPTY,{TRACKBACK_DETAILS}}
				<div class="trackbacks right">
					{TRACKBACK_DETAILS}
				</div>
			{+END}
			{+START,IF_NON_EMPTY,{RATING_DETAILS}}
				<div class="ratings right">
					{RATING_DETAILS}
				</div>
			{+END}
		</div>
		<div>
			{COMMENT_DETAILS}
		</div>
	</div>

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={_TITLE}}{+END}{+END}

	{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
		<div class="edited edited_block">
			<img alt="" title="" src="{$IMG*,edited}" />
			{!EDITED}
			{+START,IF,{$VALUE_OPTION,html5}}
				<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}">{$DATE*,{EDIT_DATE_RAW}}</time>
			{+END}
			{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
				{$DATE*,{EDIT_DATE_RAW}}
			{+END}
		</div>
	{+END}
</div>
