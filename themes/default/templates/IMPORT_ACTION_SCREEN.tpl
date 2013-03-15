{TITLE}

{+START,IF_EMPTY,{EXTRA}}
	<p>{!IMPORT_WARNING}</p>
{+END}

{+START,IF_NON_EMPTY,{EXTRA}}
	<ul>
		{EXTRA}
	</ul>
{+END}

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	{HIDDEN}

	<p>{!SELECT_TO_IMPORT}</p>
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table import_actions">
		<colgroup>
			<col style="width: 198px" />
			<col style="width: 100%" />
		</colgroup>

		<tbody>
			{IMPORT_LIST}
		</tbody>
	</table></div>

	<div class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!IMPORT}" />
	</div>
</form>

{+START,IF_NON_EMPTY,{MESSAGE}}
<p>{MESSAGE*}</p>
{+END}
