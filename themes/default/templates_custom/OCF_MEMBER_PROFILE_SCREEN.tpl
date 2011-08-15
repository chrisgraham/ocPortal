<div class="vcard"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ProfilePage"}>
	{TITLE}

	<div class="float_surrounder">
		<div class="ocf_profile_column">
			{+START,IF,{$ADDON_INSTALLED,ocf_avatars}}
				{+START,IF_NON_EMPTY,{AVATAR_URL}}
					<div class="ocf_member_profile_avatar">
						<img src="{AVATAR_URL*}" title="" alt="{!AVATAR}" />
					</div>
				{+END}
			{+END}

			{+START,IF_NON_EMPTY,{COUNT_POINTS}}
				<div class="ocf_profile_points">
					&raquo; <a href="{$PAGE_LINK*,_SEARCH:points:member:{MEMBER_ID}}">{!NUM_POINTS,{COUNT_POINTS*}}</a> &laquo;
				</div>
			{+END}

			<h2>{!USERGROUPS}</h2>

			<ul>
				<li><span class="role">{PRIMARY_GROUP}</span></li>
				{+START,LOOP,SECONDARY_GROUPS}
					<li><a href="{$PAGE_LINK*,_SEARCH:groups:view:{_loop_key}}">{_loop_var*}</a></li>
				{+END}
			</ul>

			{+START,IF,{VIEW_PROFILES}}
				<h2>{!DETAILS}</h2>

				<div class="wide_table_wrap">
					<table class="wide_table ocf_profile_details variable_table" summary="{!MAP_TABLE}">
						<tbody>
							<tr>
								<th class="de_th">{!ONLINE_NOW}:</th>
								<td>{ONLINE_NOW*}<br />({$DATE_AND_TIME*,1,0,0,{LAST_VISIT_TIME_RAW}})</td>
							</tr>

							{+START,IF_NON_EMPTY,{JOIN_DATE}}
								<tr>
									<th class="de_th">{!JOIN_DATE}:</th>
									<td>
										{+START,IF,{$VALUE_OPTION,html5}}
											<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{JOIN_DATE_RAW}}" pubdate="pubdate" itemprop="datePublished">{JOIN_DATE*}</time>
										{+END}
										{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
											{JOIN_DATE*}
										{+END}
									</td>
								</tr>
							{+END}

							{+START,IF_PASSED,ON_PROBATION}
								<tr>
									<th class="de_th">{!ON_PROBATION_UNTIL}:</th>
									<td>{$DATE_AND_TIME*,1,0,0,{ON_PROBATION}}</td>
								</tr>
							{+END}

							<tr>
								<th class="de_th">{!TIME_FOR_THEM}:</th>
								<td>{TIME_FOR_THEM*}</td>
							</tr>

							{+START,IF_NON_EMPTY,{BANNED}}
								<tr>
									<th class="de_th">{!_BANNED}:</th>
									<td>{BANNED*}</td>
								</tr>
							{+END}

							{+START,IF_NON_EMPTY,{DOB}}
								<tr>
									<th class="de_th">{!DATE_OF_BIRTH}:</th>
									<td><span class="bday">{DOB*}</span></td>
								</tr>
							{+END}

							{+START,IF,{$HAS_SPECIFIC_PERMISSION,member_maintenance}}{+START,IF_NON_EMPTY,{EMAIL_ADDRESS}}
								<tr>
									<th class="de_th">{!EMAIL_ADDRESS}:</th>
									<td><a class="email" href="mailto:{EMAIL_ADDRESS*}">{$TRUNCATE_LEFT,{EMAIL_ADDRESS*},12}</a></td>
								</tr>
							{+END}{+END}

							{+START,LOOP,EXTRA_INFO_DETAILS}
								<tr>
									<th class="de_th">{_loop_key*}:</th>
									<td><span class="role">{_loop_var*}</span></td>
								</tr>
							{+END}
						</tbody>
					</table>
				</div>

				{+START,IF_NON_EMPTY,{$USER_FB_CONNECT,{MEMBER_ID}}}
					<div class="button_panel">
						<a href="http://www.facebook.com/profile.php?id={$USER_FB_CONNECT*,{MEMBER_ID}}"><img title="" alt="Facebook" src="{$IMG*,facebook}" /></a>
					</div>
				{+END}

				{+START,IF_NON_EMPTY,{PHOTO_URL}}
					<h2>{!PHOTO}</h2>

					<div class="ocf_member_profile_photo">
						<a href="{PHOTO_URL*}"><img src="{PHOTO_THUMB_URL*}" title="" alt="{!PHOTO}" class="photo"{$?,{$VALUE_OPTION,html5}, itemprop="primaryImageOfPage"} /></a>
					</div>
				{+END}
			{+END}

			{+START,IF_NON_EMPTY,{ACTIONS_contact}{$GET,messenger_fields}}
				<div>
					<h2>
						<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!CONTRACT}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>
						<a class="non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">{!CONTACT}</a>
					</h2>

					<{$?,{$VALUE_OPTION,html5},nav,div} class="hide_tag" style="display: block">
						<ul>
							{ACTIONS_contact}
							{$GET,messenger_fields}
						</ul>
					</{$?,{$VALUE_OPTION,html5},nav,div}>
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{ACTIONS_content}}
				<div>
					<h2>
						<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
						<a class="non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">{!CONTENT}</a>
					</h2>

					<{$?,{$VALUE_OPTION,html5},nav,div} class="hide_tag" style="display: {$JS_ON,none,block}">
						<ul>
							{ACTIONS_content}
						</ul>
					</{$?,{$VALUE_OPTION,html5},nav,div}>
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{ACTIONS_views}{ACTIONS_profile}}
				<div>
					<h2>
						<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
						<a class="non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">{!PERSONAL_ZONE}</a>
					</h2>

					<{$?,{$VALUE_OPTION,html5},nav,div} class="hide_tag" style="display: {$JS_ON,none,block}">
						<ul>
							{ACTIONS_views}
							{ACTIONS_profile}
						</ul>
					</{$?,{$VALUE_OPTION,html5},nav,div}>
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{ACTIONS_usage}}
				<{$?,{$VALUE_OPTION,html5},nav,div}>
					<h2>
						<a class="hide_button" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
						<a class="non_link" href="#" onclick="event.returnValue=false; hideTag(this.parentNode.parentNode); return false;">{!USAGE}</a>
					</h2>

					<div class="hide_tag" style="display: {$JS_ON,none,block}">
						<ul>
							{ACTIONS_usage}
						</ul>
					</div>
				</{$?,{$VALUE_OPTION,html5},nav,div}>
			{+END}
		</div>

		<div class="ocf_profile_main">
			{+START,IF,{$NOT,{VIEW_PROFILES}}}
				<p class="important_notification">
					{!ACCESS_DENIED}
				</p>
			{+END}

			<div class="wide_table_wrap">
				<table class="wide_table ocf_profile_fields" summary="{!MAP_TABLE}">
					<colgroup>
						<col style="width: 190px" />
						<col style="width: 100%" />
					</colgroup>

					<tbody>
						{+START,IF,{VIEW_PROFILES}}
							{+START,LOOP,CUSTOM_FIELDS}
								{$SET,is_messenger_field,{$EQ,{NAME},{!DEFAULT_CPF_im_msn_NAME},{!DEFAULT_CPF_im_aim_NAME},{!DEFAULT_CPF_im_yahoo_NAME},{!DEFAULT_CPF_im_skype_NAME},{!DEFAULT_CPF_im_icq_NAME}}}
								{+START,IF,{$GET,is_messenger_field}}
									{+START,SET,messenger_fields}
										{$GET,messenger_fields}
										{+START,IF,{$EQ,{NAME},{!DEFAULT_CPF_im_msn_NAME}}}<li><a title="{!ADD_AS_FRIEND}: {!LINK_NEW_WINDOW}" href="msnim:add?contact={VALUE*}">{!ADD_AS_FRIEND}</a></li>{+END}
										{+START,IF,{$EQ,{NAME},{!DEFAULT_CPF_im_aim_NAME}}}<li><a title="{!MESSAGE_THEM}: {!LINK_NEW_WINDOW}" href="aim:goim?screename={VALUE*}">{!MESSAGE_THEM}</a></li>{+END}
										{+START,IF,{$EQ,{NAME},{!DEFAULT_CPF_im_yahoo_NAME}}}<li><a title="{!ADD_AS_FRIEND}: {!LINK_NEW_WINDOW}" href="ymsgr:addfriend?{VALUE*}">{!ADD_AS_FRIEND}</a></li>{+END}
										{+START,IF,{$EQ,{NAME},{!DEFAULT_CPF_im_skype_NAME}}}<li><a title="{!PHONE_THEM_UP}: {!LINK_NEW_WINDOW}" href="skype:{VALUE*}?call">{!PHONE_THEM_UP}</a></li>{+END}
										{+START,IF,{$EQ,{NAME},{!DEFAULT_CPF_im_icq_NAME}}}<li><a title="{!MESSAGE_THEM}: {!LINK_NEW_WINDOW}" href="http://www.icq.com/people/cmd.php?uin={VALUE*}&amp;action=message">{!MESSAGE_THEM}</a></li>{+END}
									{+END}
								{+END}
								{+START,IF,{$NOT,{$GET,is_messenger_field}}}
									<tr>
										<th class="de_th">
											{NAME*}:
										</th>

										<td>
											<span{+START,IF,{$EQ,{NAME},{!SPECIAL_CPF__ocp_fullname}}} class="fn given-name"{+END}>
												{+START,IF_EMPTY,{ENCRYPTED_VALUE}}
													{$PREG_REPLACE,\|,\,,{$PREG_REPLACE,\n,<br />,{VALUE}}}
												{+END}
												{+START,IF_NON_EMPTY,{ENCRYPTED_VALUE}}
													{+START,IF,{$JS_ON}}{!DATA_ENCRYPTED} <a href="javascript:decrypt_data('{ENCRYPTED_VALUE;}');" title="{!DECRYPT_DATA}: {!DESCRIPTION_DECRYPT_DATA*}">{!DECRYPT_DATA}</a>{+END}
													{+START,IF,{$NOT,{$JS_ON}}}{ENCRYPTED_VALUE*}{+END}
												{+END}
											</span>
										</td>
									</tr>
								{+END}
							{+END}
						{+END}

						{+START,IF_NON_EMPTY,{SIGNATURE}}
							<tr>
								<th class="de_th">
									{!SIGNATURE}:
								</th>

								<td>
									{SIGNATURE}
								</td>
							</tr>
						{+END}
					</tbody>
				</table>
			</div>

			{+START,IF,{$ADDON_INSTALLED,chat}}{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}{REMOVE_FRIEND_URL}{FRIENDS_A}{FRIENDS_B}}
				<h2>{!FRIENDS}</h2>

				{+START,IF_NON_EMPTY,{ADD_FRIEND_URL}{REMOVE_FRIEND_URL}{ALL_BUDDIES_LINK}}
					<p class="ocf_profile_add_friend">
						[ {+START,IF_NON_EMPTY,{ADD_FRIEND_URL}}
							<a href="{ADD_FRIEND_URL*}">{!_ADD_AS_FRIEND,{USERNAME*}}</a>
						{+END}
						{+START,IF_NON_EMPTY,{REMOVE_FRIEND_URL}}
							<a href="{REMOVE_FRIEND_URL*}">{!_REMOVE_AS_FRIEND,{USERNAME*}}</a>
						{+END}
						{+START,IF_NON_EMPTY,{ALL_BUDDIES_LINK}}
							<a href="{ALL_BUDDIES_LINK*}">{!VIEW_ARCHIVE}</a>
						{+END} ]
					</p>
				{+END}

				{+START,IF_NON_EMPTY,{FRIENDS_A}{FRIENDS_B}}
					<ul class="ocf_profile_friends">
						{+START,LOOP,FRIENDS_A}
							<li onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{BOX*;~}','500px');">&raquo; <a href="{URL*}">{USERNAME*}</a><br />&nbsp;&nbsp;&nbsp;{USERGROUP*}</li>
						{+END}
						{+START,LOOP,FRIENDS_B}
							<li onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{BOX*;~}','500px');">&raquo; <a href="{URL*}">{USERNAME*}</a><br />&nbsp;&nbsp;&nbsp;{USERGROUP*}</li>
						{+END}
					</ul>
				{+END}
			{+END}{+END}

			{+START,LOOP,EXTRA_SECTIONS}
				{_loop_var}
			{+END}

			{+START,IF_NON_EMPTY,{GALLERIES}}
				<h2>{!galleries:GALLERIES}</h2>

				<ul class="category_list">
					{GALLERIES}
				</ul>
			{+END}

			{+START,IF_NON_EMPTY,{RECENT_BLOG_POSTS}}
				{$,Commented out <h2>{!RECENT_BLOG_POSTS}</h2>}

				{$,Commented out {RECENT_BLOG_POSTS}}
			{+END}

			{+START,IF,{VIEW_PROFILES}}
				<h2>{!STATISTICS}</h2>

				<div class="wide_table_wrap">
					<table class="wide_table variable_table ocf_profile_statistics" summary="{!MAP_TABLE}">
						<tbody>
							{+START,IF,{$ADDON_INSTALLED,ocf_forum}}
								<tr>
									<th class="de_th">{!COUNT_POSTS}:</th>
									<td>{COUNT_POSTS*}</td>
								</tr>
							{+END}

							{+START,IF_NON_EMPTY,{MOST_ACTIVE_FORUM}}
								<tr>
									<th class="de_th">{!MOST_ACTIVE_FORUM}:</th>
									<td>{MOST_ACTIVE_FORUM*}</td>
								</tr>
							{+END}

							<tr>
								<th class="de_th">{!LAST_SUBMIT_TIME}:</th>
								<td>{!DAYS_AGO,{SUBMIT_DAYS_AGO}}</td>
							</tr>

							{+START,IF_NON_EMPTY,{IP_ADDRESS}}
								<tr>
									<th class="de_th">{!IP_ADDRESS}:</th>
									<td><a href="{$PAGE_LINK*,_SEARCH:admin_lookup:param={IP_ADDRESS&}}">{IP_ADDRESS*}</a></td>
								</tr>
							{+END}

							{+START,IF_PASSED,USER_AGENT}
								<tr>
									<th class="de_th">{!USER_AGENT}:</th>
									<td>{USER_AGENT*}</td>
								</tr>
							{+END}

							{+START,IF_PASSED,OPERATING_SYSTEM}
								<tr>
									<th class="de_th">{!USER_OS}:</th>
									<td>{OPERATING_SYSTEM*}</td>
								</tr>
							{+END}
						</tbody>
					</table>
				</div>
			{+END}
		</div>
	</div>
</div>

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={EDIT_PROFILE_URL*}
	1_TITLE={!EDIT_PROFILE}
	1_ACCESSKEY=q
	1_REL=edit
	2_URL={EDIT_AVATAR_URL*}
	2_TITLE={!EDIT_AVATAR}
	3_URL={EDIT_PHOTO_URL*}
	3_TITLE={!EDIT_PHOTO}
	4_URL={EDIT_SIGNATURE_URL*}
	4_TITLE={!EDIT_SIGNATURE}
	5_URL={EDIT_TITLE_URL*}
	5_TITLE={!EDIT_TITLE}
	6_URL={DELETE_MEMBER_URL*}
	6_TITLE={!DELETE_MEMBER}
{+END}
