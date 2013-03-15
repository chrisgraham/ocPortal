<figure class="attachment">
	<figcaption>{!_ATTACHMENT}</figcaption>
	<div>
		{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
			{A_DESCRIPTION}
		{+END}

		<ul class="actions_list" role="navigation"><li class="actions_list_strong"><a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!_ATTACHMENT} #{ID*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{+START,IF,{$INLINE_STATS}}{+START,IF_NON_EMPTY,{$ATTACHMENT_DOWNLOADS,{ID},{FORUM_DB_BIN}}}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}{+END}{+END}{+END})</li></ul>
	</div>
</figure>

