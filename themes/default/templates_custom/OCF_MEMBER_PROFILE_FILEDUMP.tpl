{$BLOCK,block=myfiles,member_id={MEMBER_ID}}

{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,filedump}}
	<p class="community_block_tagline">[ <a href="{$PAGE_LINK*,_SEARCH:filedump:misc:place=/{$USERNAME&}/}">{!MORE}</a> ]</p>
{+END}
