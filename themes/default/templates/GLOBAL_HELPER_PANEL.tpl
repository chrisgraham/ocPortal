<div class="global_helper_panel_wrap">
	{$REQUIRE_CSS,helper_panel}

	{+START,IF,{$NOT,{$HIDE_HELP_PANEL}}}
	<a id="helper_panel_toggle" href="#" onclick="return help_panel(false);"><img title="{!HELP_OR_ADVICE}: {!HIDE}" alt="{!HELP_OR_ADVICE}: {!HIDE}" src="{$IMG*,help_panel_hide}" /></a>
	{+END}
	{+START,IF,{$HIDE_HELP_PANEL}}
	<a id="helper_panel_toggle" href="#" onclick="return help_panel(true);"><img title="{!HELP_OR_ADVICE}: {!SHOW}" alt="{!HELP_OR_ADVICE}: {!SHOW}" src="{$IMG*,help_panel_show}" /></a>
	{+END}

	<div id="helper_panel_contents"{+START,IF,{$HIDE_HELP_PANEL}} style="display: none" aria-expanded="false"{+END}>
		<h2>{!HELP_OR_ADVICE}</h2>

		<div class="global_helper_panel">
			{+START,IF_NON_EMPTY,{$HELPER_PANEL_TEXT}}
				<div class="box box___global_helper_panel__text"><div class="box_inner">
					<div id="help" class="global_helper_panel_text">{$HELPER_PANEL_TEXT}</div>
				</div></div>
			{+END}

			{+START,IF_NON_EMPTY,{$GET,HELPER_PANEL_TUTORIAL}}
				<div id="help_tutorial">
					<div class="box box___global_helper_panel__tutorial"><div class="box_inner">
						<div class="global_helper_panel_text">{$URLISE_LANG,{!TUTORIAL_ON_THIS},{$BRAND_BASE_URL*}/docs{$VERSION*}/pg/{$GET*,HELPER_PANEL_TUTORIAL},,1}</div>
					</div></div>
				</div>
			{+END}

			{+START,IF_EMPTY,{$HELPER_PANEL_HTML}{$HELPER_PANEL_TEXT}{$GET,HELPER_PANEL_TUTORIAL}}
				<div id="help">
					<div class="box box___global_helper_panel__none"><div class="box_inner">
						<p>{!NO_HELP_HERE}</p>
					</div></div>
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{$HELPER_PANEL_PIC}}{+START,IF_EMPTY,{$HELPER_PANEL_HTML}}
				<div id="global_helper_panel_pic" class="global_helper_panel_pic"><img width="220" alt="" src="{$IMG*,{$HELPER_PANEL_PIC}}" /></div>
			{+END}{+END}

			{+START,IF_NON_EMPTY,{$HELPER_PANEL_HTML}}
				<div class="global_helper_panel_html">
					{$HELPER_PANEL_HTML}
				</div>
			{+END}
		</div>
	</div>
</div>
