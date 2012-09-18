{+START,IF_NON_EMPTY,{$MESSAGES_TOP}}
	<div class="global_messages">
		{$MESSAGES_TOP}
	</div>
{+END}

<div class="float_surrounder">
	{+START,IF,{$NOT,{$IS_GUEST}}}
		{+START,IF_NON_EMPTY,{$LOAD_PANEL,panel_top}}
			<div id="panel_top" role="complementary">
				{$LOAD_PANEL,panel_top}
			</div>
		{+END}
	{+END}

	<article id="page_running_{$PAGE*}" class="zone_running_{$ZONE*} global_middle">
		{+START,IF_NON_EMPTY,{$BREADCRUMBS}}{+START,IF,{$IN_STR,{$BREADCRUMBS},<a }}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},:start}}{+START,IF,{$SHOW_HEADER}}
			<nav class="global_breadcrumbs breadcrumbs" itemprop="breadcrumb" role="navigation">
				{$BREADCRUMBS}
			</nav>
		{+END}{+END}{+END}{+END}

		<a id="maincontent"> </a>

		{MIDDLE}
	</article>

	{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,left}{$LOAD_PANEL,right}}}
		<div class="global_middle">
			<hr class="spaced_rule" />

			<h2>{!NAVIGATION}</h2>
		</div>
	{+END}

	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,left}}}
			<div id="panel_left" class="global_side_panel{+START,IF_EMPTY,{$TRIM,{$LOAD_PANEL,right}}} panel_solo{+END}" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
				{$LOAD_PANEL,panel_left}
			</div>
		{+END}

		{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
			<div id="panel_right" class="global_side_panel{+START,IF_EMPTY,{$TRIM,{$LOAD_PANEL,left}}} panel_solo{+END}" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
				{$LOAD_PANEL,panel_right}
			</div>
		{+END}
	</div>

	{+START,IF_NON_EMPTY,{$LOAD_PANEL,panel_bottom}}
		<div id="panel_bottom" role="complementary">
			{$LOAD_PANEL,panel_bottom}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{$MESSAGES_BOTTOM}}
		<div class="global_messages">
			{$MESSAGES_BOTTOM}
		</div>
	{+END}
</div>
