<div class="standardbox_wrap_light ocf_information_bar_outer">
	<div class="standardbox_classic">
		<h2 class="standardbox_title_light">{!_LOGIN}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}} / {!SEARCH}{+END}</h2>

		<div class="ocf_information_bar float_surrounder">
			<div class="ocf_guest_column ocf_guest_column_a">
				<form onsubmit="if (checkFieldForBlankness(this.elements['login_username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{LOGIN_URL*}" method="post" class="autocomplete inline">
					<div>
						<div class="accessibility_hidden"><label for="login_username">{!USERNAME}{+START,IF,{$AND,{$OCF},{$CONFIG_OPTION,one_per_email_address}}} / {!EMAIL_ADDRESS}{+END}</label></div>
						<div class="accessibility_hidden"><label for="s_password">{!PASSWORD}</label></div>
						<input accesskey="l" size="15" type="text" onfocus="if (this.value=='{!USERNAME;}'){ this.value=''; password.value=''; }" value="{!USERNAME}" id="login_username" name="login_username" />
						<input size="15" type="password" value="password" name="password" id="s_password" />
						<label for="remember">{!REMEMBER_ME}</label> <input {+START,IF,{$CONFIG_OPTION,remember_me_by_default}}checked="checked" {+END}{+START,IF,{$NOT,{$CONFIG_OPTION,remember_me_by_default}}}onclick="if (this.checked) { var t=this; window.fauxmodal_confirm('{!REMEMBER_ME_COOKIE;}',function(answer) { if (!answer) { .checked=false; } }); }" {+END}type="checkbox" value="1" id="remember" name="remember" />
						<input class="button_pageitem" type="submit" value="{!_LOGIN}" />
						{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
							<span xmlns:fb="http://api.facebook.com/1.0/">
								<fb:login-button scope="email,user_birthday"></fb:login-button>
							</span>
						{+END}
						<span class="button_options_spacer">[ <a href="{JOIN_LINK*}">{!_JOIN}</a> | <a onclick="return open_link_as_overlay(this);" href="{FULL_LINK*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a> ]</span>
					</div>
				</form>
			</div>
			{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}}
				<div class="ocf_guest_column ocf_guest_column_b">
					{+START,IF,{$EQ,{$PAGE},forumview}}
						{+START,IF,{$EQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_own_pt,1}}" method="get">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_own_pt,1}}

									<div>
										<label class="accessibility_hidden" for="search">{!SEARCH_PERSONAL_TOPICS}</label><input type="text" name="content" id="search" onfocus="if (this.value=='{!SEARCH_PERSONAL_TOPICS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_PERSONAL_TOPICS;}'; this.className='input_box_label_within'; };" class="input_box_label_within" value="{!SEARCH_PERSONAL_TOPICS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> &nbsp;<span class="associated_link_to_small">[<a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_own_pt}" title="{!MORE}: {!SEARCH}">{!MORE}</a>]</span>
									</div>
								</form>
							</div>
						{+END}
						{+START,IF,{$NEQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}" method="get">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}

									<div>
										<label class="accessibility_hidden" for="search">{!SEARCH_FORUM_POSTS}</label><input type="text" name="content" id="search" onfocus="if (this.value=='{!SEARCH_FORUM_POSTS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_FORUM_POSTS;}'; this.className='input_box_label_within'; };" class="input_box_label_within" value="{!SEARCH_FORUM_POSTS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> &nbsp;<span class="associated_link_to_small">[<a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_posts:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>]</span>
									</div>
								</form>
							</div>
						{+END}
					{+END}
					{+START,IF,{$EQ,{$PAGE},topicview}}
						<div class="ocf_search_box">
							<form action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}" method="get">
								{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}

								<div>
									<label class="accessibility_hidden" for="search">{!SEARCH_POSTS_WITHIN_TOPIC}</label><input type="text" name="content" id="search" onfocus="if (this.value=='{!SEARCH_POSTS_WITHIN_TOPIC;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_POSTS_WITHIN_TOPIC;}'; this.className='input_box_label_within'; };" class="input_box_label_within" value="{!SEARCH_POSTS_WITHIN_TOPIC}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> &nbsp;<span class="associated_link_to_small">[<a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_within_topic:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>]</span>
								</div>
							</form>
						</div>
					{+END}
				</div>
			{+END}
		</div>
	</div>
</div>

