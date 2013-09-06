{+START,SET,media}
	<embed src="{URL*}" type="image/svg+xml" width="{WIDTH*}" height="{HEIGHT*}" />

	{+START,IF_NON_PASSED_OR_FALSE,FRAMED}
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<figcaption class="associated_details">
				{DESCRIPTION}
			</figcaption>
		{+END}
	{+END}
{+END}
{+START,IF_PASSED_AND_TRUE,FRAMED}
	<figure class="attachment">
		<figcaption>{!IMAGE}</figcaption>
		<div>
			{DESCRIPTION}
			<div class="attachment_details">
				<a {+START,IF,{$NOT,{$INLINE_STATS}}}onclick="return ga_track(this,'{!IMAGE;*}','{ORIGINAL_FILENAME;*}');" {+END}rel="lightbox" target="_blank" title="{+START,IF_NON_EMPTY,{DESCRIPTION}}{DESCRIPTION*}: {+END}{!LINK_NEW_WINDOW}" href="{URL*}">{$TRIM,{$GET,media}}</a>

				<ul class="actions_list" role="navigation"><li class="actions_list_strong"><a target="_blank" title="{!_DOWNLOAD,{ORIGINAL_FILENAME*}}: {!LINK_NEW_WINDOW}" href="{URL*}">{!_DOWNLOAD,{ORIGINAL_FILENAME*}}</a> ({CLEAN_SIZE*}{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}{+START,IF,{$INLINE_STATS}}{+START,IF_PASSED,NUM_DOWNLOADS}, {!DOWNLOADS_SO_FAR,{NUM_DOWNLOADS*}}{+END}{+END}{+END})</li></ul>
			</div>
		</div>
	</figure>
{+END}
{+START,IF_NON_PASSED_OR_TRUE,FRAMED}
	{$GET,media}
{+END}
