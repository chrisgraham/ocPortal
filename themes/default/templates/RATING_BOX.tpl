<div class="RATING_BOX standardbox_spaced">
	{+START,BOX,{!RATING},,med}
		<div class="rating_inner"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/AggregateRating"}>
			{+START,IF,{HAS_RATINGS}}
				{+START,LOOP,ALL_RATING_CRITERIA}
					{+START,INCLUDE,RATING_DISPLAY_SHARED}{+END}

					{+START,IF,{$OR,{LIKES},{$IS_EMPTY,{$TRIM,{RATING_FORM}}}}}
						<br />
					{+END}
				{+END}
			{+END}

			{+START,IF,{$NOT,{HAS_RATINGS}}}
				<meta itemprop="ratingCount" content="0" />
				<meta itemprop="ratingValue" content="3" />

				<em>{!UNRATED}</em>
			{+END}

			{+START,IF,{HAS_RATINGS}}
				{!VOTES,{OVERALL_NUM_RATINGS*}}
			{+END}
		</div>

		{$,We do not show errors for likes as it is too informal to go into details}
		{+START,IF,{$NOT,{LIKES}}}
			{+START,IF_NON_EMPTY,{ERROR}}
				{ERROR}
			{+END}
		{+END}

		{+START,IF_EMPTY,{ERROR}}
			<br />
		{+END}
		{RATING_FORM}
	{+END}
</div>

