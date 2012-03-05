<p>
	{$?,{$MATCH_KEY_MATCH,_SEARCH:admin_notifications},{!NOTIFICATIONS_DEFINE_LOCKDOWN},{!NOTIFICATIONS_INTRO}}
</p>

<div class="wide_table"><table class="wide_table solidborder notifications_form">
	<colgroup>
		<col style="width: 100%" />
		{+START,LOOP,NOTIFICATION_TYPES_TITLES}
			<col style="width: 40px" />
		{+END}
		<col style="width: 100px" />
	</colgroup>

	<thead>
		<th></th>
		{+START,LOOP,NOTIFICATION_TYPES_TITLES}
			<th>
				<img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{LABEL},UL_ESCAPED}{$KEEP*}" title="{LABEL*}" alt="{LABEL*}" />
			</th>
		{+END}
		<th></th>
	</thead>

	<tbody>
		{+START,LOOP,NOTIFICATION_SECTIONS}
			<tr>
				<th colspan="{$ADD*,{NOTIFICATION_TYPES_TITLES},2}">
					<h2>{NOTIFICATION_SECTION*}</h2>
				</th>
			</tr>

			{+START,LOOP,NOTIFICATION_CODES}
				<tr class="notification_code">
					<th class="de_th">{NOTIFICATION_LABEL*}</th>

					{+START,INCLUDE,NOTIFICATION_TYPES}{+END}
					
					<td class="associated_details">
						{+START,IF,{SUPPORTS_CATEGORIES}}
							[ <a onclick="return open_link_as_overlay(this,null,null,'_self');" href="{$PAGE_LINK*,_SEARCH:notifications:advanced:notification_code={NOTIFICATION_CODE}}">{!ADVANCED}</a> ]
						{+END}
					</td>
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>
