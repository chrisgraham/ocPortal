{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
{+END}

{+START,IF,{$EQ,{A_THUMB},1}}<a rel="lightbox" target="_blank" title="{A_DESCRIPTION*} {!LINK_NEW_WINDOW}" href="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}">{+END}<img class="no_alpha attachment_img" src="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;thumb={A_THUMB*}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}" title="{A_DESCRIPTION*}"{+START,IF,{$EQ,{A_THUMB},1}} alt="{!IMAGE_ATTACHMENT,{$ATTACHMENT_DOWNLOADS*,{ID},{FORUM_DB_BIN}},{CLEAN_SIZE*}}"{+END}{+START,IF,{$NEQ,{A_THUMB},1}} alt="{A_DESCRIPTION*}"{+END} />{+START,IF,{$EQ,{A_THUMB},1}}</a>{+END}

{+START,IF,{$NEQ,{A_THUMB},0}}
	{+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
		<p class="associated_link_to_small community_block_tagline">
			[ <a target="_blank" title="Choose thumbnail manually: {!LINK_NEW_WINDOW}" href="{$BASE_URL*}/data_custom/upload-crop/upload_crop_v1.2.php?file={$REPLACE*,{$BASE_URL}/,,{A_URL}}&amp;thumb={$REPLACE*,{$BASE_URL}/,,{A_THUMB_URL}}&amp;thumb_width={$CONFIG_OPTION*,thumb_width}&amp;thumb_height={$CONFIG_OPTION*,thumb_width}{$KEEP*,0,1}">Choose thumbnail manually</a> ]
		</p>
	{+END}
{+END}
