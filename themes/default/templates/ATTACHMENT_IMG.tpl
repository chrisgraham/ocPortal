{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}
	{+START,IF_EMPTY,{$META_DATA,image}}
		{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&for_session={$SESSION_HASHED}{+END}{+END}&no_count=1}
	{+END}
{+END}

<figure class="attachment">
	<figcaption>{!_ATTACHMENT}</figcaption>
	<div>
		{A_DESCRIPTION}
		<div class="attachment_details">
			<a rel="lightbox" target="_blank" title="{+START,IF_NON_EMPTY,{A_DESCRIPTION}}{A_DESCRIPTION*}: {+END}{!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}"><img {+START,IF,{$NEQ,{A_WIDTH}x{A_HEIGHT},240x216}}width="{A_WIDTH*}" height="{A_HEIGHT*}" {+END}src="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}&amp;thumb={A_THUMB*}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}{+END}&amp;no_count=1" {+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE} alt="{!IMAGE_ATTACHMENT,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}},{CLEAN_SIZE*}}"{+END}{+START,IF_PASSED_AND_TRUE,WYSIWYG_SAFE} alt="{A_DESCRIPTION*}"{+END} /></a>

			<ul class="actions_list" role="navigation"><li class="actions_list_strong"><a target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}{+END}{+END}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{+START,IF,{$INLINE_STATS}}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}{+END}{+END})</li></ul>
		</div>
	</div>
</figure>

