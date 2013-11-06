{$REQUIRE_JAVASCRIPT,javascript_ocf_forum}
{$REQUIRE_JAVASCRIPT,javascript_ajax}

<div class="box ocf_notification"><div class="box_inner">
	<p>
		{!ocf:NEW_PT_NOTIFICATION_DETAILS,<span class="ocf_notification_type">{TYPE*}</span>,{U_TITLE*},{$?,{$IS_EMPTY,{PROFILE_URL}},{BY*},<a href="{PROFILE_URL*}">{BY*}</a>},{TIME*}}
	</p>

	<div class="ocf_notification_post">
		{$TRUNCATE_LEFT,{POST},1000,0,1}
	</div>

	<ul class="horizontal_links associated_links_block_group force_margin">
		<li><span><a href="{TOPIC_URL*}" title="{!VIEW}: {!ocf:FORUM_POST} #{ID*}">{!VIEW}</a></span>{+START,IF,{$NEQ,{_ADDITIONAL_POSTS},0}} <img onkeydown="this.onmouseover(event);" onkeyup="this.onmouseout(event);" onclick="this.onmouseover(event);" title="{!ocf:ADDITIONAL_PT_POSTS,{ADDITIONAL_POSTS}}" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,help}" class="top_vertical_alignment help_icon" />{+END}</li>
		<li><a href="{REPLY_URL*}" title="{!REPLY}: {!ocf:FORUM_POST} #{ID*}">{!REPLY}</a></li>
		<li><a onclick="return ignore_ocf_notification('{IGNORE_URL_2*;}',this);" href="{IGNORE_URL*}" title="{!ocf:MARK_READ}: {!ocf:FORUM_POST} #{ID*}">{!IGNORE}</a></li>
	</ul>
</div></div>

