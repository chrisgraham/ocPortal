<div class="left">
	{+START,IF,{HAS_RATINGS}}
		{+START,LOOP,ALL_RATING_CRITERIA}
			{+START,IF_NON_EMPTY,{TITLE}}
				<strong>{TITLE*}:</strong><br />
			{+END}
			{$SET,rating_loop,0}
			{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{RATING},2}}}}
				<img src="{$IMG*,rating}" title="" alt="{$ROUND,{$DIV_FLOAT,{RATING},2}}" />
				{$INC,rating_loop}
			{+END}
		{+END}
	{+END}
	{+START,IF,{$NOT,{HAS_RATINGS}}}
		<em>{!UNRATED}</em>
	{+END}
	&nbsp;

	<span class="associated_details"><em>{!VOTES,{OVERALL_NUM_RATINGS*}}</em></span>
	<span class="cedi_rating_inside">{RATING_FORM}</span>
</div>

