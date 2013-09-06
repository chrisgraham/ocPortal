<figure class="attachment">
	<figcaption>{!_ATTACHMENT}</figcaption>
	<div>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			{DESCRIPTION}
		{+END}

		<ul class="actions_list" role="navigation">
			<li class="actions_list_strong">
				<a {+START,IF,{$NOT,{$INLINE_STATS}}}onclick="return ga_track(this,'{!_ATTACHMENT;*}','{ORIGINAL_FILENAME;*}');" {+END}class="user_link" rel="enclosure" target="_blank" title="{!_DOWNLOAD,{ORIGINAL_FILENAME*}} {!LINK_NEW_WINDOW}" href="{URL*}">{!_DOWNLOAD,{ORIGINAL_FILENAME*}}</a>
				{+START,SET,stats}
					{+START,IF_NON_PASSED_OR_FALSE,WYSIWYG_SAFE}
						{+START,IF,{$INLINE_STATS}}
							{+START,IF_PASSED,NUM_DOWNLOADS}
								{!DOWNLOADS_SO_FAR,{NUM_DOWNLOADS*}}
							{+END}
						{+END}
					{+END}
				{+END}
				({CLEAN_SIZE*}{+START,IF_NON_EMPTY,{$GET,stats}}, {$TRIM,{$GET,stats}}{+END})
			</li>
		</ul>
	</div>
</figure>

