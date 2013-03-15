{+START,IF,{IS_SPACER_POST}}
	{+START,IF,{$NOT,{$IN_STR,{POST},<div}}}
		<div class="box box___post"><div class="box_inner">
			{POST}
		</div></div>
	{+END}

	{+START,IF,{$IN_STR,{POST},<div}}
		{POST}
	{+END}
{+END}

{+START,IF,{$NOT,{IS_SPACER_POST}}}
	<div class="box box___post{+START,IF,{HIGHLIGHT}} highlighted_post{+END}"><div class="box_inner">
		<div id="post_wrap_{ID*}" class="post time_{TIME_RAW*}" itemprop="reviews" itemscope="itemscope" itemtype="http://schema.org/Review">
			{+START,IF_NON_EMPTY,{ID}}<a id="post_{ID*}"></a>{+END}

			<div class="float_surrounder">
				{+START,IF_NON_EMPTY,{TITLE}}<h3 class="post_title" itemprop="name">{TITLE*}</h3>{+END}
				{+START,IF_NON_EMPTY,{$AVATAR,{POSTER_ID}}}
					<img class="post_avatar" src="{$AVATAR*,{POSTER_ID}}" alt="{!AVATAR}" />
				{+END}

				<div class="post_subline">
					{+START,IF_NON_EMPTY,{POSTER_URL}}{!BY_SIMPLE,<a class="post_poster" href="{POSTER_URL*}">{POSTER_NAME*}</a>} {+START,INCLUDE,MEMBER_TOOLTIP}SUBMITTER={POSTER_ID}{+END}{+END}
					{+START,IF_EMPTY,{POSTER_URL}}{!BY_SIMPLE,{POSTER_NAME*}},{+END}

					<span class="post_time">
						{!POSTED_TIME_SIMPLE_LOWER,<time itemprop="datePublished" datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{TIME_RAW}}" pubdate="pubdate">{TIME*}</time>}
					</span>

					{+START,IF_NON_EMPTY,{EMPHASIS}}
						<span class="post_action_link">({EMPHASIS})</span>
					{+END}

					{+START,IF_NON_EMPTY,{UNVALIDATED}}
						<span class="post_action_link">({UNVALIDATED})</span>
					{+END}

					{+START,LOOP,INDIVIDUAL_REVIEW_RATINGS}
						{+START,IF_PASSED,REVIEW_RATING}
							{+START,SET,REVIEWS}
								{+START,IF_NON_EMPTY,{REVIEW_TITLE}}
									<span class="field_title">{REVIEW_TITLE*}:</span>
								{+END}

								{$SET,rating_loop,0}
								{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}}}
									<img src="{$IMG*,rating}" alt="{$ROUND,{$DIV_FLOAT,{REVIEW_RATING},2}}" />
									{$INC,rating_loop}
								{+END}

								<span itemprop="reviewRating" itemscope="itemscope" itemtype="http://schema.org/Rating"><meta itemprop="ratingValue" content="{REVIEW_RATING*}" /></span>
							{+END}

							<span class="post_action_link">
								({$GET,REVIEWS})
							</span>
						{+END}
					{+END}

					{+START,IF_PASSED,RATING}
						<span class="post_action_link">{RATING}</span>
					{+END}

					{+START,IF,{$NOT,{$MOBILE}}}
						{+START,IF,{$JS_ON}}{+START,IF_NON_EMPTY,{ID}}{+START,IF_NON_PASSED_OR_FALSE,PREVIEWING}{+START,IF,{$MATCH_KEY_MATCH,_SEARCH:topicview}}
							<div id="cell_mark_{ID*}" class="ocf_off post_action_link inline_block">
								<form title="{!MARKER} #{ID*}" method="post" action="index.php" id="form_mark_{ID*}">
									<div>
										{+START,IF,{$NOT,{$IS_GUEST}}}<div class="accessibility_hidden"><label for="mark_{ID*}">{!MARKER} #{ID*}</label></div>{+END}{$,Guests don't see this so search engines don't; hopefully people with screen-readers are logged in}
										<input {+START,IF,{$NOT,{$IS_GUEST}}}title="{!MARKER} #{ID*}" {+END}value="1" type="checkbox" id="mark_{ID*}" name="mark_{ID*}" />
									</div>
								</form>
							</div>
						{+END}{+END}{+END}{+END}
					{+END}
				</div>

				<div itemprop="reviewBody">
					{POST}
				</div>

				{LAST_EDITED}
			</div>

			{+START,IF_NON_EMPTY,{BUTTONS}}
				<div class="post_buttons buttons_group">
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
	</div></div>
{+END}
