{+START,IF,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,_WILD:login}}}
	{+START,BOX,,,{$?,{$GET,in_panel},panel,classic}}
		<form onsubmit="if (check_fieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
			<div>
				<div class="constrain_field">
					<div class="accessibility_hidden"><label for="login_username">{!USERNAME}</label></div>
					<input accesskey="l" class="login-box" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="login_username" name="login_username" /><br/>
					<div class="accessibility_hidden"><label for="s_password">{!PASSWORD}</label></div>
					<input class="login-box" type="password" value="password" name="password" id="s_password" />
				</div>
				<div class="login_block_cookies">
					{+START,IF,{$CONFIG_OPTION,is_on_invisibility}}
						<div class="float_surrounder">
							<label for="login_invisible">{!INVISIBLE}</label>
							<input type="checkbox" value="1" id="login_invisible" name="login_invisible" />
						</div>
					{+END}
				</div>
				<input class="wide_button" type="submit" value="{!_LOGIN}" />
			</div>
		</form>
	{+END}
{+END}
