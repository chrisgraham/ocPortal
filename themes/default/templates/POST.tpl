{+START,BOX,,,light}
	<div id="post_{ID*}" class="post time_{TIME_RAW*}"{$?,{$VALUE_OPTION,html5}, itemprop="reviews" itemscope="itemscope" itemtype="http://schema.org/Review"}>
		{+START,IF_NON_EMPTY,{TITLE}}<h3 class="post_title">{TITLE*}</h3>{+END}
		{+START,IF_NON_EMPTY,{$AVATAR,{POSTER_ID}}}
			<img class="post_avatar" src="{$AVATAR*,{POSTER_ID}}" alt="{!AVATAR}" title="" />
		{+END}
		<div class="post_subline">
			{+START,IF_NON_EMPTY,{POSTER_LINK}}{!BY_SIMPLE,<a class="post_poster" href="{POSTER_LINK*}">{POSTER_NAME*}</a>}{+END}{+START,IF_EMPTY,{POSTER_LINK}}{!BY_SIMPLE,{POSTER_NAME*}}{+END},
			<span class="post_time">
				{+START,IF,{$VALUE_OPTION,html5}}
					{!_POSTED_TIME,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{TIME_RAW}}" pubdate="pubdate">{TIME*}</time>}
				{+END}
				{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
					{!_POSTED_TIME,{TIME*}}
				{+END}
			</span>

			{+START,IF_NON_EMPTY,{EDIT_URL}}
				<span class="post_action_link">(<a href="{EDIT_URL*}">{!EDIT}</a>)</span>
			{+END}

			{+START,IF_NON_PASSED,CHILDREN}
				{+START,IF,{$HAS_JS}}{+START,IF_PASSED,POST_COMCODE}
					<span class="post_action_link">(<a onclick="document.getElementById('post').focus(); document.getElementById('post').value='[quote=\'{POSTER_NAME*;}\']{POST_COMCODE*;}[/quote]\n\n'; return false;" href="#last_comment">{!ocf:QUOTE_POST}</a>)</span>
				{+END}{+END}
			{+END}

			{+START,IF_PASSED,RATING}
				<span class="post_action_link">{RATING}</span>
			{+END}

			{+START,LOOP,INDIVIDUAL_REVIEW_RATINGS}
				{+START,IF_PASSED,REVIEW_RATING}
					&nbsp;

					{+START,IF_NON_EMPTY,{REVIEW_TITLE}}
						&ndash; {REVIEW_TITLE*}:
					{+END}

					{$SET,rating_loop,0}
					{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
						<img src="{$IMG*,rating}" title="" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
						{$INC,rating_loop}
					{+END}
					
					{+START,IF,{$VALUE_OPTION,html5}}
						<div itemprop="reviewRating" itemscope="itemscope" itemtype="http://schema.org/Rating"><meta itemprop="ratingValue" content="{REVIEW_RATING*}" /></div>
					{+END}
				{+END}
			{+END}
		</div>

		<div{+START,IF,{HIGHLIGHT}} class="highlighted_post"{+END}{$?,{$VALUE_OPTION,html5}, itemprop="reviewBody"}>
			{POST}
		</div>

		{+START,IF_PASSED,CHILDREN}
			<p class="post_subline">
				{+START,IF,{$HAS_JS}}{+START,IF_PASSED,POST_COMCODE}
					<span class="post_action_link">(<a id="post_action_link_{ID*}" onclick="return threaded_reply(this,'{ID;}');" href="#last_comment">{!ocf:REPLY}</a>)</span>
				{+END}{+END}
			</p>
		{+END}

		{+START,IF_PASSED,CHILDREN}
			<div id="post_children_{ID*}" class="post_thread_children">
				{CHILDREN}
			</div>
		{+END}
		{+START,INCLUDE,POST_CHILD_LOAD_LINK}{+END}
	</div>
{+END}

<br />
