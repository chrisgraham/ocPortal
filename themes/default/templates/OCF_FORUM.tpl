{+START,IF_PASSED,DESCRIPTION}{+START,IF_NON_EMPTY,{DESCRIPTION}}
	{+START,BOX,,,med}
		<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{DESCRIPTION}
		</div>
	{+END}
{+END}{+END}

<br />

{+START,IF_NON_EMPTY,{FILTERS}}
	<p>
		<span class="ocf_pt_category_filters">{!CATEGORIES}</span>: {FILTERS}
	</p>
{+END}

{CATEGORIES}

<div class="float_surrounder">
	{BUTTONS}
</div>

<br />

{TOPIC_WRAPPER}

{+START,IF_EMPTY,{TOPIC_WRAPPER}{CATEGORIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,IF_PASSED,ID}
	{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_ocf_forums}}
		{+START,INCLUDE,STAFF_ACTIONS}
			1_URL={$PAGE_LINK*,_SEARCH:admin_ocf_forums:ad:parent={ID}}
			1_TITLE={!ADD_FORUM}
			1_REL=add
			2_URL={$PAGE_LINK*,_SEARCH:admin_ocf_forums:_ed:{ID}}
			2_TITLE={!EDIT_FORUM}
			2_ACCESSKEY=q
			2_REL=edit
		{+END}
	{+END}
{+END}
