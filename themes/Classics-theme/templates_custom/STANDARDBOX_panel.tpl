<ul class="box1">
	{+START,IF_NON_EMPTY,{TITLE}}
		<li class="head">{TITLE}</li>
	{+END}
	<li>
		{+START,IF_NON_EMPTY,{META}}
			<div class="standardbox_meta_classic">
				{+START,LOOP,META}
					<div>{KEY}: {VALUE}</div>
				{+END}
			</div>
		{+END}

		{CONTENT}

		{+START,IF_NON_EMPTY,{LINKS}}
			{$SET,linkbar,_false}
			<div class="{$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel} standardbox_links_classic community_block_tagline"> 
				{+START,LOOP,LINKS}
					{+START,IF,{$GET,linkbar}} {+END}{_loop_var}{$SET,linkbar,_true}
				{+END}
			 </div>
		{+END}
	</li>
</ul>
