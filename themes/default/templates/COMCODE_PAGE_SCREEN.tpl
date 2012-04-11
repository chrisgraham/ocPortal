{+START,IF,{$NOT,{BEING_INCLUDED}}}{+START,IF,{$NOT,{$IN_STR,{NAME},panel_}}}{+START,IF_EMPTY,{$TRIM,{CONTENT}}}
	<p class="nothing_here">{!NO_PAGE_OUTPUT}</p>
{+END}{+END}{+END}

{+START,IF,{$OR,{$NEQ,{NAME},panel_top,panel_left,panel_right},{$IS_NON_EMPTY,{$TRIM,{CONTENT}}}}}
	{WARNING_DETAILS}

	{$TRIM,{CONTENT}}

	{+START,IF,{SHOW_AS_EDIT}}{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
		<div class="edited edited_block"{$?,{$VALUE_OPTION,html5}, role="note"}>
			<img alt="" title="" src="{$IMG*,edited}" />
			{!EDITED}
			{+START,IF,{$VALUE_OPTION,html5}}
				<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}" pubdate="pubdate">{$DATE*,{EDIT_DATE_RAW}}</time>
			{+END}
			{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
				{$DATE*,{EDIT_DATE_RAW}}
			{+END}
		</div>
	{+END}{+END}

	{+START,IF,{$NOT,{$_GET,wide_high}}}{+START,IF,{$NOR,{IS_PANEL},{BEING_INCLUDED}}}{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF,{$NEQ,{$SUBSTR,{NAME},0,6},rules,start,panel_}}{$BLOCK,failsafe=1,block=main_screen_actions}{+END}{+END}{+END}{+END}

	{+START,IF_NON_EMPTY,{EDIT_URL}}
		{+START,IF,{$EQ,{NAME},panel_left,panel_right}}
			<p class="mini_edit_me">
				[ <a href="{EDIT_URL*}" title="{!EDIT_ZONE_EDITOR}: {NAME*} ({!IN,&quot;{$?,{$IS_EMPTY,{$ZONE}},{!_WELCOME},{$ZONE*}}&quot;})">{!EDIT_ZONE_EDITOR}</a>
				<img class="comcode_button" title="{!_COMCODE}" alt="{!_COMCODE}" src="{$IMG*,comcode}" /> ]
			</p>
		{+END}
		{+START,IF,{$EQ,{NAME},panel_top,panel_bottom}}
			<a class="edit_menu_link_inline" href="{EDIT_URL*}"><img class="comcode_button" title="{!EDIT_PAGE}" alt="{!EDIT_PAGE}" src="{$IMG*,comcode}" /></a>
		{+END}

		{+START,IF,{$NEQ,{NAME},panel_left,panel_right,panel_top,panel_bottom}}
			{+START,IF,{$NOR,{IS_PANEL},{BEING_INCLUDED}}}{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}{+END}

			{+START,IF,{$NOT,{BEING_INCLUDED}}}<br />{+END}
			{+START,INCLUDE,STAFF_ACTIONS}
				1_URL={EDIT_URL*}
				1_TITLE={$?,{BEING_INCLUDED},&uarr; {!EDIT},{!EDIT_PAGE}}
				1_ACCESSKEY=q
				1_REL=edit
				2_URL={$?,{$GET,has_comcode_page_children_block},{ADD_CHILD_URL*}}
				2_TITLE={!ADD_CHILD_PAGE}
				2_REL=add
			{+END}
		{+END}
	{+END}
{+END}