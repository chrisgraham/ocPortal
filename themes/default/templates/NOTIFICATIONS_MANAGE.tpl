<p>
	{$?,{$MATCH_KEY_MATCH,_SEARCH:admin_notifications},{!NOTIFICATIONS_DEFINE_LOCKDOWN},{!NOTIFICATIONS_INTRO}}
</p>

<div class="wide_table_wrap"><table class="wide_table solidborder notifications_form" summary="{!COLUMNED_TABLE}">
	<colgroup>
		<col style="width: 100%" />
		{+START,IF_PASSED,SHOW_PRIVILEGES}
			<col style="width: 100px" />
		{+END}
		{+START,LOOP,NOTIFICATION_TYPES_TITLES}
			<col style="width: 40px" />
		{+END}
		<col style="width: 100px" />
	</colgroup>

	<thead>
		<tr>
			<th></th>
			{+START,IF_PASSED,SHOW_PRIVILEGES}
				<th><img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{!NOTIFICATION_PRIVILEGED},UL_ESCAPED}{$KEEP*}" title="{!NOTIFICATION_PRIVILEGED}" alt="{!NOTIFICATION_PRIVILEGED}" /></th>
			{+END}
			{+START,LOOP,NOTIFICATION_TYPES_TITLES}
				<th>
					<img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{LABEL},UL_ESCAPED}{$KEEP*}" title="{LABEL*}" alt="{LABEL*}" />
				</th>
			{+END}
			<th></th>
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,NOTIFICATION_SECTIONS}
			<tr>
				<th colspan="{+START,IF_PASSED,SHOW_PRIVILEGES}{$ADD*,{NOTIFICATION_TYPES_TITLES},3}{+END}{+START,IF_NON_PASSED,SHOW_PRIVILEGES}{$ADD*,{NOTIFICATION_TYPES_TITLES},2}{+END}">
					<h2>{NOTIFICATION_SECTION*}</h2>
				</th>
			</tr>

			{+START,LOOP,NOTIFICATION_CODES}
				<tr class="notification_code {$CYCLE*,zebra,zebra_0,zebra_1}">
					<th class="de_th dottedborder_barrier_b_nonrequired">{NOTIFICATION_LABEL*}</th>

					{+START,IF_PASSED,PRIVILEGED}
						<td class="dottedborder_barrier_b_nonrequired">{$?,{PRIVILEGED},{!YES},{!NO}}</td>
					{+END}

					{+START,INCLUDE,NOTIFICATION_TYPES}{+END}

					<td class="associated_details dottedborder_barrier_b_nonrequired">
						{+START,IF,{SUPPORTS_CATEGORIES}}
							[ <a onclick="return open_link_as_overlay(this,null,null,'_self');" href="{$PAGE_LINK*,_SEARCH:notifications:advanced:notification_code={NOTIFICATION_CODE}}">{!ADVANCED}</a> ]
						{+END}
					</td>
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>

{+START,IF_PASSED,AUTO_NOTIFICATION_CONTRIB_CONTENT}
	<h2>{!ocf:AUTO_NOTIFICATION_CONTRIB_CONTENT}</h2>

	<p>
		<label for="auto_monitor_contrib_content"><input {+START,IF,{AUTO_NOTIFICATION_CONTRIB_CONTENT}}checked="checked" {+END}type="checkbox" id="auto_monitor_contrib_content" name="auto_monitor_contrib_content" value="1" />
		{!ocf:DESCRIPTION_AUTO_NOTIFICATION_CONTRIB_CONTENT}</label>
	</p>
{+END}
