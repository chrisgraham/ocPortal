{$BLOCK,block=myfiles}

{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,filedump}}
	<p class="associated_link associated_links_block_group"><a href="{$PAGE_LINK*,_SEARCH:filedump:misc:place=/{$USERNAME&}/}">{!MORE}</a></p>
{+END}
