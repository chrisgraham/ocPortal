<span class="RATING_INLINE">
	{$,Show the current result (nothing shows if nobody voted yet)}
	{+START,IF_PASSED,_RATING}
		{+START,LOOP,_RATING}
			{+START,IF_NON_EMPTY,{TITLE}}
				<strong>{TITLE*}:</strong><br />
			{+END}

			{$,Visually show results}
			{$SET,rating_loop,0}
			{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{RATING},2}}}}
				<img src="{$IMG*,rating}" title="{!HAS_RATING,{$ROUND,{$DIV_FLOAT,{RATING},2}}}" alt="{!HAS_RATING,{$ROUND,{$DIV_FLOAT,{RATING},2}}}" />
				{$INC,rating_loop}
			{+END}

			{$,Semantics to show results}
			{+START,IF,{$VALUE_OPTION,html5}}
				<span itemscope="itemscope" itemtype="http://schema.org/AggregateRating">
					<meta itemprop="ratingCount" content="{$PREG_REPLACE*,[^\d],,{NUM_RATINGS}}" />
					{+START,LOOP,_RATING}
						<meta itemprop="ratingValue" content="{RATING*}" />
					{+END}
				</span>
			{+END}
			<br />
		{+END}
	{+END}
</span>
