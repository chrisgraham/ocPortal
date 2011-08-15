<div class="float_surrounder">
	<div class="left">
		{+START,IF,{$NOT,{CHECKED}}}
			<input class="input_radio" type="radio" id="{NAME*}_{VALUE*}" name="{NAME*}" value="{VALUE*}" />
		{+END}
		{+START,IF,{CHECKED}}
			<input class="input_radio" type="radio" id="{NAME*}_{VALUE*}" name="{NAME*}" value="{VALUE*}" checked="checked" />
		{+END}
	</div>
	<div class="left">
		<label for="{$FIX_ID,{NAME*}_{VALUE*}}"><img src="{URL*}" alt="{!SELECT_IMAGE}: {$STRIP_TAGS,{PRETTY*}}" title="" /><br />
		{URL*}</label>
	</div>
</div>

<hr />
