<div class="float_surrounder">
	<div class="search_option"><label for="sd_{NAME*}">{DISPLAY*}:</label></div>
	<input type="checkbox" class="search_option_value" id="sd_{NAME*}" name="{NAME*}" value="1" {+START,IF_NON_EMPTY,{SPECIAL}} checked="checked" {+END} />
</div>

{+START,SHIFT_ENCODE,search_options_message}
	<p class="associated_details">{!MAY_LEAVE_BLANK_ADVANCED}</p>
{+END}

{+START,SHIFT_ENCODE,search_template_help}
	<p><em>{!TEMPLATE_SEARCH_INFO}</em></p>
{+END}

