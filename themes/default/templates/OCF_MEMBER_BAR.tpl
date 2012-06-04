<div class="box ocf_information_bar_outer">
	<div class="box_inner">
		<h2>{!MEMBER_INFORMATION,{$USERNAME*}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}} / {!SEARCH}{+END}</h2>

		<div class="ocf_information_bar float_surrounder">
			{+START,IF_NON_EMPTY,{AVATAR_URL}}
				<div{+START,IF,{$NOT,{$MOBILE}}} style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_a">
					<img alt="{!AVATAR}" title="{!AVATAR}" src="{AVATAR_URL*}" />
				</div>
			{+END}

			<div{+START,IF,{$NOT,{$MOBILE}}}  style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_b">
				<p class="ocf_member_column_title">{!WELCOME_BACK,<a href="{PROFILE_URL*}">{USERNAME*}</a>}</p>
				{+START,IF,{$NOT,{$IS_HTTPAUTH_LOGIN}}}
					<form class="inline horiz_field_sep associated_link" title="{!LOGOUT}" method="post" action="{LOGOUT_URL*}"><input class="button_hyperlink" type="submit" value="{!LOGOUT}" /></form>
				{+END}

				<dl class="meta_details_list">
					{+START,IF,{$ADDON_INSTALLED,points}}
						<dt class="field_name">{!POINTS}:</dt> <dd><span title="{!GROUP_ADVANCE,{NUM_POINTS_ADVANCE*}}"><a href="{$PAGE_LINK*,site:points:member:{$USER}}">{NUM_POINTS*}</a></span></dd>
					{+END}
					<dt class="field_name">{!COUNT_POSTS}:</dt> <dd>{NUM_POSTS*}</dd>
					<dt class="field_name">{!PRIMARY_GROUP}:</dt> <dd>{PRIMARY_GROUP*}</dd>
				</dl>
			</div>

			<div{+START,IF,{$NOT,{$MOBILE}}}  style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_c">
				{+START,IF,{$ADDON_INSTALLED,search}}{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,search}}
					{+START,IF,{$EQ,{$PAGE},forumview}}
						{+START,IF,{$EQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_own_pt,1}}" method="get">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_own_pt,1}}

									<div>
										<label class="accessibility_hidden" for="member_bar_search">{!_SEARCH_PRIVATE_TOPICS}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!_SEARCH_PRIVATE_TOPICS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!_SEARCH_PRIVATE_TOPICS;}'; this.className='unfilled_input'; };" class="unfilled_input" value="{!_SEARCH_PRIVATE_TOPICS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_own_pt}" title="{!MORE}: {!SEARCH}">{!MORE}</a>
									</div>
								</form>
							</div>
						{+END}
						{+START,IF,{$NEQ,{$_GET,type},pt}}
							<div class="ocf_search_box">
								<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}" method="get">
									{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}

									<div>
										<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_FORUM_POSTS}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_FORUM_POSTS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_FORUM_POSTS;}'; this.className='unfilled_input'; };" class="unfilled_input" value="{!SEARCH_FORUM_POSTS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_posts:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>
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
									<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_POSTS_WITHIN_TOPIC}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_POSTS_WITHIN_TOPIC;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_POSTS_WITHIN_TOPIC;}'; this.className='unfilled_input'; };" class="unfilled_input" value="{!SEARCH_POSTS_WITHIN_TOPIC}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_within_topic:search_under={$_GET,id}}" title="{!MORE}: {!SEARCH}">{!MORE}</a>
								</div>
							</form>
						</div>
					{+END}
				{+END}{+END}

				<div class="ocf_member_column_last_visit">{!LAST_VISIT,{LAST_VISIT_DATE*}}
					<ul class="meta_details_list">
						<li>{!NEW_TOPICS,{NEW_TOPICS*}}</li>
						<li>{!NEW_POSTS,{NEW_POSTS*}}</li>
					</ul>
				</div>
			</div>

			<nav{+START,IF,{$NOT,{$MOBILE}}}  style="min-height: {$MAX,100,{MAX_AVATAR_HEIGHT|}}px"{+END} class="ocf_member_column ocf_member_column_d" role="navigation">
				{$,<p class="ocf_member_column_title">{!VIEW}:</p>}
				<ul role="navigation" class="actions_list">
					<li><a href="{PRIVATE_TOPIC_URL*}">{!PRIVATE_TOPICS}{+START,IF_NON_EMPTY,{PT_EXTRA}} <span class="ocf_member_column_pts">{PT_EXTRA}</span>{+END}</a></li>
					<li><a href="{NEW_POSTS_URL*}">{!POSTS_SINCE_LAST_VISIT}</a></li>
					<li><a href="{UNREAD_TOPICS_URL*}">{!TOPICS_UNREAD}</a></li>
					<li><a href="{RECENTLY_READ_URL*}">{!RECENTLY_READ}</a></li>
					<li><a href="{INLINE_PERSONAL_POSTS_URL*}">{!INLINE_PERSONAL_POSTS}</a></li>
				</ul>
			</nav>
		</div>
	</div>
</div>
