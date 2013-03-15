{$,Make sure the system knows we haven't rendered our primary title for this output yet}
{$SET,done_first_title,0}

{$,Will the helper-panel be shown?}
{$SET,HELPER_PANEL_TUTORIAL,{$?,{$HAS_SPECIFIC_PERMISSION,see_software_docs},{HELPER_PANEL_TUTORIAL}}}
{$SET,helper_panel,{$OR,{$IS_NON_EMPTY,{$GET,HELPER_PANEL_TUTORIAL}},{$IS_NON_EMPTY,{HELPER_PANEL_PIC}},{$IS_NON_EMPTY,{HELPER_PANEL_HTML}},{$IS_NON_EMPTY,{HELPER_PANEL_TEXT}}}}

{+START,IF,{$NOT,{$MOBILE}}}
	{$,Work out the panel/central CSS widths}
	{$SET,left_width,{$?,{$IS_EMPTY,{$TRIM,{$GET,panel_left}}},0,{$PANEL_WIDTH_SPACED'}}}
	{$SET,right_width,{$?,{$IS_EMPTY,{$TRIM,{$GET,panel_right}}},{$?,{$GET,helper_panel},{$?,{$HIDE_HELP_PANEL},26px,275px},0},{$PANEL_WIDTH_SPACED'}}}
	{$SET,middle_width,auto}

	<div class="float_surrounder_precise" id="global_surround">
		{+START,IF_NON_EMPTY,{$GET,panel_top}}
			<div id="other_panel_top">
				{$GET,panel_top}
			</div>
		{+END}

		{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
			<div class="global_message">
				{MESSAGE_TOP}
			</div>
		{+END}{+END}

		<div class="top_level_wrap">
			{+START,IF,{$NEQ,{$GET,left_width},0,auto}}
				<div id="panel_left" style="width: {$GET,left_width}" class="global_side"{$?,{$VALUE_OPTION,html5}, role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar"}>
					{$GET,panel_left}
				</div>
			{+END}
			{+START,IF,{$NEQ,{$GET,right_width},0,auto}}
				<div id="panel_right" style="width: {$GET,right_width}" class="global_side"{$?,{$VALUE_OPTION,html5}, role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar"}>{+START,IF,{$GET,helper_panel}}{+START,IF_EMPTY,{$GET,panel_right}}<div class="global_helper_panel_wrap">{+END}{+END}
					{$GET,panel_right}
					{+START,IF,{$GET,helper_panel}}{+START,IF_EMPTY,{$GET,panel_right}}
						{+START,IF,{$NOT,{$HIDE_HELP_PANEL}}}
						<a id="helper_panel_toggle" href="#" onclick="return help_panel(false);"><img title="{!HELP_OR_ADVICE}: {!HIDE}" alt="{!HELP_OR_ADVICE}: {!HIDE}" src="{$IMG*,help_panel_hide}" /></a>
						{+END}
						{+START,IF,{$HIDE_HELP_PANEL}}
						<a id="helper_panel_toggle" href="#" onclick="return help_panel(true);"><img title="{!HELP_OR_ADVICE}: {!SHOW}" alt="{!HELP_OR_ADVICE}: {!SHOW}" src="{$IMG*,help_panel_show}" /></a>
						{+END}

						<div id="helper_panel_contents"{+START,IF,{$HIDE_HELP_PANEL}} style="display: none"{$?,{$VALUE_OPTION,html5}, aria-expanded="false"}{+END}>
							<h2>{!HELP_OR_ADVICE}</h2>

							<div class="global_helper_panel">
								{+START,IF_NON_EMPTY,{HELPER_PANEL_TEXT}}
									{+START,BOX,,235px,curved}
										<div id="help" class="global_helper_panel_text">{HELPER_PANEL_TEXT}</div>
									{+END}
									<br />
								{+END}
								{+START,IF_NON_EMPTY,{$GET,HELPER_PANEL_TUTORIAL}}
									<div id="help_tutorial">
										{+START,BOX,,235px,curved}
											<div class="global_helper_panel_text">{$URLISE_LANG,{!TUTORIAL_ON_THIS},{$BRAND_BASE_URL*}/docs{$VERSION*}/pg/{$GET*,HELPER_PANEL_TUTORIAL},,1}</div>
										{+END}
										<br />
									</div>
								{+END}
								{+START,IF_EMPTY,{HELPER_PANEL_HTML}{HELPER_PANEL_TEXT}{$GET,HELPER_PANEL_TUTORIAL}}
									<div id="help">
										{+START,BOX,,250px,curved}
											<p>{!NO_HELP_HERE}</p>
										{+END}
										<br />
									</div>
								{+END}
								{+START,IF_NON_EMPTY,{HELPER_PANEL_PIC}}{+START,IF_EMPTY,{HELPER_PANEL_HTML}}
									<div id="global_helper_panel_pic" class="global_helper_panel_pic"><img width="220" alt="" src="{$IMG*,{HELPER_PANEL_PIC}}" /></div>
								{+END}{+END}
								{+START,IF_NON_EMPTY,{HELPER_PANEL_HTML}}
									<div class="global_helper_panel_html">
										{HELPER_PANEL_HTML}
									</div>
								{+END}
							</div>
						</div>
					{+END}{+END}
				</div>{+START,IF,{$GET,helper_panel}}{+START,IF_EMPTY,{$GET,panel_right}}</div>{+END}{+END}
			{+END}
			<{$?,{$VALUE_OPTION,html5},article,div}{$?,{$VALUE_OPTION,html5}, role="main article"} id="page_running_{$PAGE*}" class="zone_running_{$ZONE*} global_middle dequirk" style="width: {$GET,middle_width}{+START,IF,{$NEQ,{$GET,left_width},0}}; padding-{!en_left}: 10px; margin-{!en_left}: {$GET,left_width}{+END}{+START,IF,{$NEQ,{$GET,right_width},0}}; padding-{!en_right}: 10px; margin-{!en_right}: {$GET,right_width}{+END}">
				<div id="global_middle_ph">
					{+START,IF_NON_EMPTY,{BREADCRUMBS}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},:start}}
						<{$?,{$VALUE_OPTION,html5},nav,div} class="breadcrumbs breadcrumbs_always"{$?,{$VALUE_OPTION,html5}, itemprop="breadcrumb" role="navigation"}>
							<img class="breadcrumbs_img" src="{$IMG*,treenav}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
							{BREADCRUMBS}
						</{$?,{$VALUE_OPTION,html5},nav,div}>
					{+END}{+END}

					<a name="maincontent" id="maincontent"></a>
					{MIDDLE}
				</div>
			</{$?,{$VALUE_OPTION,html5},article,div}>
		</div>
		{+START,IF_NON_EMPTY,{$TRIM,{$GET,panel_bottom}}}
			<div id="panel_bottom"{$?,{$VALUE_OPTION,html5}, role="complementary"}>
				{$GET,panel_bottom}
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{MESSAGE}}
			<div class="top_level_wrap">
				<div id="global_message" style="width: {$GET,middle_width}{+START,IF,{$NEQ,{$GET,left_width},0}}; margin-{!en_left}: {$GET,left_width}{+END}{+START,IF,{$NEQ,{$GET,right_width},0}}; margin-{!en_right}: {$GET,right_width}{+END}" class="global_message">
					{MESSAGE}
				</div>
			</div>
		{+END}
	</div>
{+END}

{+START,IF,{$MOBILE}}
	{$,Work out the panel/central CSS widths}
	{$SET,left_width,{$?,{$IS_EMPTY,{$TRIM,{$GET,panel_left}}},0,{$PANEL_WIDTH_SPACED'}}}
	{$SET,right_width,{$?,{$IS_EMPTY,{$TRIM,{$GET,panel_right}}},0,{$PANEL_WIDTH_SPACED'}}}
	{$SET,middle_width,auto}

	<div class="float_surrounder_precise" id="global_surround">
		{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
			<div class="global_message">
				{MESSAGE_TOP}
			</div>
		{+END}{+END}
		<div class="top_level_wrap">
			<div id="page_running_{$PAGE*}" class="zone_running_{$ZONE*} global_middle dequirk"{$?,{$VALUE_OPTION,html5}, role="main article"}>
				<{$?,{$VALUE_OPTION,html5},article,div} id="global_middle_ph">
					{+START,IF_NON_EMPTY,{BREADCRUMBS}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},:start}}
						<{$?,{$VALUE_OPTION,html5},nav,div} class="breadcrumbs breadcrumbs_always"{$?,{$VALUE_OPTION,html5}, itemprop="breadcrumb" role="navigation"}>
							{BREADCRUMBS}
						</{$?,{$VALUE_OPTION,html5},nav,div}>
						<br />
					{+END}{+END}

					<a name="maincontent" id="maincontent"> </a>
					{MIDDLE}
				</{$?,{$VALUE_OPTION,html5},article,div}>
			</div>
			<div class="float_surrounder">
				{+START,IF,{$NEQ,{$GET,left_width},0,auto}}
					<div id="panel_left" class="global_side"{$?,{$VALUE_OPTION,html5}, role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar"}>
						{$GET,panel_left}
					</div>
				{+END}
				{+START,IF,{$NEQ,{$GET,right_width},0,auto}}
					<div id="panel_right" class="global_side"{$?,{$VALUE_OPTION,html5}, role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar"}>{+START,IF,{$GET,helper_panel}}{+START,IF_EMPTY,{$GET,panel_right}}<div class="global_helper_panel_wrap">{+END}{+END}
						{$GET,panel_right}
					</div>
				{+END}
			</div>
		</div>
		{+START,IF_NON_EMPTY,{$GET,panel_bottom}}
			<div id="panel_bottom"{$?,{$VALUE_OPTION,html5}, role="complementary"}>
				{$GET,panel_bottom}
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{MESSAGE}}
			<div class="top_level_wrap">
				<div id="global_message" style="width: {$GET,middle_width}{+START,IF,{$NEQ,{$GET,left_width},0}}; margin-{!en_left}: {$GET,left_width}{+END}{+START,IF,{$NEQ,{$GET,right_width},0}}; margin-{!en_right}: {$GET,right_width}{+END}" class="global_message">
					{MESSAGE}
				</div>
			</div>
		{+END}
	</div>
{+END}

{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}

