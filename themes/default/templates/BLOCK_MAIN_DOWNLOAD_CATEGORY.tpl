{+START,SET,DC_CONTENT}
	{+START,IF_NON_EMPTY,{SUBCATEGORIES}}
		{+START,BOX,{!SUBCATEGORIES_HERE}}
			{SUBCATEGORIES}
		{+END}
		{+START,IF_NON_EMPTY,{DOWNLOADS}}
			<br />
		{+END}
	{+END}

	{+START,IF_NON_EMPTY,{DOWNLOADS}}
		{DOWNLOADS}
	{+END}

	{+START,IF_NON_EMPTY,{SUBMIT_URL}}
		<p class="community_block_tagline">
			[ <a rel="add" href="{SUBMIT_URL*}">{!ADD_DOWNLOAD}</a> ]
		</p>
	{+END}
{+END}

{+START,IF,{$GET,in_panel}}
	{+START,BOX,{TITLE*},,panel}
		{$GET,DC_CONTENT}
	{+END}
{+END}

{+START,IF,{$NOT,{$GET,in_panel}}}
	<h2>{TITLE*}</h2>

	{$GET,DC_CONTENT}
{+END}
