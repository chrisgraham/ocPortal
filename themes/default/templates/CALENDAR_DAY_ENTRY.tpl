<div class="calendar_day_entry">
	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{$IMG,{ICON}}}<img class="calendar_day_icon" src="{$IMG*,{ICON}}" title="{T_TITLE*}{+START,IF,{$NOT,{VALIDATED}}} &ndash; {!event_purchase:_NOT_YET}{+END}" alt="{T_TITLE*}" />{+END}
		<img class="calendar_day_priority" src="{$IMG*,{PRIORITY_ICON}}" title="{PRIORITY_LANG*}" alt="{PRIORITY_LANG*}" />
		<a title="{TITLE*}{+START,IF,{$NOT,{VALIDATED}}} &ndash; {!event_purchase:_NOT_YET}{+END}" href="{URL*}" class="calendar_day_entry_title">{+START,FRACTIONAL_EDITABLE,{TITLE},title,_SEARCH:cms_calendar:type=__ed:id={ID}}{TITLE*}{+END}</a>
		{+START,IF,{RECURRING}}{!REPEAT_SUFFIX}{+END}
		<span class="calendar_day_entry_time">{TIME*}</span>
	</div>

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div class="calendar_day_entry_description">
			{$TRUNCATE_SPREAD,{DESCRIPTION},{$MULT,{DOWN},20},,1}
		</div>
	{+END}
</div>
