<div class="float_surrounder">
	<div class="search_option"><label for="sd_{NAME*}">{DISPLAY*}:</label></div>
	<div class="constrain_field">
		<input maxlength="255" class="wide_field search_option_value" type="text" id="sd_{NAME*}" name="{NAME*}" value="{SPECIAL*}" />
	</div>
</div>

{+START,SHIFT_ENCODE,search_options_message}
	<p class="associated_details">{!MAY_LEAVE_BLANK_ADVANCED}</p>
{+END}

{+START,SHIFT_ENCODE,search_template_help}
	<p><em>{!TEMPLATE_SEARCH_INFO}</em></p>
{+END}

