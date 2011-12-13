{+START,BOX,{!IMAGE}: {TITLE*}}
	<div><a href="{URL*}">{THUMB}</a></div>

	{+START,IF_NON_EMPTY,{TREE}}
		<p>{TREE}</p>
	{+END}
{+END}
