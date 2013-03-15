<section id="tray_{!MEMBER|}" class="box ocf_information_bar_outer">
	<h2 class="toggleable_tray_title">
		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{!MEMBER|}');"><img alt="{!CONTRACT}: {$STRIP_TAGS,{!_LOGIN}}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>

		<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{!MEMBER|}');">{!_LOGIN}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}} / {!SEARCH}{+END}</a>
	</h2>

	<div class="toggleable_tray">
		<div class="ocf_information_bar float_surrounder">
			<div class="ocf_guest_column ocf_guest_column_a">
				<form title="{!_LOGIN}" onsubmit="if (check_field_for_blankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete inline">
					<div>
						<div class="accessibility_hidden"><label for="member_bar_login_username">{!USERNAME}{+START,IF,{$AND,{$OCF},{$CONFIG_OPTION,one_per_email_address}}} / {!EMAIL_ADDRESS}{+END}</label></div>
						<div class="accessibility_hidden"><label for="member_bar_s_password">{!PASSWORD}</label></div>
						<input accesskey="l" size="15" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="member_bar_login_username" name="login_username" />
						<input size="15" type="password" value="password" name="password" id="member_bar_s_password" />
						<label for="remember">{!REMEMBER_ME}</label> <input {+START,IF,{$CONFIG_OPTION,remember_me_by_default}}checked="checked" {+END}{+START,IF,{$NOT,{$CONFIG_OPTION,remember_me_by_default}}}onclick="if (this.checked) { var t=this; window.fauxmodal_confirm('{!REMEMBER_ME_COOKIE;}',function(answer) { if (!answer) { .checked=false; } }); }" {+END}type="checkbox" value="1" id="remember" name="remember" />
						<input class="button_pageitem" type="submit" value="{!_LOGIN}" />

						{+START,IF_EMPTY,{$FB_CONNECT_UID}}
							{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
								<div class="fb-login-button" data-scope="email,user_birthday"></div>
							{+END}
						{+END}
						<ul class="horizontal_links associated_links_block_group horiz_field_sep">
							<li><a href="{JOIN_URL*}">{!_JOIN}</a></li>
							<li><a onclick="return open_link_as_overlay(this);" rel="nofollow" href="{FULL_LOGIN_URL*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a></li>
						</ul>
					</div>
				</form>
			</div>
			{+START,IF,{$ADDON_INSTALLED,search}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}}
				<div class="ocf_guest_column ocf_guest_column_b">
					{+START,INCLUDE,MEMBER_BAR_SEARCH}{+END}
				</div>
			{+END}{+END}
		</div>
	</div>
</section>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		{+START,IF,{$JS_ON}}
			handle_tray_cookie_setting('{!MEMBER|}');
		{+END}
	} );
//]]></script>

