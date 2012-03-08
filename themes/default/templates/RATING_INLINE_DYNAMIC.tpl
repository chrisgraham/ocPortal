<span class="RATING_INLINE_DYNAMIC"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/AggregateRating"}>
	{$,Show the current result (nothing shows if nobody voted yet)}
	{+START,IF_PASSED,_RATING}
		{+START,LOOP,_RATING}
			{+START,INCLUDE,RATING_DISPLAY_SHARED}{+END}
		{+END}
		&nbsp;
	{+END}

	{RATING_FORM}
</span>
