{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
{+END}

{$CSS_INCLUDE,lightbox}
{$JAVASCRIPT_INCLUDE,javascript_prototype}
{$JAVASCRIPT_INCLUDE,javascript_scriptaculous}
{$JAVASCRIPT_INCLUDE,javascript_scriptaculous_builder}
{$JAVASCRIPT_INCLUDE,javascript_scriptaculous_effects}
{$JAVASCRIPT_INCLUDE,javascript_lightbox}

<div class="lightbox_thumb medborder">
	<a rel="lightbox" target="_blank" onmouseover="this.setAttribute('title',this.getAttribute('title').replace(/ {!LINK_NEW_WINDOW;}$/,''));" title="{A_DESCRIPTION*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{SUP_PARAMS*}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}"><img {+START,IF,{$NEQ,{A_WIDTH}x{A_HEIGHT},240x216}}width="{A_WIDTH*}" height="{A_HEIGHT*}" {+END}src="{SCRIPT*}?id={ID*}{SUP_PARAMS*}{$KEEP*,0,1}&amp;thumb={A_THUMB*}&amp;for_session={$SESSION_HASHED*}&amp;no_count=1" alt="{A_DESCRIPTION*}" title="{!IMAGE_ATTACHMENT,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}},{CLEAN_SIZE*}}" /></a>
</div>
