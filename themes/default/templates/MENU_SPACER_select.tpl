{+START,IF,{$JS_ON}}
	<option>&nbsp;</option>
{+END}
{+START,IF,{$NOT,{$JS_ON}}}
	<li{$?,{$VALUE_OPTION,html5}, role="separator"} class="menu_spacer">&nbsp;</li>
{+END}
