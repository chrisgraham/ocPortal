{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
{+END}

<fieldset class="attachment">
<legend>{!_ATTACHMENT}</legend>
<div>
	{A_DESCRIPTION}
	<div class="attachment_details">
		<a rel="lightbox" target="_blank" title="{A_DESCRIPTION*}: {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}"><img {+START,IF,{$NEQ,{A_WIDTH}x{A_HEIGHT},240x216}}width="{A_WIDTH*}" height="{A_HEIGHT*}" {+END}class="no_alpha" src="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;thumb={A_THUMB*}&amp;for_session={$SESSION_HASHED*}&amp;no_count=1" alt="{A_DESCRIPTION*}" title="{!IMAGE_ATTACHMENT,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}},{CLEAN_SIZE*}}" /></a><br />
		<span class="attachment_action">&raquo; <a target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}{+START,IF,{$INLINE_STATS}}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}{+END})</span>
	</div>
</div>
</fieldset>

