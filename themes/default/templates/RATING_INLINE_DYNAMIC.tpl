<div class="RATING_INLINE_DYNAMIC" itemscope="itemscope" itemtype="http://schema.org/AggregateRating">
	{$,Show the current result (nothing shows if nobody voted yet)}
	{+START,IF,{HAS_RATINGS}}
		{+START,LOOP,ALL_RATING_CRITERIA}
			<span{+START,IF,{$NEQ,{_loop_key},0}} class="horiz_field_sep"{+END}>
				{+START,INCLUDE,RATING_DISPLAY_SHARED}{+END}
			</span>
		{+END}
	{+END}

	{$SET,block_embedded_forms,1}
	<div{+START,IF,{HAS_RATINGS}} class="horiz_field_sep"{+END}>
		{RATING_FORM}
	</div>
	{$SET,block_embedded_forms,0}
</div>
