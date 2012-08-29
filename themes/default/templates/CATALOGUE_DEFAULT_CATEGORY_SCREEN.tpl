{TITLE}

{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<div class="box box___catalogue_default_category_screen__description"><div class="box_inner">
		<div itemprop="description">
			{DESCRIPTION}
		</div>
	</div></div>
{+END}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,catalogue_category,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

{+START,IF_NON_EMPTY,{SUBCATEGORIES}}
	<div>
		<p class="lonely_label">{!CATEGORIES}:</p>
		{SUBCATEGORIES}
	</div>
{+END}

{ENTRIES}

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=catalogue_entry__{CATALOGUE}
	NOTIFICATIONS_ID={ID}
	BREAK=1
	RIGHT=1
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={ADD_ENTRY_URL*}
	1_TITLE={!CATALOGUE_GENERIC_ADD,{_TITLE*}}
	1_REL=add
	2_URL={ADD_CAT_URL*}
	2_TITLE={!CATALOGUE_GENERIC_ADD_CATEGORY,{_TITLE*}}
	2_REL=add
	3_ACCESSKEY=q
	3_URL={EDIT_CAT_URL*}
	3_TITLE={!CATALOGUE_GENERIC_EDIT_CATEGORY,{_TITLE*}}
	3_REL=edit
	4_URL={EDIT_CATALOGUE_URL*}
	4_TITLE={!EDIT_CATALOGUE}
{+END}

{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
