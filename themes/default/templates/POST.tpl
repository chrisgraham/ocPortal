{+START,IF,{IS_SPACER_POST}}
	{POST}
{+END}

{+START,IF,{$NOT,{IS_SPACER_POST}}}
	{+START,BOX,,,light}
		<div id="post_{ID*}" class="post time_{TIME_RAW*}"{$?,{$VALUE_OPTION,html5}, itemprop="reviews" itemscope="itemscope" itemtype="http://schema.org/Review"}>
			{+START,IF_NON_EMPTY,{ID}}<a name="post_{ID*}" id="post_{ID*}"></a>{+END}

			{+START,IF_NON_EMPTY,{TITLE}}<h3 class="post_title">{TITLE*}</h3>{+END}
			{+START,IF_NON_EMPTY,{$AVATAR,{POSTER_ID}}}
				<img class="post_avatar" src="{$AVATAR*,{POSTER_ID}}" alt="{!AVATAR}" title="" />
			{+END}
			<div class="post_subline">
				{+START,IF_NON_PASSED,POSTER}
					{+START,IF_NON_EMPTY,{POSTER_URL}}{!BY_SIMPLE,<a class="post_poster" href="{POSTER_URL*}">{POSTER_NAME*}</a>},{+END}
					{+START,IF_EMPTY,{POSTER_URL}}{!BY_SIMPLE,{POSTER_NAME*}},{+END}
				{+END}
				{$,OCF style...}
				{+START,IF_PASSED,POSTER}
					<span class="post_poster">{POSTER}</span>
				{+END}

				<span class="post_time">
					{+START,IF,{$VALUE_OPTION,html5}}
						{!_POSTED_TIME,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{TIME_RAW}}" pubdate="pubdate">{TIME*}</time>}
					{+END}
					{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
						{!_POSTED_TIME,{TIME*}}
					{+END}
				</span>

				{+START,IF_NON_EMPTY,{EMPHASIS}}
					<span class="post_action_link">({EMPHASIS})</span>
				{+END}

				{+START,IF_NON_EMPTY,{UNVALIDATED}}
					<span class="post_action_link">({UNVALIDATED})</span>
				{+END}

				{+START,LOOP,INDIVIDUAL_REVIEW_RATINGS}
					{+START,IF_PASSED,REVIEW_RATING}
						&nbsp;
						(

						{+START,IF_NON_EMPTY,{REVIEW_TITLE}}
							{REVIEW_TITLE*}:
						{+END}

						{$SET,rating_loop,0}
						{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
							<img src="{$IMG*,rating}" title="" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
							{$INC,rating_loop}
						{+END}
					
						{+START,IF,{$VALUE_OPTION,html5}}
							<span itemprop="reviewRating" itemscope="itemscope" itemtype="http://schema.org/Rating"><meta itemprop="ratingValue" content="{REVIEW_RATING*}" /></span>
						{+END}
					)
					{+END}
				{+END}

				{+START,IF_PASSED,RATING}
					<span class="post_action_link">{RATING}</span>
				{+END}
			</div>

			<div{+START,IF,{HIGHLIGHT}} class="highlighted_post"{+END}{$?,{$VALUE_OPTION,html5}, itemprop="reviewBody"}>
				{POST}
			</div>

			{LAST_EDITED}

			{+START,IF_NON_EMPTY,{BUTTONS}}
				<div class="ocf_post_buttons">
					{BUTTONS}
				</div>
			{+END}

			{+START,IF_PASSED,CHILDREN}
				<div id="post_children_{ID*}" class="post_thread_children">
					{CHILDREN}
				</div>
			{+END}
			{+START,INCLUDE,POST_CHILD_LOAD_LINK}{+END}
		</div>
	{+END}
{+END}

<br />
