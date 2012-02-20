{WARNING_DETAILS}

{+START,IF,{$NOT,{$VALUE_OPTION,disable_forum_dupe_buttons}}}
	<div class="non_accessibility_redundancy">
		<div class="float_surrounder results_browser_spacing">
			<div class="ocf_screen_buttons">
				{+START,INCLUDE,NOTIFICATION_BUTTONS}
					NOTIFICATIONS_TYPE=ocf_topic
					NOTIFICATIONS_ID={ID}
					NOTIFICATIONS_PAGELINK={$PAGE_LINK,forum:topics:toggle_notifications_topic}
				{+END}
				{SCREEN_BUTTONS}
			</div>
		</div>
	</div>
{+END}

{POLL}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,topic,{$_GET,id}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}<br />{+END}

{+START,IF,{$NOT,{$VALUE_OPTION,disable_forum_dupe_buttons}}}
	{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
		<div class="non_accessibility_redundancy">
			<div class="results_browser_spacing float_surrounder">
				{$REPLACE, id="blp_, id="blp2_,{$REPLACE, for="blp_, for="blp2_,{$REPLACE, id="r_, id="r2_,{$REPLACE, for="r_, for="r2_,{RESULTS_BROWSER}}}}}
			</div>
		</div>
	{+END}
{+END}

{+START,IF_NON_EMPTY,{POSTS}}
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table ocf_topic">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 130px" />
				<col style="width: 100%" />
			</colgroup>
		{+END}
	
		<tbody>
			{POSTS}
		</tbody>
	</table></div>
{+END}

<div class="medborder members_viewing">
	{+START,IF_NON_EMPTY,{MEMBERS_VIEWING}}
		{!MEMBERS_VIEWING,{NUM_GUESTS*},{NUM_MEMBERS*},{MEMBERS_VIEWING}}
	{+END}
	{+START,IF_EMPTY,{MEMBERS_VIEWING}}
		{!TOO_MANY_USERS_ONLINE}
	{+END}
</div>
{+START,IF_EMPTY,{POSTS}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={TITLE}}{+END}{+END}

{+START,IF,{$OR,{$IS_NON_EMPTY,{MODERATOR_ACTIONS}},{$AND,{$NOT,{$MOBILE}},{$IS_NON_EMPTY,{MARKED_POST_ACTIONS}}},{MAY_CHANGE_MAX}}}
	<div class="medborder medborder_box ocf_topic_control_functions">
		<span class="control_functions">{!CONTROL_FUNCTIONS}</span>:
		{+START,IF_NON_EMPTY,{MODERATOR_ACTIONS}}
			<form title="{!TOPIC_ACTIONS}" action="{$URL_FOR_GET_FORM*,{ACTION_URL}}" method="get" class="inline">
				{$HIDDENS_FOR_GET_FORM,{ACTION_URL}}

				<div class="inline">
					<label for="tma_type">{!TOPIC_ACTIONS}:
					<select id="tma_type" name="type">
						<option value="-1">-</option>
						{MODERATOR_ACTIONS}
					</select>
					</label>
					<input class="button_pageitem" type="submit" onclick="if (document.getElementById('tma_type').selectedIndex!=-1) { disable_button_just_clicked(this); return true; }  return false;" value="{!PROCEED}" />
				</div>
			</form>
		{+END}
		{+START,IF,{$NOT,{$MOBILE}}}
			{+START,IF_NON_EMPTY,{MARKED_POST_ACTIONS}}
				{+START,IF,{$JS_ON}}
					<form title="{!MARKED_POST_ACTIONS}" action="{$URL_FOR_GET_FORM*,{ACTION_URL}}" method="get" class="inline">
						{$HIDDENS_FOR_GET_FORM,{ACTION_URL}}

						<div class="inline">
							<label for="mpa_type">{!MARKED_POST_ACTIONS}:
							<select id="mpa_type" name="type">
								<option value="-1">-</option>
								{MARKED_POST_ACTIONS}
							</select>
							</label>
							<input class="button_pageitem" type="submit" onclick="if (!addFormMarkedPosts(this.form,'mark_')) { window.fauxmodal_alert('{!NOTHING_SELECTED=;}'); return false; } if (document.getElementById('mpa_type').selectedIndex!=-1) { disable_button_just_clicked(this); return true; } return false;" value="{!PROCEED}" />
						</div>
					</form>
				{+END}
			{+END}
		{+END}
		{+START,IF,{MAY_CHANGE_MAX}}
			<form title="{!PER_PAGE}" class="inline" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},max}

				<div class="inline">
					<label for="max">{!PER_PAGE}:
					<select name="max" id="max">
						<option value="10"{$?,{$EQ,{MAX},10}, selected="selected",}>10</option>
						<option value="20"{$?,{$EQ,{MAX},20}, selected="selected",}>20</option>
						<option value="30"{$?,{$EQ,{MAX},30}, selected="selected",}>30</option>
						<option value="50"{$?,{$EQ,{MAX},50}, selected="selected",}>50</option>
						<option value="100"{$?,{$EQ,{MAX},100}, selected="selected",}>100</option>
						<option value="300"{$?,{$EQ,{MAX},300}, selected="selected",}>300</option>
					</select>
					</label>
					<input onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" value="{!CHANGE}" />
				</div>
			</form>
		{+END}
	</div>
{+END}

{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
	<div class="float_surrounder results_browser_spacing">
		{RESULTS_BROWSER}
	</div>
{+END}

<div class="float_surrounder results_browser_spacing">
	<div class="ocf_screen_buttons">
		{+START,INCLUDE,NOTIFICATION_BUTTONS}
			NOTIFICATIONS_TYPE=ocf_topic
			NOTIFICATIONS_ID={ID}
			NOTIFICATIONS_PAGELINK={$PAGE_LINK,forum:topics:toggle_notifications_topic}
		{+END}
		{SCREEN_BUTTONS}
	</div>

	{+START,IF,{$NOT,{$VALUE_OPTION,disable_forum_dupe_buttons}}}
		<div class="non_accessibility_redundancy">
			<div class="breadcrumbs_always">
				<img class="breadcrumbs_img" src="{$IMG*,treenav}" alt="&gt; " title="{!YOU_ARE_HERE}" />
				{TREE}
			</div>
		</div>
	{+END}
</div>

<div class="ocf_quick_reply">
	{QUICK_REPLY}
	
	{+START,IF_EMPTY,{QUICK_REPLY}}{+START,IF,{$EQ,{LAST_POSTER},{$USER}}}{+START,IF,{$NOT,{$IS_GUEST}}}{+START,IF,{$NOT,{MAY_DOUBLE_POST}}}
		{+START,BOX,,,curved}{!NO_DOUBLE_POST}{+END}
	{+END}{+END}{+END}{+END}
</div>

