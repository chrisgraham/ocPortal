<div class="ocf_forum_grouping">
	<h3 class="toggleable_tray_title_heading">
		<div class="ocf_forum_grouping_toggleable_tray_button">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray('c_{GROUPING_ID*;}');"><img title="{!TOGGLE_GROUPING_VISIBILITY}" alt="{!TOGGLE_GROUPING_VISIBILITY}" src="{$IMG*,{EXPAND_TYPE*}}" /></a>
		</div>
		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray('c_{GROUPING_ID*;}');">{+START,FRACTIONAL_EDITABLE,{GROUPING_TITLE},title,_SEARCH:admin_ocf_categories:type=__ed:id={GROUPING_ID}}{GROUPING_TITLE*}{+END}</a>
		{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_ocf_categories}}<span class="associated_details">(<a href="{$PAGE_LINK*,_SEARCH:admin_ocf_categories:type=_ed:id={GROUPING_ID}}">{!EDIT}</a>)</span>{+END}

		{+START,IF_NON_EMPTY,{GROUPING_DESCRIPTION}}
			&ndash; <span class="associated_details">{GROUPING_DESCRIPTION*}</span>
		{+END}
	</h3>

	<div class="toggleable_tray" id="c_{GROUPING_ID*}"{+START,IF,{$NEQ,{DISPLAY},block}} style="{$JS_ON,display: {DISPLAY*},}"{+END}>
		<div class="wide_table_wrap">
			<table summary="{!COLUMNED_TABLE}" class="wide_table ocf_forum_grouping" itemprop="significantLinks">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col class="ocf_forum_grouping_column1" />
						<col class="ocf_forum_grouping_column2" />
						<col class="ocf_forum_grouping_column3" />
						<col class="ocf_forum_grouping_column4" />
						<col class="ocf_forum_grouping_column5" />
					</colgroup>
				{+END}

				<thead>
					<tr>
						{+START,IF,{$NOT,{$MOBILE}}}
							<th class="ocf_forum_box_left"></th>
						{+END}
						<th{+START,IF,{$MOBILE}} class="ocf_forum_box_left"{+END}>
							{!FORUM_NAME}
						</th>
						{+START,IF,{$NOT,{$MOBILE}}}
							<th class="ocf_forum_grouping_centered_header">
								{!COUNT_TOPICS}
							</th>
							<th class="ocf_forum_grouping_centered_header">
								{!COUNT_POSTS}
							</th>
						{+END}
						<th class="ocf_forum_box_right">
							{!LAST_POST}
						</th>
					</tr>
				</thead>

				<tbody>
					{FORUMS}
				</tbody>
			</table>
			<div class="ocf_table_footer"><div><div>
				{+START,IF,{$NOT,{$MOBILE}}}
					<div class="ocf_column1 ocf_forum_box_bleft"></div>
				{+END}
				<div class="ocf_column1{+START,IF,{$MOBILE}} ocf_forum_box_bleft{+END}"></div>
				{+START,IF,{$NOT,{$MOBILE}}}
					<div class="ocf_column1"></div>
					<div class="ocf_column1"></div>
				{+END}
				<div class="ocf_column1 ocf_forum_box_bright"></div>
			</div></div></div>
		</div>
	</div>
</div>


