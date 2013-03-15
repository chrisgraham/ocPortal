{+START,IF,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,_WILD:login}}}
	{+START,BOX,,,{$?,{$GET,in_panel},panel,classic}}
		<form onsubmit="if (check_fieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
			<div>
				<div class="constrain_field">
					<div class="accessibility_hidden"><label for="login_username">{!USERNAME}</label></div>
					<div class="accessibility_hidden"><label for="s_password">{!PASSWORD}</label></div>
					<input accesskey="l" class="search-box login_block_username" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="login_username" name="login_username" />
					<input class="search-box" type="password" value="password" name="password" id="s_password" />
				</div>

				<input class="button" type="submit" value="{!_LOGIN}" />
			</div>
		</form>
	{+END}
{+END}
