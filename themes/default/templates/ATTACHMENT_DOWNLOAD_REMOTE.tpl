<figure>
	<a {+START,IF,{$NOT,{$INLINE_STATS}}}onclick="return ga_track(this,'{!_ATTACHMENT;*}','{A_ORIGINAL_FILENAME;*}');" {+END}class="user_link" rel="enclosure" target="_blank" title="{!DOWNLOAD_ATTACHMENT_REMOTE,{A_ORIGINAL_FILENAME*},{$ATTACHMENT_DOWNLOADS*,{ID}}}: {!LINK_NEW_WINDOW}" href="{A_URL*}">{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{!DOWNLOAD_ATTACHMENT_REMOTE,{A_ORIGINAL_FILENAME*},{$ATTACHMENT_DOWNLOADS*,{ID}}}{+END}{+START,IF_PASSED_AND_TRUE,WYSIWYG_SAFE}{A_ORIGINAL_FILENAME*}{+END}</a>

	{+START,IF_NON_EMPTY,{A_DESCRIPTION}}
		<figcaption class="associated_details">
			{A_DESCRIPTION}
		</figcaption>
	{+END}
</figure>
