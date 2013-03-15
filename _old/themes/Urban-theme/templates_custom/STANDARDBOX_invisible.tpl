<div class="standardbox_wrap_invisible">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h2>{TITLE}</h2>
	{+END}

	{+START,IF_NON_EMPTY,{META}}
		<div class="standardbox_meta_classic">
			{+START,LOOP,META}
				<div>{KEY}: {VALUE}</div>
			{+END}
		</div>
	{+END}

	{CONTENT}

	{+START,IF_NON_EMPTY,{LINKS}}
		{$SET,linkbar,0}
		<p class="community_block_tagline">
			{+START,LOOP,LINKS}
				{+START,IF,{$GET,linkbar}} | {+END}{_loop_var}{$SET,linkbar,1}
			{+END}
		</p>
	{+END}
</div>
