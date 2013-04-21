{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<div class="box box___ocf_forum"><div class="box_inner">
		<div itemprop="description">
			{DESCRIPTION}
		</div>
	</div></div>
{+END}{+END}

{+START,IF_PASSED,ID}
	{+START,IF_NON_EMPTY,{$CATALOGUE_ENTRY_FOR,forum,{ID}}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$CATALOGUE_ENTRY_FOR,forum,{ID}}}{+END}
{+END}

{+START,IF_NON_PASSED,ID}{+START,IF,{$MATCH_KEY_MATCH,_WILD:members}}
	<p>{!DESCRIPTION_PRIVATE_TOPICS}</p>
{+END}{+END}

{+START,IF_NON_EMPTY,{$TRIM,{FILTERS}}}
	<div class="box box___ocf_forum"><div class="box_inner">
		<span class="ocf_pt_category_filters">{!CATEGORIES}:</span> {FILTERS}
	</div></div>
{+END}

{CATEGORIES}

{+START,IF_EMPTY,{TOPIC_WRAPPER}{CATEGORIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,SET,BUTTONS}
	<div class="float_surrounder">
		<div class="buttons_group ocf_screen_buttons">
			{+START,IF_PASSED,ID}
				{+START,INCLUDE,NOTIFICATION_BUTTONS}
					NOTIFICATIONS_TYPE=ocf_topic
					NOTIFICATIONS_ID=forum:{ID}
					NOTIFICATIONS_PAGELINK=forum:topics:toggle_notifications_forum:forum%3A{ID}
				{+END}
			{+END}
			{BUTTONS}
		</div>
	</div>
{+END}

{+START,IF_NON_EMPTY,{TOPIC_WRAPPER}}{$,Does not show if no topics as that would double it up}
	{+START,IF_PASSED,ID}{$,Does not show on PT/virtual-forum view as those are less actiony places}
		{+START,IF,{$NOT,{$VALUE_OPTION,disable_forum_dupe_buttons}}}
			<div class="non_accessibility_redundancy">
				{$GET,BUTTONS}
			</div>
		{+END}
	{+END}
{+END}

{TOPIC_WRAPPER}

{+START,IF,{$NOT,{$WIDE_HIGH}}}
	{$GET,BUTTONS}

	{+START,IF_PASSED,ID}
		<div class="non_accessibility_redundancy">
			<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation">
				<img class="breadcrumbs_img" src="{$IMG*,breadcrumbs}" alt="&gt; " title="{!YOU_ARE_HERE}" />
				{BREADCRUMBS}
			</nav>
		</div>
	{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,IF_PASSED,ID}
		{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_ocf_forums}}
			{+START,INCLUDE,STAFF_ACTIONS}
				1_URL={$PAGE_LINK*,_SEARCH:admin_ocf_forums:ad:parent_forum={ID}}
				1_TITLE={!ADD_FORUM}
				1_REL=add
				2_URL={$PAGE_LINK*,_SEARCH:admin_ocf_forums:_ed:{ID}}
				2_TITLE={!EDIT_FORUM}
				2_ACCESSKEY=q
				2_REL=edit
			{+END}
		{+END}
	{+END}
{+END}
