<div itemscope="itemscope" itemtype="http://schema.org/ProfilePage">
	{TITLE}

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div class="box box___author_screen__description"><div class="box_inner">
			<h2>{!AUTHOR_ABOUT}</h2>

			<div itemprop="description">
				{DESCRIPTION}
			</div>
		</div></div>
	{+END}

	{+START,IF_NON_EMPTY,{SKILLS}}
		<div class="box box___author_screen_skills"><div class="box_inner">
			<h2>{!SKILLS}</h2>

			{SKILLS}
		</div></div>
	{+END}

	{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,author,{AUTHOR}}}
	{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

	{+START,IF_NON_EMPTY,{URL_DETAILS}{FORUM_DETAILS}{POINT_DETAILS}{STAFF_DETAILS}}
		<div class="box box___author_screen__functions"><div class="box_inner">
			<p>
				{!AUTHOR_FUNCTIONS,{AUTHOR*}}&hellip;
			</p>
			<ul role="navigation" class="actions_list_compact" itemprop="significantLinks">
				{URL_DETAILS}
				{FORUM_DETAILS}
				{POINT_DETAILS}
				{STAFF_DETAILS}
				{SEARCH_DETAILS}
			</ul>
		</div></div>
	{+END}

	{+START,IF_EMPTY,{URL_DETAILS}{FORUM_DETAILS}{POINT_DETAILS}{STAFF_DETAILS}}
		<p>{!AUTHOR_NULL}</p>
	{+END}

	{+START,IF,{$ADDON_INSTALLED,downloads}}
		<div class="box box___author_screen__downloads"><div class="box_inner">
			<p>
				{!DOWNLOADS_RELEASED}&hellip;
			</p>
			{DOWNLOADS_RELEASED}
			{+START,IF_EMPTY,{DOWNLOADS_RELEASED}}
				<p class="nothing_here">{!NO_DOWNLOADS_FOUND}</p>
			{+END}
		</div></div>
	{+END}

	{+START,IF,{$ADDON_INSTALLED,news}}
		<div class="box box___author_screen__news"><div class="box_inner">
			<p>
				{!NEWS_RELEASED}&hellip;
			</p>
			{NEWS_RELEASED}
			{+START,IF_EMPTY,{NEWS_RELEASED}}
				<p class="nothing_here">{!NONE}</p>
			{+END}
		</div></div>
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
