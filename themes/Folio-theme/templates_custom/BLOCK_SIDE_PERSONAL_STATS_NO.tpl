{+START,IF,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,_WILD:login}}}
	{+START,BOX,,,{$?,{$GET,in_panel},panel,classic}}
		<form title="{!_LOGIN}" onsubmit="if (checkFieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
			<div class="float_surrounder">
				<div class="float_surrounder">
					<div>
						<label for="login_username">{!USERNAME}</label>
						<input size="26" maxlength="80" accesskey="l" class="login_block_username" type="text" value="" id="login_username" name="login_username" />
					</div>
					<div>
						<label for="s_password">{!PASSWORD}</label>
						<input size="26" maxlength="255" type="password" value="password" name="password" id="s_password" />
					</div>
				</div>
				<div class="login_block_cookies">
					<input type="hidden" name="remember" value="1" />
					{+START,IF,{$CONFIG_OPTION,is_on_invisibility}}
						<div class="float_surrounder">
							<label for="login_invisible">{!INVISIBLE}</label>
							<input type="checkbox" value="1" id="login_invisible" name="login_invisible" />
						</div>
					{+END}
				</div>
				<div class="constrain_field"><input class="wide_button" type="submit" value="{!_LOGIN}" /></div>
			</div>
		</form>
		<p class="button_panel">
			[ {+START,IF_NON_EMPTY,{JOIN_LINK}}<a href="{JOIN_LINK*}">{!_JOIN}</a> | {+END}<a href="{FULL_LINK*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a> ]
		</p>
	{+END}
{+END}
