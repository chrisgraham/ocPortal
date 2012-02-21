<div id="comments_wrapper">
	<br />

	{+START,IF_EMPTY,{COMMENTS}}
		<p class="nothing_here">{!NO_COMMENTS}</p>
	{+END}

	{+START,IF_NON_EMPTY,{COMMENTS}}
		{+START,SET,REVIEWS_TITLE}
			{!_REVIEWS,{$META_DATA*,numcomments}}:&nbsp;

			{$SET,rating_loop,0}
			{+START,LOOP,REVIEW_TITLES}
				{+START,IF_NON_EMPTY,{REVIEW_RATING}}
					{+START,IF_EMPTY,{REVIEW_TITLE}}
						{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
							<img src="{$IMG*,rating}" title="" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
							{$INC,rating_loop}
						{+END}
					{+END}
				{+END}
			{+END}
			{+START,IF,{$EQ,{$GET,rating_loop},0}}
				{!UNRATED}
			{+END}

			<span class="reviews_average">&nbsp;({!AVERAGE})</span>
		{+END}

		{+START,BOX,{$?,{$IS_NON_EMPTY,{REVIEW_TITLES}},{$GET,REVIEWS_TITLE},{!COMMENTS}}}
			{+START,LOOP,REVIEW_TITLES}
				{+START,IF_NON_EMPTY,{REVIEW_RATING}}
					{+START,IF_NON_EMPTY,{REVIEW_TITLE}}
						<p>
							<strong>{REVIEW_TITLE*}:</strong>
							{$SET,rating_loop,0}
							{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
								<img src="{$IMG*,rating}" title="" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
								{$INC,rating_loop}
							{+END}
						</p>
					{+END}
				{+END}
			{+END}

			<div class="comment_wrapper">
				{+START,IF,{$VALUE_OPTION,html5}}<meta itemprop="interactionCount" content="UserComments:{$META_DATA*,numcomments}" />{+END}
			
				{COMMENTS`}
			</div>
		
			{+START,IF_PASSED,RESULTS_BROWSER}
				{RESULTS_BROWSER}
			{+END}
		{+END}
	{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,IF_NON_EMPTY,{STAFF_FORUM_LINK}}
		{+START,INCLUDE,STAFF_ACTIONS}
			1_URL={STAFF_FORUM_LINK*}
			1_TITLE={!VIEW_COMMENT_TOPIC}
		{+END}
	{+END}

	{$,If has commenting permission}
	{+START,IF_NON_EMPTY,{FORM}}
		{FORM}
	{+END}

	{+START,INCLUDE,NOTIFICATION_BUTTONS}
		NOTIFICATIONS_TYPE=comment_posted
		NOTIFICATIONS_ID={TYPE}_{ID}
	{+END}
</div>
