<div class="float_surrounder">
	<label for="ssl_{ZONE*}__{PAGE*}">{ZONE*}:{PAGE*}</label>
	{+START,IF,{TICKED}}
		<input class="inline_image_2" type="checkbox" value="1" id="ssl_{ZONE*}__{PAGE*}" name="ssl_{ZONE*}__{PAGE*}" checked="checked" />
	{+END}
	{+START,IF,{$NOT,{TICKED}}}
		<input class="inline_image_2" type="checkbox" value="1" id="ssl_{ZONE*}__{PAGE*}" name="ssl_{ZONE*}__{PAGE*}" />
	{+END}
</div>

