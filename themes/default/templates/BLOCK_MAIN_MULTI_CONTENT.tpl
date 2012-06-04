{+START,IF_NON_EMPTY,{TITLE}}
	<h2>{TITLE*}</h2>
{+END}

{+START,IF_NON_EMPTY,{CONTENT}}
	{+START,LOOP,CONTENT}
		{_loop_var}
	{+END}
{+END}

{+START,IF_EMPTY,{CONTENT}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{+START,IF_NON_EMPTY,{SUBMIT_URL}{ARCHIVE_URL}}
	<ul class="horizontal_links associated_links_block_group">
		{+START,IF_NON_EMPTY,{SUBMIT_URL}}
			<li><a rel="add" href="{SUBMIT_URL*}">{!ADD}</a></li>
		{+END}
		{+START,IF_NON_EMPTY,{ARCHIVE_URL}}
			<li><a href="{ARCHIVE_URL*}" title="{!ARCHIVES}: {TYPE*}">{!ARCHIVES}</a></li>
		{+END}
	</ul>
{+END}
