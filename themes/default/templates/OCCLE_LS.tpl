<p class="lonely_label">{DIRECTORY*}:</p>
<ul>
	{$SET,listing,0}

	{+START,LOOP,DIRECTORIES}
		<li class="occle_dir" onclick="/*Access-note: code has other activation*/ var c=document.getElementById('occle_command'); c.value='cd &quot;{FILENAME;*}&quot;'; click_link(c.nextSibling.nextSibling);">
			{FILENAME*}

			{+START,IF_NON_EMPTY,{FILESIZE}}
				<span class="occle_ls_associated_details">({!_FILE_SIZE}: {FILESIZE*})</span>
			{+END}
			{+START,IF_NON_EMPTY,{MTIME}}
				<span class="occle_ls_associated_details">({!MODIFIED}: {MTIME*})</span>
			{+END}
		</li>
		{$SET,listing,1}
	{+END}

	{+START,LOOP,FILES}
		<li class="occle_file" onclick="/*Access-note: code has other activation*/ var c=document.getElementById('occle_command'); c.value='cat &quot;{FILENAME;*}&quot;'; click_link(c.nextSibling.nextSibling);">
			{FILENAME*}

			{+START,IF_NON_EMPTY,{FILESIZE}}
				<span class="occle_ls_associated_details">({!_FILE_SIZE}: {FILESIZE*})</span>
			{+END}
			{+START,IF_NON_EMPTY,{MTIME}}
				<span class="occle_ls_associated_details">({!MODIFIED}: {MTIME*})</span>
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
