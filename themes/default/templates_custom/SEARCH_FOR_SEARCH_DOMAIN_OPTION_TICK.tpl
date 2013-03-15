{+START,IF,{$NOT,{$_GET,in_main_include_module}}}
	<div class="float_surrounder">
		<div class="search_option"><label for="sd_{NAME*}">{DISPLAY*}:</label></div>
		<input type="checkbox" class="search_option_value" id="sd_{NAME*}" name="{NAME*}" value="1" {+START,IF_NON_EMPTY,{SPECIAL}} checked="checked" {+END} />
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
		<div class="search_option">
			<label for="sd_{NAME*}">{$TRUNCATE_LEFT,{DISPLAY},9,1}</label>
			<input type="checkbox" class="search_option_value" id="sd_{NAME*}" name="{NAME*}" value="1" {+START,IF_NON_EMPTY,{SPECIAL}} checked="checked" {+END} />
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
