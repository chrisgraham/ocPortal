{TITLE}

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}">
	<div>
		<p>
			{!PAGE_MATCH_KEY_ACCESS_TEXT}
		</p>

		<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table solidborder specific_permissions">
			<colgroup>
				<col style="width: 250px" />
				{COLS}
				<col style="width: 35px" />
			</colgroup>

			<thead>
				<tr>
					<th></th>
					{HEADER_CELLS}
				</tr>
			</thead>

			<tbody>
				{ROWS}
			</tbody>
		</table></div>
		
		<h2>{!MATCH_KEY_MESSAGES}</h2>

		<p>
			{!PAGE_MATCH_KEY_MESSAGES_TEXT}
		</p>

		<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table solidborder specific_permissions">
			<colgroup>
				<col style="width: 250px" />
				<col style="width: 100%" />
			</colgroup>

			<thead>
				<tr>
					<th>{!MATCH_KEY}</th>
					<th>{!MESSAGE}</th>
				</tr>
			</thead>

			<tbody>
				{ROWS2}
			</tbody>
		</table></div>

		<br />
		<div class="proceed_button">
			<input onmouseover="this.form.disable_size_change=true;" onmouseout="this.form.disable_size_change=false;" accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
		</div>
	</div>
</form>

