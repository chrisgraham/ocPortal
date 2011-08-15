{+START,IF_NON_EMPTY,{CONTENT}}
	{+START,BOX,{!GALLERIES},,{$?,{$GET,in_panel},panel,classic}}
		<div class="side_galleries_block">
			{+START,IF,{$NOT,{DEPTH}}}
				<ul class="compact_list">{CONTENT}</ul>
			{+END}
			{+START,IF,{DEPTH}}
				{CONTENT}
			{+END}
		</div>
	{+END}
{+END}

