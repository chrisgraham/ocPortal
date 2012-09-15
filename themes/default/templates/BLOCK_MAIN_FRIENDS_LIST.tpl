{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
	<div id="{$GET*,wrapper_id}">
		<p>{!DESCRIPTION_FRIENDS,{$USERNAME*,{MEMBER_ID}}}</p>

		{+START,IF_NON_EMPTY,{FRIENDS}}
			<div class="ocf_profile_friends raw_ajax_grow_spot">
				{+START,LOOP,FRIENDS}
					<div class="box"><div class="box_inner">
						{BOX}
					</div></div>
				{+END}
			</div>

			{+START,IF_NON_EMPTY,{PAGINATION}}
				<div class="pagination_spacing float_surrounder ajax_block_wrapper_links">
					{PAGINATION}
				</div>
			{+END}
		{+END}
		{+START,IF_EMPTY,{FRIENDS}}
			<p class="nothing_here">{!NO_ENTRIES}</p>
		{+END}

		{+START,INCLUDE,AJAX_PAGINATION}ALLOW_INFINITE_SCROLL=1{+END}
	</div>
{+END}

{+START,IF,{$EQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{+START,LOOP,FRIENDS}
		<div class="box"><div class="box_inner">
			{BOX}
		</div></div>
	{+END}

	{PAGINATION}
{+END}

