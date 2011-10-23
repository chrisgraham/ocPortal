<div class="box1">
	<div class="box1-top"></div>

	<div class="box1-mid">
		{+START,IF_NON_EMPTY,{TITLE}}
			<div class="head">
				{TITLE}
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{META}}
			<div class="standardbox_meta_classic">
				{+START,LOOP,META}
					<div>{KEY}: {VALUE}</div>
				{+END}
			</div>
		{+END}
		{CONTENT}
	</div>

	{+START,IF_NON_EMPTY,{LINKS}}
		{$SET,linkbar,0}
		<div class="{$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel} standardbox_links_classic community_block_tagline"> 
			{+START,LOOP,LINKS}
				{+START,IF,{$GET,linkbar}} {+END}{_loop_var}{$SET,linkbar,1}
			{+END}
		 </div>
	{+END}

	<div class="box1-bot"></div>
</div>
