{+START,IF,{$NOT,{$_GET,in_main_include_module}}}
	<div class="float_surrounder">
		<div class="search_option"><label for="sd_{NAME*}">{DISPLAY*}:</label></div>
		<div class="constrain_field">
			<input class="wide_field search_option_value" type="text" id="sd_{NAME*}" name="{NAME*}" value="{SPECIAL*}" />
		</div>
	</div>

	{+START,SHIFT_ENCODE,search_options_message}
		<p class="associated_details">{!MAY_LEAVE_BLANK_ADVANCED}</p>
	{+END}

	{+START,SHIFT_ENCODE,search_template_help}
		<p><em>{!TEMPLATE_SEARCH_INFO}</em></p>
	{+END}
{+END}

{+START,IF,{$_GET,in_main_include_module}}
	{+START,SET,display}
		<div class="search_option"{+START,IF,{$EQ,{NAME},option__age_range}} style="width: auto"{+END}>
			{+START,IF,{$NEQ,{NAME},option__age_range}}
				<label for="sd_{NAME*}">{$TRUNCATE_LEFT,{DISPLAY},9,1}</label>
				<input class="wide_field search_option_value" type="text" id="sd_{NAME*}" name="{NAME*}" value="{SPECIAL*}" />
			{+END}
			{+START,IF,{$EQ,{NAME},option__age_range}}
				<label for="sd_{NAME*}_from">{$TRUNCATE_LEFT,{DISPLAY},9,1}<span class="accessibility_hidden"> (from)</span></label>
				<select id="sd_{NAME*}_from" name="{NAME*}_from">
					<option value="">(from)</option>
					{$SET,year,0}
					{+START,WHILE,{$LT,{$GET,year},120}}
						<option{+START,IF,{$PREG_MATCH,^{$GET,year}\-,{SPECIAL}}} selected="selected"{+END}>{$GET,year}</option>
						{$INC,year}
					{+END}
				</select>
				<label for="sd_{NAME*}_to" class="accessibility_hidden">{$TRUNCATE_LEFT,{DISPLAY},9,1} (to)</label>
				<select id="sd_{NAME*}_to" name="{NAME*}_to">
					<option value="">(to)</option>
					{$SET,year,0}
					{+START,WHILE,{$LT,{$GET,year},120}}
						<option{+START,IF,{$PREG_MATCH,\-{$GET,year}$,{SPECIAL}}} selected="selected"{+END}>{$GET,year}</option>
						{$INC,year}
					{+END}
				</select>
			{+END}
		</div>
	{+END}

	{+START,IF,{$PREG_MATCH,(^|\|){DISPLAY}($|\|),{$GET,fields_to_show_row_1}}}
		{+START,SET,row_1}
			{$GET,row_1}
			{$GET,display}
		{+END}
	{+END}
	{+START,IF,{$PREG_MATCH,(^|\|){DISPLAY}($|\|),{$GET,fields_to_show_row_2}}}
		{+START,SET,row_2}
			{$GET,row_2}
			{$GET,display}
		{+END}
	{+END}
{+END}
