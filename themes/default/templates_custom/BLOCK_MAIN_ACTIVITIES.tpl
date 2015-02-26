<div class="float_surrounder">
	<div id="activities_feed">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h2 class="activities_icon">{TITLE*}</h2>
		{+END}

		<div id="activities_general_notify"></div>
		<ul class="float_surrounder activities_holder" id="activities_holder">
			{+START,IF_EMPTY,{CONTENT}}
				<li id="activity_-1"><p class="nothing_here">{!NO_ACTIVITIES}</p></li>
			{+END}

			{+START,LOOP,CONTENT}
				<li id="activity_{LIID*}" class="activities_box box">
					{+START,INCLUDE,ACTIVITY}{+END}
				</li>
			{+END}
		</ul>
	</div>

	{PAGINATION}
</div>

<script type="text/javascript">//<![CDATA[
	window.activities_mode='{MODE;/}';
	window.activities_member_ids='{MEMBER_IDS;/}';

	{+START,IF_PASSED,MAX}
		// "Grow" means we should keep stacking new content on top of old. If not
		// then we should allow old content to "fall off" the bottom of the feed.
		{+START,IF,{GROW}}
			window.activities_feed_grow=true;
		{+END}
		{+START,IF,{$NOT,{GROW}}}
			window.activities_feed_grow=false;
		{+END}
		window.activities_feed_max={MAX%};
		if (jQuery('#activities_feed').length!=0) {
			window.setInterval(s_update_get_data,{REFRESH_TIME}*1000);
		}
	{+END}
//]]></script>
