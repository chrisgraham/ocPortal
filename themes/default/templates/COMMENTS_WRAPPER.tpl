<div id="comments_wrapper"{$?,{$VALUE_OPTION,html5}, role="complementary"}>
	<br />

	{+START,SET,REVIEWS_TITLE}
		{!_REVIEWS,{$META_DATA*,numcomments}}:&nbsp;

		{$SET,rating_loop,0}
		{+START,LOOP,REVIEW_RATING_CRITERIA}
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

	{+START,SET,COMMENT_BOX_TITLE}
		<span class="right">
			{+START,INCLUDE,NOTIFICATION_BUTTONS}
				NOTIFICATIONS_TYPE=comment_posted
				NOTIFICATIONS_ID={TYPE}_{ID}
				BUTTON_TYPE=pageitem
			{+END}
		</span>
		{$?,{$IS_NON_EMPTY,{REVIEW_RATING_CRITERIA}},{$GET,REVIEWS_TITLE},{!COMMENTS}}
	{+END}

	{+START,BOX,{$GET,COMMENT_BOX_TITLE}}
		{+START,LOOP,REVIEW_RATING_CRITERIA}
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

			{+START,IF_EMPTY,{$TRIM,{COMMENTS}}}
				<p class="nothing_here">{!NO_COMMENTS}</p>
			{+END}
		</div>

		{+START,IF_PASSED,RESULTS_BROWSER}
			<div class="float_surrounder">
				{RESULTS_BROWSER}
			</div>
		{+END}
	{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,IF_NON_EMPTY,{AUTHORISED_FORUM_LINK}}
		{+START,INCLUDE,STAFF_ACTIONS}
			1_URL={AUTHORISED_FORUM_LINK*}
			1_TITLE={!VIEW_COMMENT_TOPIC}
		{+END}
	{+END}

	{$,If has commenting permission}
	{+START,IF_NON_EMPTY,{FORM}}
		<br />
		{+START,IF_PASSED,COMMENTS}<a name="last_comment" id="last_comment" rel="docomment"></a>{+END}
		{FORM}
	{+END}

	{+START,IF_PASSED,SERIALIZED_OPTIONS}{+START,IF_PASSED,HASH}
		<script type="text/javascript">// <![CDATA[
			window.comments_serialized_options='{SERIALIZED_OPTIONS;}';
			window.comments_hash='{HASH;}';
		//]]></script>
	{+END}{+END}
</div>
