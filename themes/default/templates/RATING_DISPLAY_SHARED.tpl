{$,Semantics to show results}
{+START,IF,{$VALUE_OPTION,html5}}
	<meta itemprop="ratingCount" content="{$PREG_REPLACE*,[^\d],,{NUM_RATINGS}}" />
	<meta itemprop="ratingValue" content="{RATING*}" />
{+END}

{$,Shows only if no rating form [which build in result display] or if likes enabled [shows separate stars results and form]}
{+START,IF,{$OR,{LIKES},{$IS_EMPTY,{$TRIM,{RATING_FORM}}}}}
	{+START,IF_NON_EMPTY,{TITLE}}
		<strong>{TITLE*}:</strong><br />
	{+END}

	{$,Visually show results}
	{$SET,rating_loop,0}
	{+START,WHILE,{$LT,{$GET,rating_loop},{$ROUND,{$DIV_FLOAT,{RATING},2}}}}<img src="{$IMG*,rating}" {+START,IF,{$EQ,{$GET,rating_loop},0}}title="{!HAS_RATING,{$ROUND,{$DIV_FLOAT,{RATING},2}}}" {+END}alt="{+START,IF,{$EQ,{$GET,rating_loop},0}}{!HAS_RATING,{$ROUND,{$DIV_FLOAT,{RATING},2}}}{+END}" />{$INC,rating_loop}{+END}
	{+START,IF,{LIKES}}{+START,IF_PASSED,LIKED_BY}{+START,IF_NON_EMPTY,{LIKED_BY}}
		{$SET,done_one_liker,0}
		{+START,LOOP,LIKED_BY}{+START,IF_NON_EMPTY,{$AVATAR,{MEMBER_ID}}}{+START,IF,{$NOT,{$GET,done_one_liker,0}}}({+END}<a href="{$MEMBER_PROFILE_LINK*,{MEMBER_ID}}"><img width="10" height="10" src="{$AVATAR*,{MEMBER_ID}}" title="{!LIKED_BY} {USERNAME*}" alt="{!LIKED_BY} {USERNAME*}" /></a>{$SET,done_one_liker,1}{+END}{+END}{+START,IF,{$GET,done_one_liker,0}}){+END}
	{+END}{+END}{+END}
{+END}
