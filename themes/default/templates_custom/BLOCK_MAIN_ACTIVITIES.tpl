<div id="news_feed">
	<h2 class="news-icon">{TITLE*}</h2>
	<div id="newsfeed_info" mode="{MODE}" member_id="{MEMBER_ID}"></div>
	<ul class="float_surrounder news_holder" id="news_holder">
		{+START,LOOP,CONTENT}
			<li id="{LIID}" class="news-box lightborder">
				<div class="avatar-box">
					{+START,IF_EMPTY,{MEMPIC}}
						<img src="{$THUMBNAIL,{$IMG,ocf_default_avatars/default},36x36,avatar_normalise,default.png,{$IMG,ocf_default_avatars/default},pad,both,#FFFFFF00}" />
					{+END}
					{+START,IF_NON_EMPTY,{MEMPIC}}
						<img src="{$THUMBNAIL,{MEMPIC},36x36,avatar_normalise,{NAME}.{$PREG_REPLACE,^(.*)*\.,,{MEMPIC}},{$IMG,ocf_default_avatars/default},pad,both,#FFFFFF00}" />
					{+END}
				</div>
				<div class="news_line">
					<div class="float_surrounder" style="width: auto;">
						<div class="name left">
							<a href="{URL*}">
								{NAME}
							</a>
						</div>
						<div class="time right">
							{$MAKE_RELATIVE_DATE,{DATETIME}} {!AGO}
						</div>

						{+START,IF,{ALLOW_REMOVE}}
							<form id="feed_remove_{LIID}" class="remove" action="{$PAGE_LINK*,:start}" method="post">
								<input type="hidden" value="{LIID}" name="removal_id" />
								<input class="remove_cross" type="submit" value="Remove" name="feed_remove_{LIID}" />
							</form>
						{+END}
					</div>
					<div class="news-content">{BITS}</div>
				</div>
			</li>
		{+END}
	</ul>
</div>
<script type="text/javascript">//<![CDATA[
	// "Grow" means we should keep stacking new content on top of old. If not
	// then we should allow old content to "fall off" the bottom of the feed.
	{+START,IF,{GROW}}
		news_feed_grow = true;
	{+END}
	{+START,IF,{$NOT,{GROW}}}
		news_feed_grow = false;
	{+END}
	news_feed_max = {MAX};
	if (jQuery('#news_feed').length != 0) {
		ugdRefresh = setInterval(sUpdateGetData, 30000); //Refreshes feed every 30 seconds
		ugdCanICant = 0;
		jQuery('form[id*="feed_remove_"]').submit(sUpdateRemove);
	}
//]]></script>