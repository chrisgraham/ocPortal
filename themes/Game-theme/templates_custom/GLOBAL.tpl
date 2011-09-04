<div id="content">
	{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
		<div class="global_message">
			{MESSAGE_TOP}
		</div>
	{+END}{+END}

	{$GET,panel_top}

	<div class="float_surrounder" {+START,IF,{$NOT,{$MATCH_KEY_MATCH,:start}}}style="background: white; padding: 0 15px; font-size: 0.8em; width: auto;"{+END}>
		{+START,IF_NON_EMPTY,{BREADCRUMBS}}
			<div class="breadcrumbs">
				{BREADCRUMBS}
			</div>
		{+END}

		{MIDDLE}
	</div>

	{+START,IF_NON_EMPTY,{MESSAGE}}
		<div class="top_level_wrap">
			<div id="global_message" class="global_message">
				{MESSAGE}
			</div>
		</div>
	{+END}
</div>

{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}
