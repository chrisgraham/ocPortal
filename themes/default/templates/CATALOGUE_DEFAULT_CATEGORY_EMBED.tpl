{+START,IF_NON_EMPTY,{ENTRIES}}
	<div class="float_surrounder display_type_{DISPLAY_TYPE*}">
		{ENTRIES}
	</div>
{+END}

{+START,IF_EMPTY,{ENTRIES}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{SORTING}}
	<div class="box category_sorter inline_block"><div class="box_inner">
		{$SET,show_sort_button,1}
		{SORTING}
	</div></div>
{+END}

{+START,IF_NON_EMPTY,{PAGINATION}}
	<div class="float_surrounder">
		{PAGINATION}
	</div>
{+END}
