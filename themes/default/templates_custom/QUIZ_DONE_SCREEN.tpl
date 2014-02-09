{TITLE}

<p>
	{RESULT}
</p>

{+START,IF_NON_EMPTY,{MESSAGE}}
	{$PARAGRAPH,{MESSAGE}}
{+END}

{+START,IF,{REVEAL_ANSWERS}}
	{+START,INCLUDE,QUIZ_RESULTS}{+END}
{+END}

{+START,IF,{$NOT,{REVEAL_ANSWERS}}}
	{+START,IF_NON_EMPTY,{CORRECTIONS}}
		<ul>
			{CORRECTIONS}
		</ul>
	{+END}
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
