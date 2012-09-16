<div id="comments_wrapper" class="comments_wrapper" role="complementary">
	{+START,SET,REVIEWS_TITLE}
		<span class="field_title">{!_REVIEWS,{$META_DATA*,numcomments}}:</span>

		{$SET,rating_loop,0}
		{+START,LOOP,REVIEW_RATING_CRITERIA}
			{+START,IF_NON_EMPTY,{REVIEW_RATING}}
				{+START,IF_EMPTY,{REVIEW_TITLE}}
					{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
						<img src="{$IMG*,rating}" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
						{$INC,rating_loop}
					{+END}
				{+END}
			{+END}
		{+END}
		{+START,IF,{$EQ,{$GET,rating_loop},0}}
			{!UNRATED}
		{+END}

		<span class="reviews_average horiz_field_sep">({!AVERAGE})</span>
	{+END}

	{+START,SET,COMMENT_BOX_TITLE}
		<span class="right float_separation">
			{+START,INCLUDE,NOTIFICATION_BUTTONS}
				NOTIFICATIONS_TYPE=comment_posted
				NOTIFICATIONS_ID={TYPE}_{ID}
				BUTTON_TYPE=pageitem
			{+END}
		</span>

		<div class="inline right">
			<form class="inline" action="{$SELF_URL*}" method="post">
				<select onchange="this.form.submit();" id="comments_sort" name="comments_sort">
					<option {+START,IF,{$EQ,{SORT},relevance}}selected="selected" {+END}value="relevance">{!RELEVANCE}</option>
					<option {+START,IF,{$EQ,{SORT},newest}}selected="selected" {+END}value="newest">{!NEWEST_FIRST}</option>
					<option {+START,IF,{$EQ,{SORT},oldest}}selected="selected" {+END}value="oldest">{!OLDEST_FIRST}</option>
					<option {+START,IF,{$EQ,{SORT},average_rating}}selected="selected" {+END}value="average_rating">{!RATING}</option>
					<option {+START,IF,{$EQ,{SORT},compound_rating}}selected="selected" {+END}value="compound_rating">{!POPULARITY}</option>
				</select>

				{+START,IF,{$NOT,{$JS_ON}}}
					<input type="submit" value="{!SORT}" class="button_micro" />
				{+END}
			</form>
		</div>

		{$?,{$IS_NON_EMPTY,{REVIEW_RATING_CRITERIA}},{$GET,REVIEWS_TITLE},{!COMMENTS}}
	{+END}

	<div class="boxless_space">
		<div class="box box___comments_wrapper"><div class="box_inner">
			<h2>{$GET,COMMENT_BOX_TITLE}</h2>

			{+START,LOOP,REVIEW_RATING_CRITERIA}
				{+START,IF_NON_EMPTY,{REVIEW_RATING}}
					{+START,IF_NON_EMPTY,{REVIEW_TITLE}}
						<p>
							<strong>{REVIEW_TITLE*}:</strong>
							{$SET,rating_loop,0}
							{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
								<img src="{$IMG*,rating}" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
								{$INC,rating_loop}
							{+END}
						</p>
					{+END}
				{+END}
			{+END}

			<div class="comment_wrapper">
				<meta itemprop="interactionCount" content="UserComments:{$META_DATA*,numcomments}" />

				{COMMENTS`}

				{+START,IF_EMPTY,{$TRIM,{COMMENTS}}}
					<p class="nothing_here">{!NO_COMMENTS}</p>
				{+END}
			</div>

			{+START,IF_PASSED,PAGINATION}
				<div class="float_surrounder">
					{PAGINATION}
				</div>
			{+END}
		</div></div>

		{$,If has commenting permission}
		{+START,IF_NON_EMPTY,{FORM}}
			{+START,IF_PASSED,COMMENTS}<a id="last_comment" rel="docomment"></a>{+END}

			{FORM}
		{+END}

		{+START,IF_PASSED,SERIALIZED_OPTIONS}{+START,IF_PASSED,HASH}
			<script type="text/javascript">// <![CDATA[
				window.comments_serialized_options='{SERIALIZED_OPTIONS;}';
				window.comments_hash='{HASH;}';
			//]]></script>
		{+END}{+END}
	</div>

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,IF_NON_EMPTY,{AUTHORISED_FORUM_URL}}
		{+START,INCLUDE,STAFF_ACTIONS}
			STAFF_ACTIONS_TITLE={!COMMENTS}
			1_URL={AUTHORISED_FORUM_URL*}
			1_TITLE={!VIEW_COMMENT_TOPIC}
		{+END}
	{+END}
</div>
