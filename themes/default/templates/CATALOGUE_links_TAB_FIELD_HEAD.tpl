<th>
	{+START,IF,{$NEQ,{$PAGE},search}}
	{+START,IF_NON_EMPTY,{SORT_URL_ASC}}<a href="{SORT_URL_ASC*}"><img src="{$IMG*,results/{$?,{SORT_ASC_SELECTED},sortablefield_asc,sortablefield_asc_nonselected}}" alt="{!SORT_BY}, {!ASCENDING}" title="" /></a>{+END}
	{+END}
	{FIELD*}
	{+START,IF,{$NEQ,{$PAGE},search}}
	{+START,IF_NON_EMPTY,{SORT_URL_DESC}}<a target="_self" href="{SORT_URL_DESC*}"><img src="{$IMG*,results/{$?,{SORT_DESC_SELECTED},sortablefield_desc,sortablefield_desc_nonselected}}" alt="{!SORT_BY}, {!DESCENDING}" title="" /></a>{+END}
	{+END}
</th>

