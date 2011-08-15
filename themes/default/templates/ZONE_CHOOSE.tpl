<form title="{!ZONES}" class="inline" action="{$FIND_SCRIPT*,zone_jump}" method="get">
	<div>
		<p class="accessibility_hidden"><label for="zone_jump_i">{!ZONES}</label></p>
		<select accesskey="z" class="zone_choose_list" id="zone_jump_i" name="zone_jump">
			{CONTENT}
		</select>
		{+START,IF,{$JS_ON}}
		<div class="accessibility_hidden"><label for="new_window">{!NEW_WINDOW}</label></div>
		<input title="{!NEW_WINDOW}" type="checkbox" value="1" id="new_window" name="new_window" />
		{+END}
		<input onclick="if ((form.new_window) &amp;&amp; (form.new_window.checked)) form.target='_blank'; form.action='{$BASE_URL}'+((form.zone_jump.value=='')?'':'/')+form.zone_jump.value+'/{$KEEP_INDEX*}'; form.submit();" type="button" value="{!PROCEED}" class="wide_field" />
	</div>
</form>
<br />

