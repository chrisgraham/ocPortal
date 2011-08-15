<li>
	<label for="banned_{UNIQID*}">
		<kbd>{MASK*}</kbd>
		{+START,IF,{$ADDON_INSTALLED,securitylogging}}
			&nbsp; <em>{!_BANNED}: <input type="checkbox" id="banned_{UNIQID*}" name="banned[]" value="{MASK*}"{+START,IF,{BANNED}} checked="checked"{+END} /></em>
		{+END}
	</label>
	<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode); return false;"><img class="inline_image_4" alt="{$?,{OPEN_DEFAULT},{!CONTRACT},{!EXPAND}}" title="{$?,{OPEN_DEFAULT},{!CONTRACT},{!EXPAND}}" src="{$IMG*,{$?,{OPEN_DEFAULT},contract,expand}}" /></a>
	<br />
	<ul class="hide_tag" style="display: {$JS_ON,{$?,{OPEN_DEFAULT},block,none},block}">
		{GROUP}
	</ul>
</li>
