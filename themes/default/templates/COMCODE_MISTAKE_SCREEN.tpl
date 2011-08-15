{TITLE}

{+START,BOX,{!COMCODE_ERROR_TITLE},,light}
	<p class="comcode_errored">
		{!COMCODE_ERROR,<a href="#errorat" target="_self">{MESSAGE}</a>,{LINE*}}
	</p>

	<div class="float_surrounder">
		<div class="comcode_error_help_div">
			<h2>{!WHAT_IS_COMCODE}</h2>

			{!COMCODE_ERROR_HELP_A}
		</div>

		<div class="comcode_error_details_div">
			{+START,IF,{EDITABLE}}
				<h2>{!FIXED_COMCODE}</h2>
	
				{FORM}
			{+END}
	
			<h2>{!ORIGINAL_COMCODE}</h2>
	
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder variable_table">
				<tbody>
					{LINES}
				</tbody>
			</table></div>
		</div>
	</div>

	<h2>{!REPAIR_HELP}</h2>
	
	<a name="help" id="help"></a>

	{!COMCODE_ERROR_HELP_B}
{+END}


