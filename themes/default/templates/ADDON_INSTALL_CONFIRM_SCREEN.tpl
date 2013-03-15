{TITLE}

{WARNINGS}

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	{+START,BOX,{!ADDON_FILES}}
		<div class="not_too_tall">
			<ul class="tick_list">
				{FILES}
			</ul>
		</div>
	{+END}

	<p class="proceed_button">
		<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" />
	</p>

	<h2>{!DETAILS}</h2>

	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table">
		<colgroup>
			<col style="width: 200px" />
			<col style="width: 100%" />
		</colgroup>

		<tbody>
			<tr>
				<th>{!NAME}</th>
				<td>{NAME*}</td>
			</tr>
			<tr>
				<th>{!AUTHOR}</th>
				<td>{AUTHOR*}</td>
			</tr>
			<tr>
				<th>{!ORGANISATION}</th>
				<td>{ORGANISATION*}</td>
			</tr>
			<tr>
				<th>{!_VERSION}</th>
				<td>{VERSION*}</td>
			</tr>
			<tr>
				<th>{!DESCRIPTION}</th>
				<td>{DESCRIPTION}</td>
			</tr>
		</tbody>
	</table></div>

	<input type="hidden" name="file" value="{FILE*}" />

	{+START,IF,{$JS_ON}}
	<p>
		<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
	</p>
	{+END}
</form>
