{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
	<div class="global_message">
		{MESSAGE_TOP}
	</div>
{+END}{+END}

{$GET,panel_top}

<div class="float_surrounder">
	<div class="content">
		<div class="col1" {+START,IF_EMPTY,{$GET,panel_right}}style="width: auto; float: none"{+END}>
			{+START,IF_NON_EMPTY,{BREADCRUMBS}}
				<{$?,{$VALUE_OPTION,html5},nav,div} class="breadcrumbs breadcrumbs_always"{$?,{$VALUE_OPTION,html5}, itemprop="breadcrumb"}>
					<img class="breadcrumbs_img" src="{$IMG*,treenav}" title="{!YOU_ARE_HERE}" alt="{!YOU_ARE_HERE}" />
					{BREADCRUMBS}
				</{$?,{$VALUE_OPTION,html5},nav,div}>
			{+END}

			<a name="maincontent" id="maincontent"></a>

			{MIDDLE}
		</div>

		{+START,IF_NON_EMPTY,{$GET,panel_right}}
			<div class="col2">
				{$GET,panel_right}
			</div>
		{+END}
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
