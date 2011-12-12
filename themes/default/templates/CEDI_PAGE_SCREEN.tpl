{TITLE}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,seedy_page,{ID}}}

{+START,IF_NON_EMPTY,{DESCRIPTION}}
	{+START,IF,{$NOT,{HIDE_POSTS}}}
		<div id="pe_cedi_page_description"{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{+START,BOX}
				{DESCRIPTION}
			{+END}

			{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}<br />{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}
		</div>
	{+END}
	{+START,IF,{HIDE_POSTS}}
		<div id="pe_cedi_page_description">
			{DESCRIPTION}
		</div>

		{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}<br />{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

		<hr class="spaced_rule" />
	{+END}
{+END}

{+START,IF_EMPTY,{CHILDREN}}
	<p class="nothing_here">{!NO_CHILDREN}</p>
{+END}
{+START,IF_NON_EMPTY,{CHILDREN}}
	<div class="cedi_page_children">
		<p>{!CHILD_PAGES}:</p>
		<ul{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
			{CHILDREN}
		</ul>
	</div>
{+END}

{+START,IF,{$AND,{$NOT,{$PREG_MATCH,(^|&|\?)te\_\d+=1,{$QUERY_STRING}}},{HIDE_POSTS}}}
	<p>
		<a class="hide_button" title="{!DISCUSSION}: {!EXPAND}/{!CONTRACT}" href="#" onclick="event.returnValue=false; toggleSectionInline('hidden_posts','block'); return false;"><img id="e_hidden_posts" alt="{!EXPAND}: {!DISCUSSION}" title="{!EXPAND}" src="{$IMG*,expand}" /></a> <a class="hide_button" title="{!DISCUSSION}: {!EXPAND}/{!CONTRACT}" href="#" onclick="event.returnValue=false; toggleSectionInline('hidden_posts','block'); return false;">{!DISCUSSION}</a> ({!POST_PLU,{NUM_POSTS*}})
	</p>
	<div id="hidden_posts" style="display: {$JS_ON,none,block}">
	<br />
{+END}

{+START,IF_EMPTY,{POSTS}}
	<p class="nothing_here">{!NO_POSTS}</p>
{+END}
{+START,IF_NON_EMPTY,{POSTS}}
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table ocf_topic">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 90px" />
				<col style="width: 100%" />
			</colgroup>
		{+END}

		<tbody>
			{POSTS}
		</tbody>
	</table></div>

	{+START,IF,{$AND,{$JS_ON},{STAFF_ACCESS}}}
		<form title="{!MERGE_CEDI_POSTS}" action="{$PAGE_LINK*,_SEARCH:cedi:type=mg:id={ID},1}" method="post">
			<div class="float_surrounder">
				<div class="cedi_merge_posts_button">
					<input onclick="if (addFormMarkedPosts(this.form,'mark_')) { disable_button_just_clicked(this); return true; } window.alert('{!NOTHING_SELECTED=;}'); return false;" class="button_page" type="submit" value="{!MERGE_CEDI_POSTS}" />
				</div>
			</div>
		</form>
	{+END}
{+END}

{+START,IF,{$AND,{$NOT,{$PREG_MATCH,(^|&|\?)te\_\d+=1,{$QUERY_STRING}}},{HIDE_POSTS}}}
	</div>
{+END}

<div class="button_panel button_panel_spaced">
	{MENU}
</div>

{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}

