{+START,IF,{$EQ,{TITLE},{!GLOBAL_NAVIGATION}}}
<hr class="spaced_rule" />
{+END}

<nav class="do_next_section_wrap" role="navigation">
	{+START,IF_NON_EMPTY,{TITLE}}{+START,IF,{$NEQ,{$PAGE_TITLE},{TITLE}}}
		<h2>{TITLE}</h2>
	{+END}{+END}

	<div class="do_next_section">
		{CONTENT}
	</div>
</nav>
