{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<p>
	{!TEXT_REDIRECTS}
</p>

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}">
	<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table">
		<colgroup>
			<col style="width: 25%" />
			<col style="width: 25%" />
			<col style="width: 25%" />
			<col style="width: 25%" />
			<col style="width: 40px" />
			<col style="width: 40px" />
		</colgroup>

		<thead>
			<tr class="solidborder">
				<th>
					{!REDIRECT_FROM_ZONE}
				</th>
				<th>
					{!REDIRECT_FROM_PAGE}
				</th>
				<th>
					{!REDIRECT_TO_ZONE}
				</th>
				<th>
					{!REDIRECT_TO_PAGE}
				</th>
				<th>
					<abbr title="{!IS_TRANSPARENT_REDIRECT#}">{!REDIRECT_TRANS_SHORT}</abbr>
				</th>
				<th>
				</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="4">
					<h2>{!EXISTING_REDIRECTS}&hellip;</h2>
				</td>
			</tr>
			{FIELDS}
			<tr>
				<td colspan="4">
					<br /><h2>{!NEW_REDIRECT}&hellip;</h2>
				</td>
			</tr>
			{NEW}
		</tbody>
	</table></div>

	<br />
	<div class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
	</div>

	<br />
	{+START,BOX,{!NOTES},,light}
		<p>
			<label for="m_notes">{!NOTES_ABOUT_REDIRECTS}</label>
		</p>

		<div class="constrain_field">
			<textarea class="wide_field" id="m_notes" name="notes" cols="50" rows="10">{NOTES*}</textarea>
		</div>
	{+END}
</form>
