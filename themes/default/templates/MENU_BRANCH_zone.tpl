{+START,IF_NON_EMPTY,{URL}}
	<li>
		{+START,IF_NON_EMPTY,{IMG}}<img alt="" src="{IMG*}" />{+END}
		<a{+START,IF_NON_EMPTY,{TOOLTIP}} title="{TOOLTIP*}{+START,IF,{NEW_WINDOW}} {!LINK_NEW_WINDOW}{+END}"{+END}{+START,IF,{$AND,{$IS_NON_EMPTY,{ACCESSKEY}},{$EQ,{POSITION},0}}} accesskey="z"{+END} href="{URL*}" class="{$?,{$?,{$EQ,{$SUBSTR,{PAGE_LINK},-1},:},{CURRENT_ZONE},{CURRENT}},current,non_current}" {+START,IF_NON_EMPTY,{ACCESSKEY}} accesskey="{ACCESSKEY*}"{+END}{+START,IF,{NEW_WINDOW}} target="_blank"{+END}>{CAPTION}</a>
	</li>
{+END}
{CHILDREN}
