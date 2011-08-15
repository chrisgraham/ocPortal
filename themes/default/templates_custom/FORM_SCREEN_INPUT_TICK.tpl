{+START,IF,{$NOT,{CHECKED}}}
	<input tabindex="{TABINDEX*}" class="input_tick" type="checkbox" id="{NAME*}" name="{NAME*}" value="{+START,IF_PASSED,VALUE}{VALUE*}{+END}{+START,IF_NON_PASSED,VALUE}1{+END}" {+START,IF,{DISABLED}}disabled="disabled" {+END}/>
{+END}
{+START,IF,{CHECKED}}
	<input tabindex="{TABINDEX*}" class="input_tick" type="checkbox" id="{NAME*}" name="{NAME*}" value="{+START,IF_PASSED,VALUE}{VALUE*}{+END}{+START,IF_NON_PASSED,VALUE}1{+END}" checked="checked" {+START,IF,{DISABLED}}disabled="disabled" {+END}/>
{+END}
<input name="tick_on_form__{NAME*}" value="0" type="hidden" />
