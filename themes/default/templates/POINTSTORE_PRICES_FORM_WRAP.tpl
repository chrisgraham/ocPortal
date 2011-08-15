<h3>{TITLE*}</h3>

<div>
	<a class="hide_button" title="{!SETTINGS}: {!EXPAND}" href="#" onclick="event.returnValue=false; hideTag(this.parentNode); return false;"><img alt="{!EXPAND}: {TITLE*}" title="{!EXPAND}" src="{$IMG*,expand}" /></a> <a class="hide_button" title="{!SETTINGS}: {!EXPAND}" href="#" onclick="event.returnValue=false; hideTag(this.parentNode); return false;">{!SETTINGS}</a>
	<div class="hide_tag hide_button_spacing form_set_indent" style="display: {$JS_ON,none,block}">
		{FORM}
	</div>
</div>

