<th class="permission_header_cell">
	{+START,IF,{$EQ,{GROUP},+/-}}
		{GROUP*}
	{+END}
	{+START,IF,{$NEQ,{GROUP},+/-}}
		<img src="{$BASE_URL*}/data/gd_text.php?color={COLOR*}&amp;text={$ESCAPE,{GROUP},UL_ESCAPED}{$KEEP*}" title="{GROUP*}" alt="{GROUP*}" />
	{+END}
</th>
