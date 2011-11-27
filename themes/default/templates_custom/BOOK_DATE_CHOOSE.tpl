{$JAVASCRIPT_INCLUDE,javascript_yahoo}
{$JAVASCRIPT_INCLUDE,javascript_yahoo_events}
{$JAVASCRIPT_INCLUDE,javascript_date_chooser}
{$CSS_INCLUDE,date_chooser}

{+START,INCLUDE,FORM_SCREEN_INPUT_DATE}
	STUB={NAME}
	NULL_OK=0
	TIME=
	UNLIMITED=0
	DAYS={$SET,day,1}{+START,WHILE,{$LT,{$GET,day},32}}<option value="{$GET*,day}"{+START,IF,{$EQ,{$GET,day},{CURRENT_DAY}}} selected="selected"{+END}>{$GET*,day}</option>{$INC,day}{+END}
	MONTHS={$SET,month,1}{+START,WHILE,{$LT,{$GET,month},13}}<option value="{$GET*,month}"{+START,IF,{$EQ,{$GET,month},{CURRENT_MONTH}}} selected="selected"{+END}>{$GET*,month}</option>{$INC,month}{+END}
	YEARS={$SET,year,{$FROM_TIMESTAMP,%Y}}{+START,WHILE,{$LT,{$GET,year},{$ADD,{MAX_DATE_YEAR},4}}}<option value="{$GET*,year}"{+START,IF,{$EQ,{$GET,year},{CURRENT_YEAR}}} selected="selected"{+END}>{$GET*,year}</option>{$INC,year}{+END}
	MIN_DATE_DAY={MIN_DATE_DAY}
	MIN_DATE_MONTH={MIN_DATE_MONTH}
	MIN_DATE_YEAR={MIN_DATE_YEAR}
	MAX_DATE_DAY={MAX_DATE_DAY}
	MAX_DATE_MONTH={MAX_DATE_MONTH}
	MAX_DATE_YEAR={MAX_DATE_YEAR}
{+END}
