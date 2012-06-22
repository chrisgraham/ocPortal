{+START,IF,{$EQ,{TITLE},{!GLOBAL_NAVIGATION}}}
<hr class="spaced_rule" />
{+END}

<nav class="do_next_section_wrap" role="navigation">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h2>{TITLE}</h2>
	{+END}

	<div class="do_next_section">
		{CONTENT}
	</div>
</nav>
