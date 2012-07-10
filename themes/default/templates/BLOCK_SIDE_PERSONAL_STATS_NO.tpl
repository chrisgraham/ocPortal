{+START,IF,{$NOR,{$GET,login_screen},{$MATCH_KEY_MATCH,_WILD:login}}}
	<section class="box box___block_side_personal_stats_no"><div class="box_inner">
		{+START,IF_NON_EMPTY,{TITLE}}<h3>{TITLE}</h3>{+END}

		<form title="{!_LOGIN}" onsubmit="if (check_field_for_blankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete">
			<div>
				<div class="constrain_field">
					<div class="accessibility_hidden"><label for="s_login_username">{!USERNAME}{+START,IF,{$AND,{$OCF},{$CONFIG_OPTION,one_per_email_address}}} / {!EMAIL_ADDRESS}{+END}</label></div>
					<div class="accessibility_hidden"><label for="s_password">{!PASSWORD}</label></div>
					<input maxlength="80" accesskey="l" class="wide_field login_block_username" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="s_login_username" name="login_username" />
					<input maxlength="255" class="wide_field" type="password" value="" name="password" id="s_password" />
				</div>

				<div class="login_block_cookies">
					<div class="float_surrounder">
						<label for="s_remember">{!REMEMBER_ME}</label>
						<input {+START,IF,{$CONFIG_OPTION,remember_me_by_default}}checked="checked" {+END}{+START,IF,{$NOT,{$CONFIG_OPTION,remember_me_by_default}}}onclick="if (this.checked) { var t=this; window.fauxmodal_confirm('{!REMEMBER_ME_COOKIE;}',function(answer) { if (!answer) { t.checked=false; } }); }" {+END}type="checkbox" value="1" id="s_remember" name="remember" />
					</div>
					{+START,IF,{$CONFIG_OPTION,is_on_invisibility}}
						<div class="float_surrounder">
							<label for="login_invisible">{!INVISIBLE}</label>
							<input type="checkbox" value="1" id="login_invisible" name="login_invisible" />
						</div>
					{+END}
				</div>

				<p class="constrain_field"><input class="wide_button" type="submit" value="{!_LOGIN}" /></p>
			</div>
		</form>

		<ul class="horizontal_links associated_links_block_group force_margin">
			{+START,IF_NON_EMPTY,{JOIN_URL}}<li><a href="{JOIN_URL*}">{!_JOIN}</a></li>{+END}
			<li><a onclick="return open_link_as_overlay(this);" rel="nofollow" href="{FULL_LOGIN_URL*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a></li>
		</ul>
	</div></section>
{+END}
