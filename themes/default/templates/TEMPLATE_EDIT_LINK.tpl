{$,Will produce invalid XHTML, but we try and make it look nice}

{+START,IF_NON_EMPTY,{$TRIM,{CONTENTS}}}
	{+START,SET,tpl_marker_open}
		<span style="margin: 5px; padding: 5px; display: inline-block; -webkit-border-radius: 5px 5px 5px 5px; -moz-border-radius: 5px 5px 5px 5px; border-radius: 5px 5px 5px 5px; border: 1px solid {$CYCLE*,tpl_cycle,aqua,blue,fuchsia,gray,green,lime,maroon,navy,olive,purple,red,silver,teal};">
		{$GET,tpl_marker_open}
	{+END}

	{+START,SET,tpl_marker_link}
		{$,NB: We do not use an anchor tag because nested anchors make a mess}
		<span onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'&lt;p&gt;{!ALT_NEW_WINDOW^;*}&lt;/p&gt;{PARAM_INFO^;*}','800px',null,null,null,true);" style="display: block" class="associated_link_to_small"><span style="text-decoration: underline; cursor: pointer; background: rgba(255,255,255,200); display: inline-block; border: 1px dotted black; margin: 3px;" onkeypress="return this.onclick.call(this,event);" onclick="if (event.altKey) window.open('{EDIT_URL;*}'); else window.location='{EDIT_URL;*}'; return cancelBubbling(event);"><kbd style="color: black;">{CODENAME*}.tpl</kbd></span></span>
		{$GET,tpl_marker_link}
	{+END}

	{+START,SET,tpl_marker_close}
		</span>
		{$GET,tpl_marker_close}
	{+END}

	{$,Decide whether we can show it now (otherwise it will defer) }
	{$SET,tpl_go_ahead,{$AND,{$NOT,{$IN_STR,{CONTENTS},<td,<tr,<th}},{$IN_STR,{CONTENTS},<}}}

	{$,Has to skip escaping with ` because we do not know enough about context - would be XSS tested without this mode enabled}

	{+START,IF,{$GET,tpl_go_ahead}}
		{$GET,tpl_marker_open}
		{CONTENTS`}
		{$GET,tpl_marker_link}
		{$GET,tpl_marker_close}

		{$SET,tpl_marker_open,}
		{$SET,tpl_marker_link,}
		{$SET,tpl_marker_close,}
	{+END}

	{+START,IF,{$NOT,{$GET,tpl_go_ahead}}}
		{CONTENTS`}
	{+END}
{+END}
