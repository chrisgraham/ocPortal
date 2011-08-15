{TITLE}

<p>{!PRIVACY_SETTINGS_INTRO}</p>

{+START,IF_EMPTY,{FIELDS}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{+START,IF_NON_EMPTY,{FIELDS}}
	<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{URL*}" enctype="multipart/form-data">
		<div>
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col style="width: 198px" />
						<col style="width: 100%" />
					</colgroup>
				{+END}

				<tbody>
					{FIELDS}
				</tbody>
			</table></div>

			{HIDDEN_FIELDS}

			{+START,INCLUDE,FORM_STANDARD_END}{+END}
		</div>
	</form>
{+END}
