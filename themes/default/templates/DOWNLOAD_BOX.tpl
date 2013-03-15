{+START,IF,{$GET,in_panel}}
	{+START,BOX,,,light}
		<p class="tiny_para"><a title="{NAME*}: {!BY_SIMPLE,{AUTHOR*}}" href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME},name,_SEARCH:cms_downloads:type=__ed:id={ID}}{NAME*}{+END}</a></p>

		<p class="tiny_para associated_details">
			{+START,IF_PASSED,RATING}<span class="right">{RATING}</span>{+END}

			{+START,IF,{$INLINE_STATS}}{DOWNLOADS*} {!COUNT_DOWNLOADS}{+END}
		</p>

		<p class="tiny_para associated_details">
			{!_ADDED} {DATE*}
		</p>
	{+END}
{+END}

{+START,IF,{$NOT,{$GET,in_panel}}}
	{+START,SET,META}
	{+START,IF,{$INLINE_STATS}}{!COUNT_DOWNLOADS}|{DOWNLOADS*}|{+END}{!_ADDED}|{DATE*}{+START,IF_PASSED,RATING}|{!RATING}|{RATING}{+END}
	{+END}
	{+START,SET,BOX_TITLE}
		<a href="{URL*}">{+START,FRACTIONAL_EDITABLE,{NAME},name,_SEARCH:cms_downloads:type=__ed:id={ID}}{NAME*}{+END}</a> {!BY_SIMPLE_LOWER,{AUTHOR*}}
	{+END}
	{+START,IF_PASSED,LICENCE}
		{$SET,dbox_title,<a href="{URL*}">{!VIEW}</a>}
	{+END}
	{+START,IF_NON_PASSED,LICENCE}
		{$SET,dbox_title,<a href="{URL*}">{!MORE_INFO}</a>|<a href="{$FIND_SCRIPT*,dload}?id={ID*}{$KEEP*}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}">{!DOWNLOAD_NOW}</a> ({FILE_SIZE*})}
	{+END}
	{+START,BOX,{$GET,BOX_TITLE},,med,,{$GET,META},{$GET,dbox_title}}
		{+START,IF_NON_EMPTY,{IMGCODE}}
			<div class="download_box_pic"><a href="{URL*}">{IMGCODE}</a></div>
		{+END}

		<div class="download_box_description {+START,IF_NON_EMPTY,{IMGCODE}}pic{+END}">{$TRUNCATE_LEFT,{DESCRIPTION},460,0,1}</div>

		{+START,IF_NON_EMPTY,{TREE}}
			<p>{!LOCATED_IN,{TREE}}</p>
		{+END}
	{+END}
{+END}
