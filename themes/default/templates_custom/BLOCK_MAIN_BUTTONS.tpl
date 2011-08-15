{+START,BOX,{TITLE*}}
{+START,IF,{$EQ,{EXTRA},side}}
	<div class="banner_side"{SET_HEIGHT}>
		{ASSEMBLE}
	</div>
{+END}
{+START,IF,{$NEQ,{EXTRA},side}}
	<div{SET_HEIGHT}>
		{ASSEMBLE}
	</div>
{+END}

{+END}

