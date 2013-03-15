{TITLE}

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}">
	<div>
		<p>
			{!PAGE_MATCH_KEY_ACCESS_TEXT}
		</p>

		<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table results_table privileges">
			<colgroup>
				<col class="permission_field_name_column" />
				{COLS}
				<col class="permission_copy_column" />
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

		<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table results_table">
			<colgroup>
				<col class="permission_match_key_column" />
				<col class="permission_match_key_message_column" />
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

		<p class="proceed_button">
			<input onmouseover="this.form.disable_size_change=true;" onmouseout="this.form.disable_size_change=false;" accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
		</p>
	</div>
</form>

