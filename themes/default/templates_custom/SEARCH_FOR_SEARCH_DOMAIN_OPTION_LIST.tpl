{+START,IF,{$NOT,{$_GET,in_main_include_module}}}
	<div class="float_surrounder">
		<div class="search_option"><label for="sd_{NAME*}">{DISPLAY*}:</label></div>
		<select id="sd_{NAME*}" name="{NAME*}">{SPECIAL}</select>
	</div>
{+END}

{+START,IF,{$_GET,in_main_include_module}}
	{+START,SET,display}
		<div class="search_option">
			<label for="sd_{NAME*}">{$TRUNCATE_LEFT,{DISPLAY},9,1}</label>
			<select class="wide_field" id="sd_{NAME*}" name="{NAME*}">{SPECIAL}</select>
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
