{+START,IF_NON_PASSED,WYSIWYG_SAFE}
	{+START,IF_EMPTY,{$META_DATA,image}}
		{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
	{+END}
{+END}

<fieldset class="attachment">
<legend>{!_ATTACHMENT}</legend>
<div>
	{A_DESCRIPTION}
	<div class="attachment_details">
		<a rel="lightbox" target="_blank" title="{A_DESCRIPTION*}: {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}"><img {+START,IF,{$NEQ,{A_WIDTH}x{A_HEIGHT},240x216}}width="{A_WIDTH*}" height="{A_HEIGHT*}" {+END}class="no_alpha" src="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}&amp;thumb={A_THUMB*}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}&amp;no_count=1" title="" {+START,IF_NON_PASSED,WYSIWYG_SAFE} alt="{!IMAGE_ATTACHMENT,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}},{CLEAN_SIZE*}}"{+END}{+START,IF_PASSED,WYSIWYG_SAFE} alt="{A_DESCRIPTION*}"{+END} /></a><br />
		<span class="attachment_action">&raquo; <a target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}{+END}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}{+START,IF_NON_PASSED,WYSIWYG_SAFE}{+START,IF,{$INLINE_STATS}}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}{+END}{+END})</span>
	</div>
</div>
</fieldset>

