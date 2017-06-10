{TITLE}

{+START,IF_NON_EMPTY,{DESCRIPTION}}
	<div class="box box___catalogue_products_category_screen__description"><div class="box_inner">
		<div itemprop="description">
			{DESCRIPTION}
		</div>
	</div></div>
{+END}

{+START,IF_NON_EMPTY,{SUBCATEGORIES}}
	{$REPLACE, id="quantity", id="quantity2",{CART_LINK}}
{+END}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,catalogue_category,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

{SUBCATEGORIES}

{+START,IF_NON_EMPTY,{ENTRIES}}
	{CART_LINK}

	<div class="float_surrounder display_type_{DISPLAY_TYPE*}">
		{ENTRIES}
	</div>
{+END}

{+START,IF_EMPTY,{ENTRIES}{SUBCATEGORIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{SORTING}}
	<div class="box category_sorter inline_block"><div class="box_inner">
		{$SET,show_sort_button,1}
		{SORTING}
	</div></div>
{+END}

{+START,IF_NON_EMPTY,{PAGINATION}}
	<div class="float_surrounder">
		{PAGINATION}
	</div>
{+END}

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}

{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={ADD_ENTRY_URL*}
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
