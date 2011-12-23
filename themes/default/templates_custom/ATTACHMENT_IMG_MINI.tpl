{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
{+END}

<img src="{SCRIPT*}?id={ID*}{+START,IF_PASSED,SUP_PARAMS}{SUP_PARAMS*}{+END}{$KEEP*,0,1}&amp;thumb={A_THUMB*}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED*}" title="{A_DESCRIPTION*}" alt="{A_DESCRIPTION*}" />

{+START,IF,{$NEQ,{A_THUMB},0}}
	{+START,IF,{$HAS_ZONE_ACCESS,adminzone}}
		<p class="associated_link_to_small community_block_tagline">
			[ <a target="_blank" title="Choose thumbnail manually: {!LINK_NEW_WINDOW}" href="{$BASE_URL*}/data_custom/upload-crop/upload_crop_v1.2.php?file={$REPLACE*,{$BASE_URL}/,,{A_URL}}&amp;thumb={$REPLACE*,{$BASE_URL}/,,{A_THUMB_URL}}&amp;thumb_width={$CONFIG_OPTION*,thumb_width}&amp;thumb_height={$CONFIG_OPTION*,thumb_width}{$KEEP*,0,1}">Choose thumbnail manually</a> ]
		</p>
	{+END}
{+END}
