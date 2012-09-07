{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
	<div id="{$GET*,wrapper_id}">
		{+START,SET,sorting}
			{+START,IF_NON_EMPTY,{SORTING}}
				<div class="box category_sorter inline_block"><div class="box_inner">
					{$SET,show_sort_button,1}
					{SORTING}
				</div></div>
			{+END}
		{+END}

		{+START,IF,{$CONFIG_OPTION,infinite_scrolling}}
			{$GET,sorting}
		{+END}

		{+START,IF_NON_EMPTY,{ENTRIES}}
			<div class="float_surrounder display_type_{DISPLAY_TYPE*} raw_grow_spot">
				{ENTRIES}
			</div>
		{+END}

		{+START,IF_EMPTY,{ENTRIES}}
			<p class="nothing_here">
				{!NO_ENTRIES}
			</p>
		{+END}

		{+START,IF,{$NOT,{$CONFIG_OPTION,infinite_scrolling}}}
			{$GET,sorting}
		{+END}

		{+START,IF_NON_EMPTY,{PAGINATION}}
			<div class="float_surrounder ajax_block_wrapper_links">
				{PAGINATION}
			</div>
		{+END}

		{+START,INCLUDE,AJAX_PAGINATION}{+END}
	</div>
{+END}

{+START,IF,{$EQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{ENTRIES}

	{PAGINATION}
{+END}
