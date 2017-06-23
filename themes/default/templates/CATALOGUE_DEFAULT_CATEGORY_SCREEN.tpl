{TITLE}

{+START,IF_NON_EMPTY,{DESCRIPTION}}
	{+START,BOX,,,curved}
		<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{DESCRIPTION}
		</div>
	{+END}
	<br />
{+END}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,catalogue_category,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}
	{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}

	<hr class="spaced_rule" />
{+END}

{SUBCATEGORIES}

{+START,IF_NON_EMPTY,{ENTRIES}}
	{ENTRIES}
{+END}

{+START,IF_EMPTY,{ENTRIES}{SUBCATEGORIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{SORTING}}
	<div class="medborder special_category_sorter inline_block">
		{$SET,show_sort_button,1}
		{SORTING}
	</div>
{+END}

{+START,IF_NON_EMPTY,{BROWSER}}
	<div class="float_surrounder">
		{BROWSER}
	</div>
{+END}

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=catalogue_entry__{CATALOGUE}
	NOTIFICATIONS_ID={ID}
	BREAK=1
	RIGHT=1
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={ADD_LINK*}
	1_TITLE={!CATALOGUE_GENERIC_ADD,{CATALOGUE*}}
	1_REL=add
	2_URL={ADD_CAT_URL*}
	2_TITLE={!CATALOGUE_GENERIC_ADD_CATEGORY,{CATALOGUE*}}
	2_REL=add
	3_ACCESSKEY=q
	3_URL={EDIT_CAT_URL*}
	3_TITLE={!CATALOGUE_GENERIC_EDIT_CATEGORY,{CATALOGUE*}}
	3_REL=edit
	4_URL={EDIT_CATALOGUE_URL*}
	4_TITLE={!EDIT_CATALOGUE}
{+END}

{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
