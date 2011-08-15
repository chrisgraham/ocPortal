{TITLE}

{+START,IF,{$NEQ,{TYPE},SURVEY}}
<h2>{!_RESULTS}</h2>
{+END}

{$TRIM,{RESULT}}
{$TRIM,{CORRECTIONS_TO_SHOW}}

{+START,IF_NON_EMPTY,{MESSAGE}}
	{+START,IF_NON_EMPTY,{RESULT}}
		<br />
	{+END}
	{MESSAGE}
{+END}

{+START,IF,{$ADDON_INSTALLED,points}}
	{+START,IF,{$GT,{POINTS_DIFFERENCE},0}}
		<hr />

		You have gained <strong>{$NUMBER_FORMAT*,{POINTS_DIFFERENCE}}</strong> points. Congrats!
	{+END}
	{+START,IF,{$LT,{POINTS_DIFFERENCE},0}}
		<hr />

		Oh dear, you have lost <strong>{$NUMBER_FORMAT*,{$MOD,{POINTS_DIFFERENCE}}}</strong> points.
	{+END}
{+END}
