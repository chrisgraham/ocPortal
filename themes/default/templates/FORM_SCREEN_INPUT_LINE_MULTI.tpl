<div class="constrain_field">
	<div class="accessibility_hidden"><label for="{NAME_STUB*}{I*}">{PRETTY_NAME*}</label></div>
	<input {+START,IF_PASSED,MAXLENGTH}maxlength="{MAXLENGTH*}" {+END}tabindex="{TABINDEX*}" class="input_{CLASS*}{REQUIRED*}{+START,IF,{$NEQ,{CLASS},email}} wide_field{+END}" size="{$?,{$MOBILE},34,40}" onkeypress="if (!key_pressed(event,9)) ensure_next_field(this);" type="text" id="{$REPLACE,[],_,{NAME_STUB*}}{I*}" name="{NAME_STUB*}{+START,IF,{$NOT,{$IN_STR,{NAME_STUB},[]}}}{I*}{+END}" value="{DEFAULT*}" />
	<input type="hidden" name="label_for__{NAME_STUB*}{I*}" value="{PRETTY_NAME*}" />
</div>

