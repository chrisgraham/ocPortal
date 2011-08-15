{TITLE}

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}">
	<div>
		<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder specific_permissions">
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
	
		<input type="hidden" name="zone" value="{ZONE*}" />
	
		<br />
		<div class="proceed_button">
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
		</div>
	</div>
</form>

