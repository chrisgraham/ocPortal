{+START,IF_NON_EMPTY,{INTERESTED}}
	<div class="right">
		<div class="accessibility_hidden"><label for="{S*}int_{TYPE_ID*}">{TYPE*}</label></div>
		{+START,IF,{$EQ,{INTERESTED},interested}}
			<input type="checkbox" value="1" id="{S*}int_{TYPE_ID*}" name="int_{TYPE_ID*}" />
		{+END}
		{+START,IF,{$EQ,{INTERESTED},not_interested}}
			<input type="checkbox" value="1" id="{S*}int_{TYPE_ID*}" name="int_{TYPE_ID*}" checked="checked" />
		{+END}
	</div>
	<div class="event_interested">
		{TYPE*}
	</div>
	<br />
{+END}
