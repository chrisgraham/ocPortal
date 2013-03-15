<div class="constrain_field">
	<input {+START,IF_PASSED,MAXLENGTH}maxlength="{MAXLENGTH*}" {+END}{+START,IF_NON_PASSED,MAXLENGTH}maxlength="255" {+END}tabindex="{TABINDEX*}" class="input_line{REQUIRED*} wide_field" type="{+START,IF_NON_PASSED,TYPE}text{+END}{+START,IF_PASSED,TYPE}{+START,IF,{$VALUE_OPTION,html5}}{TYPE*}{+END}{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}text{+END}{+END}" id="{NAME*}" name="{NAME*}" value="{DEFAULT*}" />
</div>

