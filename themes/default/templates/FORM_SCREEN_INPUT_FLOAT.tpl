<div class="constrain_field">
	<input maxlength="255" tabindex="{TABINDEX*}" onkeydown="if (!key_pressed(event,[null,'-','0','1','2','3','4','5','6','7','8','9','{$DECIMAL_POINT;}'])) return false; return null;" class="input_float{REQUIRED*}" size="6" {+START,IF,{$VALUE_OPTION,html5}}step="0.001" {+END}type="{+START,IF,{$VALUE_OPTION,html5}}number{+END}{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}text{+END}" id="{NAME*}" name="{NAME*}" value="{DEFAULT*}" />
</div>
