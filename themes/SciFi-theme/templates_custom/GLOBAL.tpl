{+START,IF_PASSED,MESSAGE_TOP}{+START,IF_NON_EMPTY,{MESSAGE_TOP}}
	<div class="global_message">
		{MESSAGE_TOP}
	</div>
{+END}{+END}

{$GET,panel_top}

<div id="content-part">
	<div class="content-part-top"> </div>
	<div class="content-part-mid">
		{+START,IF_NON_EMPTY,{$TRIM,{$GET,panel_left}}}
			<div class="content-part-left">
				<div class="content-part-left-head"> </div>
				<div class="content-part-left-mid">{$GET,panel_left}</div>
				<div class="content-part-left-bot"> </div>
			</div>
		{+END}

		<div class="content-part-right"{+START,IF_EMPTY,{$TRIM,{$GET,panel_left}}} style="width: auto; float: none; padding: 0 15px"{+END}>
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

	<div class="content-part-bot"> </div>
</div>

{+START,IF_NON_EMPTY,{MESSAGE}}
	<div class="top_level_wrap">
		<div id="global_message" class="global_message">
			{MESSAGE}
		</div>
	</div>
{+END}

{+START,IF,{$EQ,{$CONFIG_OPTION,sitewide_im},1}}{$CHAT_IM}{+END}
