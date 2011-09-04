<div class="left-box1">
	<form onsubmit="if (checkFieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
		<h4>Members Login </h4>

		<div class="login-container">
			<div class="constrain_field">
				<div class="login"><label for="login_username">{!USERNAME}</label></div>
				<input alt="{!USERNAME}" accesskey="l" class="login-box" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="login_username" name="login_username" />
				<div class="login"><label for="s_password">{!PASSWORD}</label></div>
				<input alt="{!PASSWORD}" class="login-box " type="password" value="password" name="password" id="s_password" />
			</div>
			<div class="login_block_cookies">
				<div class="float_surrounder">
					<label for="remember">{!REMEMBER_ME}</label>
					<input checked="checked" type="checkbox" value="1" id="remember" name="remember" />
				</div>
				{+START,IF,{$CONFIG_OPTION,is_on_invisibility}}
					<div class="float_surrounder">
						<label for="login_invisible">{!INVISIBLE}</label>
						<input type="checkbox" value="1" id="login_invisible" name="login_invisible" />
					</div>
				{+END}
			</div>
			<div class="float_surrounder">
				<input class="button" type="submit" value="{!_LOGIN}" />
			</div>
		</div>
	</form>
	<div class="button_panel">
		[ {+START,IF_NON_EMPTY,{JOIN_LINK}}<a href="{JOIN_LINK*}">{!_JOIN}</a> | {+END}<a href="{FULL_LINK*}" title="{!_LOGIN}">{!MORE}</a> ]
	</div>
</div>
