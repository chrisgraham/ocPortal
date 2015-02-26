<h3>{TITLE*}</h3>

<div>
	<h4 class="toggleable_tray_title">
		<a class="toggleable_tray_button" title="{!SETTINGS}: {!EXPAND}" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {TITLE*}" title="{!EXPAND}" src="{$IMG*,expand}" /></a> <a class="toggleable_tray_button" title="{!SETTINGS}: {!EXPAND}" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{!SETTINGS}</a>
	</h4>
	<div class="toggleable_tray" style="display: {$JS_ON,none,block}" aria-expanded="false">
		{FORM}
	</div>
</div>

