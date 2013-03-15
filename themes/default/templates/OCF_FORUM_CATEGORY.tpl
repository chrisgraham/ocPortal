<div class="standardbox_wrap_classic">
	<div class="standardbox_classic">
	<h3 class="standardbox_title_classic">
		<div class="ocf_category_hide_button">
			<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionTable('c_{CATEGORY_ID*;}'); return false;"><img id="e_c_{CATEGORY_ID*}" title="{!TOGGLE_CATEGORY_VISIBILITY}" alt="{!TOGGLE_CATEGORY_VISIBILITY}" src="{$IMG*,{EXPAND_TYPE*}}" /></a>
		</div>
		{+START,FRACTIONAL_EDITABLE,{CATEGORY_TITLE},title,_SEARCH:admin_ocf_categories:type=__ed:id={CATEGORY_ID}}{CATEGORY_TITLE*}{+END}
		{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_ocf_categories}}<span class="associated_details">(<a href="{$PAGE_LINK*,_SEARCH:admin_ocf_categories:type=_ed:id={CATEGORY_ID}}">{!EDIT}</a>)</span>{+END}
	</h3>
	{+START,IF_NON_EMPTY,{CATEGORY_DESCRIPTION}}
		<div class="ocf_forum_category_description solidborder">
			{CATEGORY_DESCRIPTION*}
		</div>
	{+END}
	<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" id="c_{CATEGORY_ID*}" class="solidborder wide_table ocf_forum_category" style="{$JS_ON,display: {DISPLAY*},}"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 43px" />
				<col style="width: 100%" />
				<col style="width: 50px" />
				<col style="width: 50px" />
				<col style="width: 270px" />
			</colgroup>
		{+END}

		<thead>
			<tr>
				{+START,IF,{$NOT,{$MOBILE}}}
					<th></th>
				{+END}
				<th>
					{!FORUM_NAME}
				</th>
				{+START,IF,{$NOT,{$MOBILE}}}
					<th class="ocf_forum_category_centered_header">
						{!COUNT_TOPICS}
					</th>
					<th class="ocf_forum_category_centered_header">
						{!COUNT_POSTS}
					</th>
				{+END}
				<th>
					{!LAST_POST}
				</th>
			</tr>
		</thead>

		<tbody>
			{FORUMS}
			<tr>
				<td class="ocf_tr_end" colspan="5"> </td>
			</tr>
		</tbody>
	</table></div>

	</div>
</div>

<br />


