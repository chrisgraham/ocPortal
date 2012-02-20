<p>
	{!NOTIFICATIONS_INTRO}
</p>

<div class="wide_table"><table class="wide_table solidborder notifications_form">
	<colgroup>
		<col style="width: 100%" />
		{+START,LOOP,NOTIFICATION_TYPES_TITLES}
			<col style="width: 40px" />
		{+END}
	</colgroup>

	<thead>
		<th></th>
		{+START,LOOP,NOTIFICATION_TYPES_TITLES}
			<th>
				<img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{LABEL},UL_ESCAPED}{$KEEP*}" title="{LABEL*}" alt="{LABEL*}" />
			</th>
		{+END}
	</thead>

	<tbody>
		{+START,LOOP,NOTIFICATION_CATEGORIES}
			<tr>
				<th colspan="{$ADD*,{NOTIFICATION_TYPES_TITLES},1}">
					<h2>{NOTIFICATION_CATEGORY*}</h2>
				</th>
			</tr>

			{+START,LOOP,NOTIFICATION_CODES}
				<tr class="notification_code">
					<th class="de_th">{NOTIFICATION_LABEL*}</th>

					{+START,INCLUDE,NOTIFICATION_TYPES}{+END}
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>
