{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic}}
	<form onsubmit="if (check_fieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
		<div>
			<div class="constrain_field">
				<div><label for="login_username">{!USERNAME}</label></div>
				<input alt="{!USERNAME}" onclick="return open_link_as_overlay(this);" accesskey="l" class="search-box" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="" id="login_username" name="login_username" />
				<div><label for="s_password">{!PASSWORD}</label></div>
				<input alt="{!PASSWORD}" class="search-box" type="password" value="" name="password" id="s_password" />
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
			<input class="button" type="submit" value="{!_LOGIN}" />
		</div>
	</form>
	<p class="button_panel">
		 {+START,IF_NON_EMPTY,{JOIN_LINK}}<a href="{JOIN_LINK*}">{!_JOIN}</a>  {+END} 
	</p>
{+END}

