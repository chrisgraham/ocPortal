<div class="float_surrounder {$CYCLE,tep,tpl_dropdown_row_a,tpl_dropdown_row_b}">
	<div class="left">
		<div class="accessibility_hidden"><label for="f{ID*}{NAME*}">{NAME*}</label></div>
		<select name="f{ID*}{NAME*}" id="f{ID*}{NAME*}">
			<option>---</option>
			{PARAMETERS}
		</select>
	</div>
	{+START,IF,{$JS_ON}}
	<div class="right">
		<input name="f{ID*}dd_{NAME*}" onclick="return templateEditPage('f{ID*}{NAME*}','{ID*}');" type="button" value="{LANG*}" />
	</div>
	{+END}
</div>

