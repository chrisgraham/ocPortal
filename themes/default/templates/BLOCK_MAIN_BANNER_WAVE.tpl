{+START,IF,{$EQ,{EXTRA},side}}
	<div class="banner_side">
		{ASSEMBLE}
	</div>
{+END}
{+START,IF,{$NEQ,{EXTRA},side}}
	<div>
		{ASSEMBLE}
	</div>
{+END}

