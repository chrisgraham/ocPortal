<form title="{!ZONES}" class="side_block_form" action="{$FIND_SCRIPT*,zone_jump}" method="get">
	<div class="zone_choose_inline">
		<div class="accessibility_hidden"><label for="zone_jump">{!ZONES}</label></div>
		<select accesskey="z" id="zone_jump" name="zone_jump">
			{CONTENT}
		</select>
		{+START,IF,{$JS_ON}}
		<label for="i_new_window">{!NEW_WINDOW}</label> <input type="checkbox" value="1" id="i_new_window" name="i_new_window" />
		{+END}
		<input onclick="if ((form.i_new_window) &amp;&amp; (form.i_new_window.checked)) form.target='_blank'; form.action='{$BASE_URL*;}'+((form.zone_jump.value=='')?'':'/')+form.zone_jump.value+'/{$KEEP_INDEX*}'; form.submit();" type="button" value="{!PROCEED}" />
	</div>
</form>

