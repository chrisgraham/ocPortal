{+START,IF,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,_WILD:login}}}
	{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic}}
		<form title="{!_LOGIN}" onsubmit="if (checkFieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
			<div>
				<div class="constrain_field">
					<div class="accessibility_hidden"><label for="login_username">{!USERNAME}{+START,IF,{$AND,{$OCF},{$CONFIG_OPTION,one_per_email_address}}} / {!EMAIL_ADDRESS}{+END}</label></div>
					<div class="accessibility_hidden"><label for="s_password">{!PASSWORD}</label></div>
					<input accesskey="l" class="wide_field login_block_username" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="login_username" name="login_username" />
					<input class="wide_field" type="password" value="password" name="password" id="s_password" />
				</div>
				<div class="login_block_cookies">
					<div class="float_surrounder">
						<label for="remember">{!REMEMBER_ME}</label>
						<input {+START,IF,{$CONFIG_OPTION,remember_me_by_default}}checked="checked" {+END}{+START,IF,{$NOT,{$CONFIG_OPTION,remember_me_by_default}}}onclick="if (this.checked) if (!window.confirm('{!REMEMBER_ME_COOKIE;}')) this.checked=false;" {+END}type="checkbox" value="1" id="remember" name="remember" />
					</div>
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
		<p class="button_panel">
			[ {+START,IF_NON_EMPTY,{JOIN_LINK}}<a href="{JOIN_LINK*}">{!_JOIN}</a> | {+END}<a href="{FULL_LINK*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a> ]

			{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
				<span xmlns:fb="http://api.facebook.com/1.0/">
					<fb:login-button scope="email,user_birthday"></fb:login-button>
				</span>
			{+END}
		</p>
	{+END}
{+END}

