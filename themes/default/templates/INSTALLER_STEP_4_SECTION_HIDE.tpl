<br />

<p>
	{!ADVANCED_BELOW}
</p>

<p>
	<a class="hide_button" href="#" onclick="toggleSection('{$FIX_ID,{TITLE*;~}}'); return false;">{TITLE}</a> <a class="hide_button" href="#" onclick="toggleSection('{$FIX_ID,{TITLE*;~}}'); return false;"><img id="img_{$FIX_ID,{TITLE*}}" alt="{!EXPAND}: {$STRIP_TAGS,{TITLE}}" title="{!EXPAND}" src="{$BASE_URL*}/install.php?type=expand" /></a>
</p>

<div id="{$FIX_ID,{TITLE*}}" style="display: {$JS_ON,none,block}">
	{CONTENT}
</div>
