<div class="constrain_field"><input {+START,IF,{$MOBILE}}autocorrect="off" {+END}autocomplete="off" maxlength="255" tabindex="{TABINDEX*}" onkeyup="update_ajax_member_list(this,null,false,event);" class="{+START,IF,{NEEDS_MATCH}}input_username{+END}{+START,IF,{$NOT,{NEEDS_MATCH}}}input_line{+END}{REQUIRED*} wide_field" type="text" id="{NAME*}" name="{NAME*}" value="{DEFAULT*}" /></div>

