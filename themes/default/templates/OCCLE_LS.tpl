<p class="lonely_label">{DIRECTORY*}:</p>
<ul>
	{$SET,listing,0}

	{+START,LOOP,DIRECTORIES}
		<li class="occle_dir" onclick="/*Access-note: code has other activation*/ var c=document.getElementById('occle_command'); c.value='cd &quot;{_loop_var;}&quot;'; click_link(c.nextSibling.nextSibling);">
			{_loop_var*}

			{+START,IF_NON_EMPTY,{MTIME}}
				<span class="associated_details">({!MODIFIED}: {MTIME*})</span>
			{+END}
			{+START,IF_NON_EMPTY,{FILESIZE}}
				<span class="associated_details">({!_FILE_SIZE}: {FILESIZE*})</span>
			{+END}
		</li>
		{$SET,listing,1}
	{+END}

	{+START,LOOP,FILES}
		<li class="occle_file">
			{_loop_var*}

			{+START,IF_NON_EMPTY,{MTIME}}
				<span class="associated_details">({!MODIFIED}: {MTIME*})</span>
			{+END}
			{+START,IF_NON_EMPTY,{FILESIZE}}
				<span class="associated_details">({!_FILE_SIZE}: {FILESIZE*})</span>
			{+END}
		</li>
		{$SET,listing,1}
	{+END}

	{+START,IF,{$NOT,{$GET,listing}}}
		<li class="nothing_here">
			{!NONE}
		</li>
	{+END}
</ul>
