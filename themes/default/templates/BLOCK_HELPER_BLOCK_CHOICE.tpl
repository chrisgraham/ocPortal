<li>
	<a href="{URL*}">{LINK_CAPTION}</a>
	<br />

	<p>
		{DESCRIPTION}
		{+START,IF_NON_EMPTY,{USAGE}}
			<br />
			<strong>{!BLOCK_USED_BY}</strong>:
			<span class="associated_details">{+START,LOOP,USAGE}{+START,IF,{$NEQ,{_loop_key},0}}, {+END}<kbd>{_loop_var*}</kbd>{+END}</span>
		{+END}
	</p>

	<br />
</li>
