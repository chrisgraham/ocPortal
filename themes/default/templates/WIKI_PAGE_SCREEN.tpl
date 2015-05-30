{TITLE}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,seedy_page,{ID}}}

{$REQUIRE_CSS,ocf}

<div class="wiki_screen">
	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		{+START,IF,{$NOT,{HIDE_POSTS}}}
			<div class="pe_wiki_page_description" itemprop="description">
				<div class="box box___wiki_page_screen"><div class="box_inner">
					<div>{$,To disassociated headers}
						{DESCRIPTION}
					</div>
				</div></div>

				{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}
			</div>
		{+END}
		{+START,IF,{HIDE_POSTS}}
			<div class="pe_wiki_page_description">
				{DESCRIPTION}
			</div>

			{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

			<hr class="spaced_rule" />
		{+END}
	{+END}

	{+START,IF_EMPTY,{CHILDREN}}
		<p class="nothing_here">{!NO_CHILDREN}</p>
	{+END}
	{+START,IF_NON_EMPTY,{CHILDREN}}
		<div class="wiki_page_children">
			<p class="lonely_label">{!CHILD_PAGES}:</p>
			<ul itemprop="significantLinks" class="spaced_list">
				{CHILDREN}
			</ul>
		</div>
	{+END}

	{+START,IF,{$AND,{$NOT,{$PREG_MATCH,(^|&|\?)te\_\d+=1,{$QUERY_STRING}}},{HIDE_POSTS}}}
		<div>
			<p class="toggleable_tray_title">
				<a class="toggleable_tray_button" title="{!DISCUSSION}: {!EXPAND}/{!CONTRACT}" href="#" onclick="return toggleable_tray('hidden_posts');"><img alt="{!EXPAND}: {!DISCUSSION}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
				<a class="toggleable_tray_button" title="{!DISCUSSION}: {!EXPAND}/{!CONTRACT}" href="#" onclick="return toggleable_tray('hidden_posts');">{!DISCUSSION}</a> ({!POST_PLU,{NUM_POSTS*}})
			</p>
			<div class="toggleable_tray" id="hidden_posts" style="display: {$JS_ON,none,block}" aria-expanded="false">
	{+END}

	{+START,IF_EMPTY,{POSTS}}
		<p class="nothing_here">{!NO_POSTS}</p>
	{+END}
	{+START,IF_NON_EMPTY,{POSTS}}
		<div class="wide_table_wrap"><div summary="{!MAP_TABLE}" class="results_table wide_table ocf_topic wiki_table">
			<div>
				{POSTS}
			</div>
		</div></div>

		{+START,IF,{$AND,{$JS_ON},{STAFF_ACCESS}}}
			<form title="{!MERGE_CEDI_POSTS}" action="{$PAGE_LINK*,_SEARCH:cedi:type=mg:id={ID},1}" method="post">
				<div class="float_surrounder">
					<div class="wiki_merge_posts_button">
						<input onclick="if (add_form_marked_posts(this.form,'mark_')) { disable_button_just_clicked(this); return true; } window.fauxmodal_alert('{!NOTHING_SELECTED=;}'); return false;" class="button_page" type="submit" value="{!MERGE_CEDI_POSTS}" />
					</div>
				</div>
			</form>
		{+END}
	{+END}

	{+START,IF,{$AND,{$NOT,{$PREG_MATCH,(^|&|\?)te\_\d+=1,{$QUERY_STRING}}},{HIDE_POSTS}}}
			</div>
		</div>
	{+END}

	<div class="buttons_group">
		{+START,INCLUDE,NOTIFICATION_BUTTONS}
			NOTIFICATIONS_TYPE=cedi
			NOTIFICATIONS_ID={ID}
		{+END}

		{MENU}
	</div>

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
</div>
