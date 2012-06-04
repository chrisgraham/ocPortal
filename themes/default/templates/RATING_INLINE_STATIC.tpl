<div class="RATING_INLINE_STATIC" itemscope="itemscope" itemtype="http://schema.org/AggregateRating">
	{$,Show the current result (nothing shows if nobody voted yet)}
	{+START,IF,{HAS_RATINGS}}
		{+START,LOOP,ALL_RATING_CRITERIA}
			<div{+START,IF,{$NEQ,{_loop_key},0}} class="horiz_field_sep"{+END}>
				{+START,INCLUDE,RATING_DISPLAY_SHARED}{+END}
			</div>
		{+END}
	{+END}
</div>
