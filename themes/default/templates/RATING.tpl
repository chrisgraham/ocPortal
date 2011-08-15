<div class="standardbox_spaced">
	{+START,BOX,{!RATING},,med}
		<div class="rating_inner"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/AggregateRating"}>
			{+START,IF_PASSED,_RATING}
				{+START,LOOP,_RATING}
					{+START,IF_NON_EMPTY,{TITLE}}
						<strong>{TITLE*}:</strong><br />
					{+END}
					{$SET,rating_loop,0}
					{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{RATING},2}}}}
						<img src="{$IMG*,rating}" title="" alt="{$ROUND,{$DIV_FLOAT,{RATING},2}}" />
						{$INC,rating_loop}
					{+END}
					<br />
				{+END}
			{+END}
			{+START,IF_NON_PASSED,_RATING}
				{!UNRATED}&nbsp;<br />
			{+END}
			{+START,IF,{$VALUE_OPTION,html5}}
				{!VOTES,<span itemprop="ratingCount">{NUM_RATINGS*}</span>}
				{+START,LOOP,_RATING}
					<meta itemprop="ratingValue" content="{RATING*}" />
				{+END}
			{+END}
			{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
				{!VOTES,{NUM_RATINGS*}}
			{+END}
		</div><br />
		
		{RATING_INSIDE}
	{+END}
</div>

