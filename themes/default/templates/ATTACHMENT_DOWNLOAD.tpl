<fieldset class="attachment">
<legend>{!_ATTACHMENT}</legend>
<div>
{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
{A_DESCRIPTION}<br />
{+END}
<span class="attachment_action">&raquo; <a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}: {!_ATTACHMENT} #{ID*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}">{!_DOWNLOAD,{A_ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}{+START,IF,{$INLINE_STATS}}{+START,IF_NON_EMPTY,{$ATTACHMENT_DOWNLOADS,{ID},{FORUM_DB_BIN}}}, {!DOWNLOADS_SO_FAR,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}}}{+END}{+END})</span>
</div>
</fieldset>

