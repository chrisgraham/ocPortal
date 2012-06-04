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
	<hr class="spaced_rule" />
	<p class="community_block_tagline">
		{+START,LOOP,LINKS}
			{_loop_var}
		{+END}
	</p>
{+END}
