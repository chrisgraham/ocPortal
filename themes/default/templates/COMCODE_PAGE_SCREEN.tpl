{+START,IF,{$NOR,{IS_PANEL},{BEING_INCLUDED}}}
	{+START,IF_EMPTY,{$TRIM,{CONTENT}}}
		<p class="nothing_here">{!NO_PAGE_OUTPUT}</p>
	{+END}
{+END}

{+START,IF,{$OR,{$NOT,{IS_PANEL}},{$IS_NON_EMPTY,{$TRIM,{CONTENT}}}}}
	{WARNING_DETAILS}

	{$TRIM,{CONTENT}}

	{+START,IF,{SHOW_AS_EDIT}}{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
		<div class="edited" role="note">
			<img alt="" src="{$IMG*,edited}" />
			{!EDITED}
			<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}" itemprop="datePublished">{$DATE*,,,,{EDIT_DATE_RAW}}</time>
		</div>
	{+END}{+END}

	{+START,IF,{$NOR,{IS_PANEL},{$EQ,{NAME},rules,start},{$_GET,wide_high},{IS_PANEL},{BEING_INCLUDED}}}
		{+START,IF,{$CONFIG_OPTION,show_screen_actions}}
			{$BLOCK,failsafe=1,block=main_screen_actions}
		{+END}

		{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}
	{+END}

	{+START,IF_NON_EMPTY,{EDIT_URL}}
		{+START,IF,{IS_PANEL}}
			{+START,IF,{$EQ,{NAME},panel_left,panel_right}}
				<p class="quick_self_edit_link associated_link">
					<img class="comcode_supported_icon" title="{!_COMCODE}" alt="{!_COMCODE}" src="{$IMG*,comcode}" />
					<a href="{EDIT_URL*}" title="{!EDIT_ZONE_EDITOR}: {NAME*} ({!IN,&quot;{$?,{$IS_EMPTY,{$ZONE}},{!_WELCOME},{$ZONE*}}&quot;})">{!EDIT_ZONE_EDITOR}</a>
				</p>
			{+END}

			{+START,IF,{$EQ,{NAME},panel_top,panel_bottom}}
				<a class="edit_page_link_inline" href="{EDIT_URL*}"><img width="17" height="17" class="comcode_supported_icon" title="{!EDIT_PAGE}: {NAME*}" alt="{!EDIT_PAGE}: {NAME*}" src="{$IMG*,comcode}" /></a>
			{+END}
		{+END}

		{+START,IF,{$NOR,{IS_PANEL},{$GET,no_comcode_page_edit_links}}}
			{+START,INCLUDE,STAFF_ACTIONS}
				1_URL={EDIT_URL*}
				1_TITLE={$?,{BEING_INCLUDED},&uarr; {!EDIT},{!EDIT_PAGE}}
				1_NOREDIRECT=1
				1_ACCESSKEY=q
				1_REL=edit
				2_URL={$?,{$GET,has_comcode_page_children_block},{ADD_CHILD_URL*}}
				2_TITLE={!ADD_CHILD_PAGE}
				2_REL=add
			{+END}
		{+END}
	{+END}
{+END}
