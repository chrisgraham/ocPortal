{+START,IF_NON_EMPTY,{INTERESTED}}
	<div class="float_surrounder">
		<div class="event_interested left">
			<label for="{S*}int_{TYPE_ID*}">{TYPE*}</label>
		</div>
		<div class="right">
			{+START,IF,{$EQ,{INTERESTED},interested}}
				<input type="checkbox" value="1" id="{S*}int_{TYPE_ID*}" name="int_{TYPE_ID*}" />
			{+END}
			{+START,IF,{$EQ,{INTERESTED},not_interested}}
				<input type="checkbox" value="1" id="{S*}int_{TYPE_ID*}" name="int_{TYPE_ID*}" checked="checked" />
			{+END}
		</div>
	</div>
{+END}
