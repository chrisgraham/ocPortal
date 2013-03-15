{+START,IF_ARRAY_NON_EMPTY,CHILDREN}
	<div class="box box___block_main_comcode_page_children"><div class="box_inner">
		<p class="lonely_label">{!CHILD_PAGES}:</p>
		<ul class="category_list">
			{+START,LOOP,CHILDREN}
				<li>
					<div class="float_surrounder">
						&bull; <a href="{$PAGE_LINK*,{ZONE}:{PAGE}}">{TITLE}</a>
					</div>
				</li>
			{+END}
		</ul>
	</div></div>
{+END}

{$SET,has_comcode_page_children_block,1}
