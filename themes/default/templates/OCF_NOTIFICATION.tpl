<div class="solidborder ocf_notification ocf_row1">
	<span class="ocf_notification_type">{TYPE*}</span><br />
	{!NEW_PT_NOTIFICATION_DETAILS,{U_TITLE*},,<a href="{PROFILE_LINK*}">{BY*}</a>,{TIME*}}
	<div class="ocf_notification_post">{$TRUNCATE_LEFT,{POST},1000,0,1}</div>

	<div class="ocf_notification_view">
		<a href="{TOPIC_URL*}" title="{!VIEW}: {!FORUM_POST} #{ID*}">{!VIEW}</a>{+START,IF,{$NEQ,{_ADDITIONAL_POSTS},0}}{!ADDITIONAL_PT_POSTS,{ADDITIONAL_POSTS}}{+END} &middot;
		<a href="{REPLY_URL*}" title="{!REPLY}: {!FORUM_POST} #{ID*}">{!REPLY}</a> &middot;
		<a onclick="do_ajax_request('{IGNORE_URL_2*;}'); var o=this.parentNode.parentNode; o.parentNode.removeChild(o); var nots=get_elements_by_class_name(document,'ocf_member_column_pts'); if ((nots[0]) &amp;&amp; (get_elements_by_class_name(document,'ocf_notification').length==0)) nots[0].parentNode.removeChild(nots[0]); return false;" href="{IGNORE_URL*}" title="{!IGNORE}: {!FORUM_POST} #{ID*}">{!IGNORE}</a>
	</div>
</div>
<br />
