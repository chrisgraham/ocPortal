<ul class="tabs">
	<li class="active"><a href="#xtab1" onclick="return music_select_tab(this.parentNode,'xtab1','xtab');">Members Area</a></li>
	<li><a href="#xtab2" onclick="return music_select_tab(this.parentNode,'xtab2','xtab');">Forget Password</a></li>
	<li><a href="#xtab3" onclick="return music_select_tab(this.parentNode,'xtab3','xtab');">New User?</a></li>
</ul>
<div class="tab_container">
	<div style="display: block;" id="xtab1" class="tab_content">
		<form action="{LOGIN_URL*}" method="post" class="login autocomplete">
			<input type="submit" class="login-button" value="LOGIN"/>
			<input type="hidden" value="1" id="remember" name="remember" />
			<div class="accessibility_hidden"><label for="login_username">{!USERNAME}</label></div><input maxlength="80" onclick="return open_link_as_overlay(this);" accesskey="l" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="login_username" name="login_username" class="login-box"/>
			<div class="accessibility_hidden"><label for="s_password">{!PASSWORD}</label></div><input maxlength="255" type="password" value="" name="password" id="s_password" class="login-box" />
		</form>
	</div>
	<div style="display: none;" id="xtab2" class="tab_content">
		<h2>Forgot password?</h2>

		<p>&raquo; <a href="{$PAGE_LINK*,:lostpassword}">Reset password</a></p>
	</div>
	<div style="display: none;" id="xtab3" class="tab_content">
		<h2>New User?</h2>
		
		<p>&raquo; <a href="{JOIN_LINK*}">{!_JOIN}</a></p>
	</div>
</div>
