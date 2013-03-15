<p>{DIRECTORY*}:</p>
<ul>
	{$SET,listing,0}
	{+START,LOOP,DIRECTORIES}<li class="occle_dir">{_loop_var*}</li>{$SET,listing,1}{+END}
	{+START,LOOP,FILES}<li class="occle_file">{_loop_var*}</li>{$SET,listing,1}{+END}
	{+START,IF,{$NOT,{$GET,listing}}}
	<li>{!NONE}</li>
	{+END}
</ul>
