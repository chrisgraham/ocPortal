{+START,IF_NON_EMPTY,{RATINGS}}
	<div class="box box__ratings_show"><div class="box_inner">
		{+START,LOOP,RATINGS}
			<div class="vertical_alignment">
				{$,Visually show}
				{$SET,rating_loop,0}
				{+START,SET,rating_stars}{$ROUND,{$DIV_FLOAT,{RATING},2}}{+END}
				{+START,WHILE,{$LT,{$GET,rating_loop},{$GET,rating_stars}}}<img src="{$IMG*,icons/14x14/rating}" srcset="{$IMG*,icons/28x28/rating} 2x" {$?,{$EQ,{$GET,rating_loop},0},alt="{$GET,rating_stars}/5" title="{$GET,rating_stars}/5",alt=""} />{$INC,rating_loop}{+END}

				<span>{RATING_TIME_FORMATTED*},</span>

				<span>
					{+START,IF_NON_EMPTY,{RATING_USERNAME}}
						{!BY_SIMPLE,<a href="{$MEMBER_PROFILE_URL*,{RATING_MEMBER}}">{RATING_USERNAME*}</a>}
						{+START,INCLUDE,MEMBER_TOOLTIP}SUBMITTER={RATING_MEMBER}{+END}
					{+END}

					{+START,IF_EMPTY,{RATING_USERNAME}}
						{!BY_SIMPLE_LOWER,{RATING_USERNAME*}}
						{+START,IF,{$IS_STAFF}}
							<span class="associated_details">({RATING_IP*})</span>
						{+END}
					{+END}
				</span>
			</div>
		{+END}

		{+START,IF,{HAS_MORE}}
			<p>&hellip;</p>
		{+END}
	</div></div>
{+END}
