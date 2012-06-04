{$,Make sure the system knows we have not rendered our primary title for this output yet}
{$SET,done_first_title,0}

{+START,IF,{$NOT,{$MOBILE}}}
	{$,By default the top panel contains the admin menu, community menu, member bar, etc}
	{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,top}}}
		<div id="panel_top">
			{$LOAD_PANEL,top}
		</div>
	{+END}

	{$,ocPortal may show little messages for you as it runs relating to what you are doing or the state the site is in}
	{+START,IF_NON_EMPTY,{$MESSAGES_TOP}}
		<div class="global_messages">
			{$MESSAGES_TOP}
		</div>
	{+END}

	{$,The main panels and content; float_surrounder contains the layout into a rendering box so that the footer etc can sit underneath}
	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,left}}}
			<div id="panel_left" class="global_side_panel" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
				{$LOAD_PANEL,left}
			</div>
		{+END}

		{$,Deciding whether/how to show the right panel requires some complex logic}
		{$SET,HELPER_PANEL_TUTORIAL,{$?,{$HAS_PRIVILEGE,see_software_docs},{$HELPER_PANEL_TUTORIAL}}}
		{$SET,helper_panel,{$OR,{$IS_NON_EMPTY,{$GET,HELPER_PANEL_TUTORIAL}},{$IS_NON_EMPTY,{$HELPER_PANEL_PIC}},{$IS_NON_EMPTY,{$HELPER_PANEL_HTML}},{$IS_NON_EMPTY,{$HELPER_PANEL_TEXT}}}}
		{+START,IF,{$OR,{$GET,helper_panel},{$IS_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}}}
			<div id="panel_right" class="global_side_panel{+START,IF_EMPTY,{$TRIM,{$LOAD_PANEL,right}}} helper_panel{+START,IF,{$HIDE_HELP_PANEL}} helper_panel_hidden{+END}{+END}" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
				{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
					{$LOAD_PANEL,right}
				{+END}

				{+START,IF_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
					{+START,INCLUDE,GLOBAL_HELPER_PANEL}{+END}
				{+END}
			</div>
		{+END}

		<article id="page_running_{$PAGE*}" class="zone_running_{$ZONE*} global_middle">
			{$,Breadcrumbs}
			{+START,IF_NON_EMPTY,{$BREADCRUMBS}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},:start}}{+START,IF,{$SHOW_HEADER}}
				<nav class="global_breadcrumbs breadcrumbs" itemprop="breadcrumb" role="navigation">
					<img class="breadcrumbs_img" src="{$IMG*,breadcrumbs}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
					{$BREADCRUMBS}
				</nav>
			{+END}{+END}{+END}

			{$,Associated with the SKIP_NAVIGATION link defined in HEADER.tpl}
			<a id="maincontent"></a>

			{$,The main site, whatever 'page' is being loaded}
			{MIDDLE}
		</article>

		{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,bottom}}}
			<div id="panel_bottom" role="complementary">
				{$LOAD_PANEL,bottom}
			</div>
		{+END}
	</div>

	{+START,IF_NON_EMPTY,{$MESSAGES_BOTTOM}}
		<div class="global_messages">
			{$MESSAGES_BOTTOM}
		</div>
	{+END}
{+END}

{+START,IF,{$MOBILE}}
	{+START,INCLUDE,GLOBAL_mobile}{+END}
{+END}

{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}
