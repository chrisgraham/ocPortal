<div class="standardbox_wrap_curved">
	<div class="standardbox_curved" style="{+START,IF,{$NEQ,{HEIGHT},auto}}min-height: {HEIGHT'}; {+END}width: {WIDTH'}">
		{+START,IF_NON_EMPTY,{TITLE}}
			<div class="standardbox_curved_title_left">
			<div class="standardbox_curved_title_right">
				<h3 class="standardbox_title_curved">{TITLE}</h3>
			</div>
			</div>
		{+END}
		{+START,IF_EMPTY,{TITLE}}
			<div class="standardbox_curved_nontitle_left">
			<div class="standardbox_curved_nontitle_right">
				<div class="standardbox_curved_nontitle_middle">&nbsp;</div>
			</div>
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{META}}
			<div class="standardbox_inner_curved standardbox_meta_classic">
				{+START,LOOP,META}
					<div>{KEY}: {VALUE}</div>
				{+END}
			</div>
		{+END}
		<div style="{$,padding-bottom: {$?,{$IS_NON_EMPTY,{LINKS}},0px,18px};} {+START,IF,{$NEQ,{HEIGHT},auto}}min-height: {$CSS_DIMENSION_REDUCE,{HEIGHT'},29}{+END}" class="standardbox_inner_curved standardbox_main_classic"><div class="float_surrounder">
			{CONTENT}

			{+START,IF_NON_EMPTY,{LINKS}}
				<div class="standardbox_inner_curved standardbox_links_classic community_block_tagline">
					{+START,LOOP,LINKS}
						{_loop_var}
					{+END}
				</div>
			{+END}
		</div></div>

		<div class="standardbox_curved_bottom_left">
		<div class="standardbox_curved_bottom_right">
			<div class="standardbox_curved_bottom_middle">&nbsp;</div>
		</div>
		</div>
	</div>
</div>
