{$REQUIRE_JAVASCRIPT,javascript_ocf_forum}
{$REQUIRE_JAVASCRIPT,javascript_ajax}

<div class="box ocf_notification"><div class="box_inner">
	<p onclick="/*Access-note: code has other activation*/ return toggleable_tray(this.parentNode,false);" class="ocf_notification_intro_line">
		<a class="toggleable_tray_button" href="#" onclick="return false;"><img alt="{!EXPAND}: {TYPE*}" title="{!EXPAND}" src="{$IMG*,1x/trays/expand}" srcset="{$IMG*,2x/trays/expand} 2x" /></a>

		{!ocf:NEW_PT_NOTIFICATION_DETAILS,<span class="ocf_notification_type">{TYPE*}</span>,<span class="ocf_notification_type_title">{U_TITLE*}</span>,<span class="ocf_notification_by">{$?,{$IS_EMPTY,{PROFILE_URL}},{$DISPLAYED_USERNAME*,{BY}},<a href="{PROFILE_URL*}">{$DISPLAYED_USERNAME*,{BY}}</a>}</span>,<span class="ocf_notification_time">{TIME*}</span>}
	</p>

	<div class="toggleable_tray" style="display: none" aria-expanded="false">
		<div class="ocf_notification_post">
			{$TRUNCATE_LEFT,{POST},1000,0,1}
		</div>

		<ul class="horizontal_links associated_links_block_group force_margin">
			<li><span><a href="{TOPIC_URL*}" title="{!VIEW}: {!FORUM_POST} #{ID*}">{!VIEW}</a></span>{+START,IF,{$NEQ,{_ADDITIONAL_POSTS},0}} <img onkeydown="this.onmouseover(event);" onkeyup="this.onmouseout(event);" onclick="this.onmouseover(event);" title="{!ocf:ADDITIONAL_PT_POSTS,{ADDITIONAL_POSTS}}" onmouseover="if (typeof this.ttitle=='undefined') this.ttitle=this.title; if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,this.ttitle,'auto',null,null,false,true);" alt="{!HELP}" src="{$IMG*,1x/help}" srcset="{$IMG*,2x/help} 2x" class="top_vertical_alignment" />{+END}</li>
			<li><a href="{REPLY_URL*}" title="{!REPLY}: {!FORUM_POST} #{ID*}">{!REPLY}</a></li>
			<li><a onclick="return ignore_ocf_notification('{IGNORE_URL_2;*}',this);" href="{IGNORE_URL*}" title="{!MARK_READ}: {!FORUM_POST} #{ID*}">{!IGNORE}</a></li>
		</ul>
	</div>
</div></div>

