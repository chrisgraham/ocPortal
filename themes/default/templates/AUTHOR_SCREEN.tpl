<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ProfilePage"}>
	{TITLE}

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		{+START,BOX,{!AUTHOR_ABOUT},,med}
			<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
				{DESCRIPTION}
			</div>
		{+END}
		<br />
	{+END}

	{+START,IF_NON_EMPTY,{SKILLS}}
		{+START,BOX,{!SKILLS},,med}
			{SKILLS}
		{+END}
		<br />
	{+END}

	{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,author,{AUTHOR}}}
	{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}<br />{+END}

	{+START,IF_NON_EMPTY,{URL_DETAILS}{FORUM_DETAILS}{POINT_DETAILS}{STAFF_DETAILS}}
		{+START,BOX,,,light}
			<p>
				{!AUTHOR_FUNCTIONS,{AUTHOR*}}&hellip;
			</p>
			<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list_compact"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
				{URL_DETAILS}
				{FORUM_DETAILS}
				{POINT_DETAILS}
				{STAFF_DETAILS}
				{SEARCH_DETAILS}
			</ul>
		{+END}

		<br />
	{+END}

	{+START,IF_EMPTY,{URL_DETAILS}{FORUM_DETAILS}{POINT_DETAILS}{STAFF_DETAILS}}
		<p>{!AUTHOR_NULL}</p>
		<br />
	{+END}

	{+START,IF,{$ADDON_INSTALLED,downloads}}
		{+START,BOX,,,light}
			<p>
				{!DOWNLOADS_RELEASED}&hellip;
			</p>
			{DOWNLOADS_RELEASED}
			{+START,IF_EMPTY,{DOWNLOADS_RELEASED}}
				<p class="nothing_here">{!NO_DOWNLOADS_FOUND}</p>
			{+END}
		{+END}

		<br />
	{+END}

	{+START,IF,{$ADDON_INSTALLED,news}}
		{+START,BOX,,,light}
			<p>
				{!NEWS_RELEASED}&hellip;
			</p>
			{NEWS_RELEASED}
			{+START,IF_EMPTY,{NEWS_RELEASED}}
				<p class="nothing_here">{!NONE}</p>
			{+END}
		{+END}

		<br />
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={EDIT_URL*}
		1_TITLE={!EDIT}
		1_ACCESSKEY=q
		1_REL=edit
	{+END}
</div>
