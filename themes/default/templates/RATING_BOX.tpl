<div class="RATING_BOX standardbox_spaced">
	{+START,BOX,{!RATING},,med}
		<div class="rating_inner"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/AggregateRating"}>
			{+START,IF_PASSED,_RATING}
				{+START,LOOP,_RATING}
					{+START,INCLUDE,RATING_DISPLAY_SHARED}{+END}
					<br />
				{+END}
			{+END}

			{+START,IF_NON_PASSED,_RATING}
				{!UNRATED}&nbsp;<br />
			{+END}

			{!VOTES,{NUM_RATINGS*}}
		</div>
		
		<br />
		
		{RATING_FORM}
	{+END}
</div>

