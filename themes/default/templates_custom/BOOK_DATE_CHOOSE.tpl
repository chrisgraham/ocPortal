{$JAVASCRIPT_INCLUDE,javascript_yahoo}
{$JAVASCRIPT_INCLUDE,javascript_date_chooser}

{+START,INCLUDE,FORM_SCREEN_INPUT_DATE}
	STUB={NAME}
	NULL_OK=0
	TIME=
	UNLIMITED=0
	DAYS={+START,LOOP,31}<option value="{_loop_var*}"{+START,IF,{$EQ,{_loop_var},{CURRENT_DAY}}} selected="selected"{+END}>{$INTEGER_FORMAT*,{_loop_var}}</option>{+END}
	MONTHS={+START,LOOP,12}<option value="{_loop_var*}"{+START,IF,{$EQ,{_loop_var},{CURRENT_MONTH}}} selected="selected"{+END}>{$INTEGER_FORMAT*,{_loop_var}}</option>{+END}
	YEARS={$SET,year,{$FROM_TIMESTAMP,%Y}}{+START,WHILE,{$LT,{$GET,year},{$ADD,{MAX_DATE_YEAR},3}}}<option value="{_loop_var*}"{+START,IF,{$EQ,{_loop_var},{CURRENT_YEAR}}} selected="selected"{+END}>{$INTEGER_FORMAT*,{_loop_var}}</option>{+END}
	MIN_DATE_DAY={MIN_DATE_DAY}
	MIN_DATE_MONTH={MIN_DATE_MONTH}
	MIN_DATE_YEAR={MIN_DATE_YEAR}
	MAX_DATE_DAY={MAX_DATE_DAY}
	MAX_DATE_MONTH={MAX_DATE_MONTH}
	MAX_DATE_YEAR={MAX_DATE_YEAR}
{+END}
