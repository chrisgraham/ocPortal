{+START,SET,media}
	<iframe width="{WIDTH*}" height="{HEIGHT*}" title="{!DOCUMENT}" class="gallery_pdf" src="{URL*}">{!DOCUMENT}</iframe>

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<figcaption class="associated_details">
			{DESCRIPTION}
		</figcaption>
	{+END}

	{$,Uncomment for a download link <ul class="actions_list" role="navigation"><li class="actions_list_strong"><a rel="enclosure" target="_blank" title="{!_DOWNLOAD,{ORIGINAL_FILENAME*}} {!LINK_NEW_WINDOW}" href="{URL*}">{!_DOWNLOAD,{ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}\{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE\}\{+START,IF,{$INLINE_STATS}\}\{+START,IF_PASSED,NUM_DOWNLOADS\}, {!DOWNLOADS_SO_FAR,{NUM_DOWNLOADS*}}\{+END\}\{+END\}\{+END\})</li></ul>}
{+END}
{+START,IF_PASSED_AND_TRUE,FRAMED}
	<figure>
		{$GET,media}
	</figure>
{+END}
{+START,IF_NON_PASSED_OR_TRUE,FRAMED}
	{$GET,media}
{+END}
