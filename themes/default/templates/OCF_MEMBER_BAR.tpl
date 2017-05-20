<div class="standardbox_wrap_light ocf_information_bar_outer">
	<div class="standardbox_classic">
		<h2 class="standardbox_title_light">{!MEMBER_INFORMATION,{$USERNAME*}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}} / {!SEARCH}{+END}</h2>

		<div class="ocf_information_bar float_surrounder">
			{+START,IF_NON_EMPTY,{AVATAR}}
				<div{+START,IF,{$NOT,{$MOBILE}}} style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_a">
					<img alt="{!AVATAR}" title="{!AVATAR}" src="{AVATAR*}" />
				</div>
			{+END}

			<div{+START,IF,{$NOT,{$MOBILE}}}  style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_b">
				<span class="ocf_member_column_title">{!WELCOME_BACK,<a href="{PROFILE_URL*}">{USERNAME*}</a>}</span><br />
				{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
					<span class="ocf_member_column_logout">(<form title="{!LOGOUT}" class="inline" method="post" action="{LOGOUT_URL*}"><input class="buttonhyperlink" type="submit" value="{!LOGOUT}" /></form>)</span><br />
				{+END}
				<br />
				{+START,IF,{$ADDON_INSTALLED,points}}
					{!POINTS}: <span title="{!GROUP_ADVANCE,{NUM_POINTS_ADVANCE*}}"><a href="{$PAGE_LINK*,site:points:member:{$USER}}">{NUM_POINTS*}</a></span><br />
				{+END}
				{!COUNT_POSTS}: {NUM_POSTS*}<br />
				{!PRIMARY_GROUP}: {PRIMARY_GROUP*}<br />
			</div>

			<div{+START,IF,{$NOT,{$MOBILE}}}  style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_c">
				{+START,IF,{$ADDON_INSTALLED,search}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}}
					{+START,IF,{$EQ,{$PAGE},forumview}}
						{+START,IF,{$EQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_own_pt,1}}" method="get" onsubmit="if (this.elements['content'].value==this.elements['content'].alt) this.elements['content'].value='';">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_own_pt,1}}

									<div>
										<label class="accessibility_hidden" for="search">{!_SEARCH_PERSONAL_TOPICS}</label><input maxlength="255" type="text" name="content" id="search" onfocus="if (this.value=='{!_SEARCH_PERSONAL_TOPICS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!_SEARCH_PERSONAL_TOPICS;}'; this.className='input_box_label_within'; };" class="input_box_label_within" alt="{!_SEARCH_PERSONAL_TOPICS}" value="{!_SEARCH_PERSONAL_TOPICS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> &nbsp;<span class="associated_link_to_small">[<a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_own_pt}" title="{!MORE}: {!SEARCH}">{!MORE}</a>]</span>
									</div>
								</form>
							</div>
						{+END}
						{+START,IF,{$NEQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}" method="get" onsubmit="if (this.elements['content'].value==this.elements['content'].alt) this.elements['content'].value='';">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}

									<div>
										<label class="accessibility_hidden" for="search">{!SEARCH_FORUM_POSTS}</label><input maxlength="255" type="text" name="content" id="search" onfocus="if (this.value=='{!SEARCH_FORUM_POSTS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_FORUM_POSTS;}'; this.className='input_box_label_within'; };" class="input_box_label_within" alt="{!SEARCH_FORUM_POSTS}" value="{!SEARCH_FORUM_POSTS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> &nbsp;<span class="associated_link_to_small">[<a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_posts:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>]</span>
									</div>
								</form>
							</div>
						{+END}
					{+END}
					{+START,IF,{$EQ,{$PAGE},topicview}}
						<div class="ocf_search_box">
							<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}" method="get" onsubmit="if (this.elements['content'].value==this.elements['content'].alt) this.elements['content'].value='';">
								{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}

								<div>
									<label class="accessibility_hidden" for="search">{!SEARCH_POSTS_WITHIN_TOPIC}</label><input maxlength="255" type="text" name="content" id="search" onfocus="if (this.value=='{!SEARCH_POSTS_WITHIN_TOPIC;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_POSTS_WITHIN_TOPIC;}'; this.className='input_box_label_within'; };" class="input_box_label_within" alt="{!SEARCH_POSTS_WITHIN_TOPIC}" value="{!SEARCH_POSTS_WITHIN_TOPIC}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> &nbsp;<span class="associated_link_to_small">[<a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_within_topic:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>]</span>
								</div>
							</form>
						</div>
					{+END}
				{+END}{+END}

				<div class="ocf_member_column_last_visit">{!LAST_VISIT,{LAST_VISIT_DATE*}}
					<ul>
						<li>{!NEW_TOPICS,{NEW_TOPICS*}}</li>
						<li>{!NEW_POSTS,{NEW_POSTS*}}</li>
					</ul>
				</div>
			</div>

			<{$?,{$VALUE_OPTION,html5},nav,div}{+START,IF,{$NOT,{$MOBILE}}}  style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_d"{$?,{$VALUE_OPTION,html5}, role="navigation"}>
				<span class="ocf_member_column_title">{!VIEW}:</span>
				<ul{$?,{$VALUE_OPTION,html5}, role="navigation"} class="actions_list_compact">
					<li>&raquo; <a href="{PERSONAL_TOPIC_URL*}">{!PERSONAL_TOPICS}{+START,IF_NON_EMPTY,{PT_EXTRA}} <span class="ocf_member_column_pts">{PT_EXTRA}</span>{+END}</a></li>
					<li>&raquo; <a href="{NEW_POSTS_URL*}">{!POSTS_SINCE_LAST_VISIT}</a></li>
					<li>&raquo; <a href="{UNREAD_TOPICS_URL*}">{!TOPICS_UNREAD}</a></li>
					<li>&raquo; <a href="{RECENTLY_READ_URL*}">{!RECENTLY_READ}</a></li>
					<li>&raquo; <a href="{INLINE_PERSONAL_POSTS_URL*}">{!INLINE_PERSONAL_POSTS}</a></li>
				</ul>
			</{$?,{$VALUE_OPTION,html5},nav,div}>
		</div>
	</div>
</div>
