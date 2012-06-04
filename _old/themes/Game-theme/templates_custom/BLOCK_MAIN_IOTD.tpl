<div class="hslice" id="iotd">
	{+START,BOX,<span class="entry-title">{!IOTD}</span>,,{$?,{$GET,in_panel},panel,curved},,,{$?,{$IS_NON_EMPTY,{SUBMIT_URL}},<a rel="add" href="{SUBMIT_URL*}">{!ADD_IOTD}</a>|,}<a rel="archives" href="{ARCHIVE_URL*}" title="{!VIEW_ARCHIVE}: {!IOTDS}">{!VIEW_ARCHIVE}</a>{$?,{$IS_NON_EMPTY,{FULL_URL}},|<a href="{FULL_URL*}" title="{!VIEW}: {!IOTD} #{ID*}">{!VIEW}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview}}}{+START,IF_PASSED,COMMENT_COUNT} <span class="associated_details">({$COMMENT_COUNT,iotds,{ID}})</span>{+END}{+END},}}
		<div class="entry-content">
			{CONTENT}
		</div>
	{+END}
</div>
