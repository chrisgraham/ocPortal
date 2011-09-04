{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
	<div class="global_message">
		{MESSAGE_TOP}
	</div>
{+END}{+END}

{+START,IF_NON_EMPTY,{MESSAGE}}
	<div class="top_level_wrap">
		<div id="global_message" class="global_message">
			{MESSAGE}
		</div>
	</div>
{+END}

{$GET,panel_top}

{+START,IF_NON_EMPTY,{$GET,panel_left}}
	<div id="col1">
		{$GET,panel_left}
	</div>
{+END}

<div id="col2"{+START,IF_EMPTY,{$GET,panel_left}} style="float: none; width: auto"{+END}>
	{+START,IF_NON_EMPTY,{BREADCRUMBS}}
		<{$?,{$VALUE_OPTION,html5},nav,div} class="breadcrumbs breadcrumbs_always"{$?,{$VALUE_OPTION,html5}, itemprop="breadcrumb"}>
			<img class="breadcrumbs_img" src="{$IMG*,treenav}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
			{BREADCRUMBS}
		</{$?,{$VALUE_OPTION,html5},nav,div}>
	{+END}

	<a name="maincontent" id="maincontent"></a>

	{MIDDLE}
</div>

{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}
