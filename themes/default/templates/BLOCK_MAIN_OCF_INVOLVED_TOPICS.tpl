{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
	<div id="{$GET*,wrapper_id}">
		{TOPICS}

		{+START,INCLUDE,AJAX_PAGINATION}{+END}
	</div>
{+END}

{+START,IF,{$EQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{TOPICS}
{+END}
