<div class="box ocf_information_bar_outer">
	<div class="box_inner">
		<h2>{!_LOGIN}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}} / {!SEARCH}{+END}</h2>

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
								<span xmlns:fb="http://api.facebook.com/1.0/">
									<fb:login-button scope="email,user_birthday"></fb:login-button>
								</span>
							{+END}
						{+END}
						<ul class="horizontal_links associated_links_block_group horiz_field_sep">
							<li><a href="{JOIN_URL*}">{!_JOIN}</a></li>
							<li><a onclick="return open_link_as_overlay(this);" rel="nofollow" href="{FULL_LOGIN_URL*}" title="{!MORE}: {!_LOGIN}">{!MORE}</a></li>
						</ul>
					</div>
				</form>
			</div>
			{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}}
				<div class="ocf_guest_column ocf_guest_column_b">
					{+START,IF,{$EQ,{$PAGE},forumview}}
						{+START,IF,{$EQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_own_pt,1}}" method="get">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_own_pt,1}}

									<div>
										<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_PRIVATE_TOPICS}</label><input type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_PRIVATE_TOPICS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_PRIVATE_TOPICS;}'; this.className='unfilled_input'; };" class="unfilled_input" value="{!SEARCH_PRIVATE_TOPICS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_own_pt}" title="{!MORE}: {!SEARCH}">{!MORE}</a>
									</div>
								</form>
							</div>
						{+END}
						{+START,IF,{$NEQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}" method="get">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}

									<div>
										<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_FORUM_POSTS}</label><input type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_FORUM_POSTS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_FORUM_POSTS;}'; this.className='unfilled_input'; };" class="unfilled_input" value="{!SEARCH_FORUM_POSTS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_posts:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>
									</div>
								</form>
							</div>
						{+END}
					{+END}
					{+START,IF,{$EQ,{$PAGE},topicview}}
						<div class="ocf_search_box">
							<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}" method="get">
								{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}

								<div>
									<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_POSTS_WITHIN_TOPIC}</label><input type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_POSTS_WITHIN_TOPIC;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_POSTS_WITHIN_TOPIC;}'; this.className='unfilled_input'; };" class="unfilled_input" value="{!SEARCH_POSTS_WITHIN_TOPIC}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_within_topic:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>
								</div>
							</form>
						</div>
					{+END}
				</div>
			{+END}
		</div>
	</div>
</div>

