<div class="box">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h4>{TITLE}</h4>
	{+END}

	<div class="box_inner">
		{CONTENT}
	</div>

	{+START,IF_NON_EMPTY,{META}}
		<div class="standardbox_meta_classic">
			{+START,LOOP,META}
				<div>{KEY}: {VALUE}</div>
			{+END}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{LINKS}}
		{$SET,linkbar,0}
		<div class="more">
			{+START,LOOP,LINKS}
				{+START,IF,{$GET,linkbar}} &middot; {+END}{_loop_var}{$SET,linkbar,1}
			{+END}
		</div>
	{+END}
</div>
