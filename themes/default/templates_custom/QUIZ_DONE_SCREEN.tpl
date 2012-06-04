{TITLE}

{+START,IF,{$NEQ,{TYPE},SURVEY}}
	<h2>{!_RESULTS}</h2>
{+END}

{$TRIM,{RESULT}}
{$TRIM,{CORRECTIONS_TO_SHOW}}

{+START,IF_NON_EMPTY,{MESSAGE}}
	{$PARAGRAPH,{MESSAGE}}
{+END}

{+START,IF,{$ADDON_INSTALLED,points}}
	{+START,IF,{$GT,{POINTS_DIFFERENCE},0}}
		<hr />

		<p>You have gained <strong>{$NUMBER_FORMAT*,{POINTS_DIFFERENCE}}</strong> points. Congrats!</p>
	{+END}
	{+START,IF,{$LT,{POINTS_DIFFERENCE},0}}
		<hr />

		<p>Oh dear, you have lost <strong>{$NUMBER_FORMAT*,{$MOD,{POINTS_DIFFERENCE}}}</strong> points.</p>
	{+END}
{+END}
