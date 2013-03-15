{+START,IF,{$NOT,{CHECKED}}}
	<label for="sd_{NAME*}"><input type="checkbox" id="sd_{NAME*}" name="{NAME*}" value="1" /> {DISPLAY*}</label><br />
{+END}
{+START,IF,{CHECKED}}
	<label for="sd_{NAME*}"><input type="checkbox" checked="checked" id="sd_{NAME*}" name="{NAME*}" value="1" /> {DISPLAY*}</label><br />
{+END}

