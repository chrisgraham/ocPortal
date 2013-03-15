<div {+START,IF_NON_EMPTY,{TITLE}}id="{TITLE|}" {+END}class="standardbox_classic {$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel}" style="height: {HEIGHT'}; width: {WIDTH'}">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h2 class="standardbox_title_panel">
			{TITLE}
		</h2>
	{+END}
	{+START,IF_NON_EMPTY,{META}}
		<div class="standardbox_meta_classic">
			{+START,LOOP,META}
				<div>{KEY}: {VALUE}</div>
			{+END}
		</div>
	{+END}
	<div class="standardbox_main_classic float_surrounder">
		{CONTENT}

		{+START,IF_NON_EMPTY,{LINKS}}
			{$SET,linkbar,0}
			<div class="{$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel} standardbox_links_classic community_block_tagline"> 
				{+START,LOOP,LINKS}
					{+START,IF,{$GET,linkbar}}  {+END}{_loop_var}{$SET,linkbar,1}
				{+END}
			 </div>
		{+END}
	</div>
</div>
