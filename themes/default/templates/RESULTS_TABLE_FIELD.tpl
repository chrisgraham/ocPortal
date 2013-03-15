<td>
	{$SET,edit_link,{$AND,{$NOT,{$IN_STR,{VALUE},<img,<p}},{$IN_STR,{VALUE},{!EDIT}</a>}}}
	{+START,IF,{$GET,edit_link}}<img src="{$IMG*,tableitem/edit}" alt="" /><strong>{VALUE}</strong>{+END}
	{+START,IF,{$NOT,{$GET,edit_link}}}{VALUE}{+END}
</td>
