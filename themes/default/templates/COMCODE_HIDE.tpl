<blockquote class="box">
	<h4 class="toggleable_tray_title">
		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {$STRIP_TAGS,{TEXT}}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{TEXT}</a>
	</h4>

	<div class="toggleable_tray" style="display: {$JS_ON,none,block}" aria-expanded="false">
		{CONTENT}
	</div>
</blockquote>
