{TITLE}

{+START,IF_NON_EMPTY,{DESCRIPTION}}
	{+START,BOX,,,curved}
		<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{DESCRIPTION}
		</div>
	{+END}
	<br />
{+END}

{SUBCATEGORIES}

{+START,IF_NON_EMPTY,{ENTRIES}}
	{ENTRIES}
	<br />
{+END}

{+START,IF_EMPTY,{ENTRIES}{SUBCATEGORIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={ADD_LINK*}
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

{+START,IF_NON_EMPTY,{SORT_OPTIONS}}
	<div class="medborder special_category_sorter inline_block">
		<form title="{!SORT}" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get" class="inline">
			{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1}}

			<div>
				<label for="c_order">{!SORT_BY}</label><br />
				<select{+START,IF,{$JS_ON}} onchange="this.form.submit();"{+END} id="c_order" name="order">
					{SORT_OPTIONS}
				</select>

				{+START,IF,{$NOT,{$JS_ON}}}
					<div class="mini_proceed_button">
						<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!SORT}" />
					</div>
				{+END}
			</div>
		</form>
	</div>
{+END}

{+START,IF_NON_EMPTY,{BROWSER}}
	<div class="float_surrounder">
		{BROWSER}
	</div>
{+END}

{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
