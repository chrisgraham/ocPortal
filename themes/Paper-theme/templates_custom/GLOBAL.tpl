{+START,IF_EMPTY,{$TRIM,{$GET,panel_left}}}
	<div class="float_surrounder">
		<div class="column-1">
			<a href="{$PAGE_LINK*,:start}"><span class="logo"></span></a>
		</div>
	</div>
{+END}

{$GET,panel_top}

{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
	<div class="global_message">
		{MESSAGE_TOP}
	</div>
{+END}{+END}

<div class="float_surrounder">
	<div id="main-container">
		{+START,IF_NON_EMPTY,{$TRIM,{$GET,panel_left}}}
			<div class="column-1">
				{$GET,panel_left}
			</div>
		{+END}
		{+START,IF_NON_EMPTY,{$TRIM,{$GET,panel_right}}}
			<div class="column-2">
				{$GET,panel_right}
			</div>
		{+END}
		<div class="column-3" {+START,IF_EMPTY,{$TRIM,{$GET,panel_right}}}style="width: auto; float: none; padding: 15px{+START,IF_NON_EMPTY,{$TRIM,{$GET,panel_left}}}; margin-left: 280px{+END}"{+END}>
			{+START,IF_NON_EMPTY,{BREADCRUMBS}}
				<{$?,{$VALUE_OPTION,html5},nav,div} class="breadcrumbs breadcrumbs_always"{$?,{$VALUE_OPTION,html5}, itemprop="breadcrumb"}>
					<img class="breadcrumbs_img" src="{$IMG*,treenav}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
					{BREADCRUMBS}
				</{$?,{$VALUE_OPTION,html5},nav,div}>
			{+END}

			<a name="maincontent" id="maincontent"></a>

			{MIDDLE}
		</div>
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
