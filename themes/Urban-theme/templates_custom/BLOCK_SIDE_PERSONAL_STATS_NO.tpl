<div class="side_personal_stats{$?,{$GET,in_panel}, interlock,}">
	{+START,IF,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,_WILD:login}}}
		{+START,BOX,Login,,{$?,{$GET,in_panel},panel,classic}}
			<form title="{!_LOGIN}" onsubmit="if (checkFieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete side_block_form">
				<table>
					<colgroup>
						<col width="80" />
						<col width="180" />
					</colgroup>

					<tbody>
						<tr>
							<th>
								<label for="login_username">{!USERNAME}</label>
							</th>
							<td>
								<div class="constrain_field">
									<input accesskey="l" class="login_block_username" type="text" onfocus="if (this.value=='{}'){ this.value=''; password.value=''; }" value="" id="login_username" name="login_username" />
								</div>
							</td>
						</tr>
						<tr>
							<th>
								<label for="s_password">{!PASSWORD}</label>
							</th>
							<td>
								<div class="constrain_field">
									<input class="login_block_password" type="password" value="" name="password" id="s_password" />
								</div>
							</td>
						</tr>
						<tr>
							<td  colspan="2">
								<label for="remember">{!REMEMBER_ME}</label>
								<input {+START,IF,{$CONFIG_OPTION,remember_me_by_default}}checked="checked" {+END}{+START,IF,{$NOT,{$CONFIG_OPTION,remember_me_by_default}}}onclick="if (this.checked) { var t=this; window.fauxmodal_confirm('{!REMEMBER_ME_COOKIE;}',function(answer) { if (!answer) { t.checked=false; } }); }" {+END}type="checkbox" value="1" id="remember" name="remember" />
							</td>
							{+START,IF,{$CONFIG_OPTION,is_on_invisibility}}
								<td colspan="2">
									<label for="login_invisible">{!INVISIBLE}</label>
									<input type="checkbox" value="1" id="login_invisible" name="login_invisible" />
								</td>
							{+END}
						</tr>
					</tbody>
				</table>
				<p class="button_panel">
					[ {+START,IF_NON_EMPTY,{JOIN_LINK}}<a href="{JOIN_LINK*}">{!_JOIN}</a> | {+END}<a href="{FULL_LINK*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a> ]
				</p>
				<input class="search-but" type="submit" value="{!_LOGIN}" />
			</form>
		{+END}
	{+END}
</div>
