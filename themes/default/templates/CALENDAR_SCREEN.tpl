<div class="vcalendar vevent">
	{TITLE}

	{WARNING_DETAILS}

	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{SUBSCRIBE_URL}}
			<div class="event_right">
				{+START,IF_NON_EMPTY,{SUBSCRIBED}}
					{+START,BOX,{!SUBSCRIBED_REMINDERS}}
						<div class="accessibility_hidden">{!FOLLOWING_SUBSCRIBED}</div>
						<ul>
							{SUBSCRIBED}
						</ul>
					{+END}
					
					<br />
				{+END}

				<div class="event_reminders">
					{+START,BOX,{!REMINDERS},,med}
						{+START,IF_NON_EMPTY,{SUBSCRIPTIONS}}
							<div class="event_subscriptions float_surrounder">
								{SUBSCRIPTIONS}
							</div>
						{+END}
						<hr />
						<div class="event_subscribe"><a href="{SUBSCRIBE_URL*}">{!SUBSCRIBE_EVENT}</a></div>
					{+END}
				</div>
			</div>
		{+END}

		<div{+START,IF_NON_EMPTY,{SUBSCRIBE_URL}} class="event_left"{+END}>
			{+START,BOX,{!DESCRIPTION}}
				<div class="float_surrounder">
					<img class="event_type_image" src="{$IMG*,{LOGO}}" alt="{TYPE*}" title="{TYPE*}" />
					{+START,IF_NON_EMPTY,{CONTENT}}
						<div class="description"{$?,{$VALUE_OPTION,html5}, itemprop="description"}>{CONTENT}</div>
					{+END}
					{+START,IF_EMPTY,{CONTENT}}
						<div class="no_description">{!NO_DESCRIPTION}</div>
					{+END}
				</div>
			{+END}
		</div>
	</div>

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={EDIT_URL*}
		1_TITLE={!EDIT}
		1_ACCESSKEY=q
		1_REL=edit

		{$,Do not auto-redirect back to here as recurrences may break so URL hints may no longer be valid}
		1_NOREDIRECT=1
	{+END}

	<br />

	<div class="event_reminders">
		<div class="event_right">
			{+START,IF_NON_EMPTY,{TRACKBACK_DETAILS}}
				<div class="trackbacks right">
					{TRACKBACK_DETAILS}
				</div>
			{+END}
			{+START,IF_NON_EMPTY,{RATING_DETAILS}}
				<div class="ratings right">
					{RATING_DETAILS}
				</div>
			{+END}
		</div>

		<div class="event_left no_stbox_padding">
			{+START,BOX,{!DETAILS}}
				<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col style="width: 100px" />
							<col style="width: 100%" />
						</colgroup>
					{+END}

					<tbody>
						{+START,IF_NON_EMPTY,{TIME}}
							<tr>
								<th>{!TIME}</th>
								<td>{TIME*}</td>
							</tr>
						{+END}
						{+START,IF_NON_EMPTY,{DAY}}
						<tr>
							<th>{!DATE}</th>
							<td>
								{+START,IF,{$VALUE_OPTION,html5}}
									<time class="dtstart" datetime="{TIME_VCAL*}" itemprop="startDate">{DAY*}</time>
								{+END}
								{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
									<abbr class="dtstart" title="{TIME_VCAL*}">{DAY*}</abbr>
								{+END}

								{+START,IF_PASSED,TO_DAY}{+START,IF,{$NEQ,{TO_DAY},{DAY}}}
									&ndash;
									
									{+START,IF,{$VALUE_OPTION,html5}}
										<time class="dtend" datetime="{TO_TIME_VCAL*}" itemprop="endDate">{TO_DAY*}</time>
									{+END}
									{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
										<abbr class="dtend" title="{TO_TIME_VCAL*}">{TO_DAY*}</abbr>
									{+END}
								{+END}{+END}
							</td>
						</tr>
						{+END}
						{+START,IF_PASSED,TIMEZONE}
							<tr>
								<th>{!TIMEZONE}</th>
								<td>{TIMEZONE*}</td>
							</tr>
						{+END}
						<tr>
							<th>{!TYPE}</th>
							<td class="category">{TYPE*}</td>
						</tr>
						<tr>
							<th>{!PRIORITY}</th>
							<td>{PRIORITY_LANG*}</td>
						</tr>
						<tr>
							<th>{!IS_PUBLIC}</th>
							<td>{IS_PUBLIC*}</td>
						</tr>
						<tr>
							<th>{!RECURRENCE}</th>
							<td>{RECURRENCE*}</td>
						</tr>

						{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,event,{ID}}}
						{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry},1}{+END}
					</tbody>
				</table></div>
			{+END}
		</div>
	</div>

	<div>
		{COMMENT_DETAILS}
	</div>

	<!--<p class="standard_meta_block"{$?,{$VALUE_OPTION,html5}, role="contentinfo"}>
		{+START,IF,{$VALUE_OPTION,html5}}{!ADDED,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" pubdate="pubdate">{ADD_DATE*}</time>}{+END}{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}{!ADDED,{ADD_DATE*}}{+END}{+START,IF,{$INLINE_STATS}}. {!VIEWS,{VIEWS*}}{+END}
	</p>-->

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
		<div class="edited edited_block"{$?,{$VALUE_OPTION,html5}, role="note"}>
			<img alt="" title="" src="{$IMG*,edited}" /> {!EDITED}
			{+START,IF,{$VALUE_OPTION,html5}}
				<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}">{$DATE*,{EDIT_DATE_RAW}}</time>
			{+END}
			{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
				{$DATE*,{EDIT_DATE_RAW}}
			{+END}
		</div>
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
</div>
