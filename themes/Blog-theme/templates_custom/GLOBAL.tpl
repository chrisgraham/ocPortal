{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
	<div class="global_message">
		{MESSAGE_TOP}
	</div>
{+END}{+END}

<div class="global_body">
	{$GET,panel_top}

	<div class="float_surrounder">
		<div class="left">
			{+START,IF_NON_EMPTY,{BREADCRUMBS}}
				<{$?,{$VALUE_OPTION,html5},nav,div} class="breadcrumbs breadcrumbs_always"{$?,{$VALUE_OPTION,html5}, itemprop="breadcrumb"}>
					<img class="breadcrumbs_img" src="{$IMG*,treenav}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
					{BREADCRUMBS}
				</{$?,{$VALUE_OPTION,html5},nav,div}>
			{+END}

			<a name="maincontent" id="maincontent"></a>

			{MIDDLE}
		</div>

		{$GET,panel_right}
	</div>
</div>

{+START,IF_NON_EMPTY,{MESSAGE}}
	<div class="top_level_wrap">
		<div id="global_message" class="global_message">
		{MESSAGE}
		</div>
	</div>
{+END}

{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}
