{+START,IF_ARRAY_NON_EMPTY,CHILDREN}
	{+START,BOX,,,light}
		{!CHILD_PAGES}:
		{+START,LOOP,CHILDREN}
			<div class="category_entry">
				<div class="float_surrounder">
					&bull; <a href="{$PAGE_LINK*,{ZONE}:{PAGE}}">{TITLE}</a>
				</div>
			</div>
		{+END}
	{+END}
{+END}

{$SET,has_comcode_page_children_block,1}
