{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
	<div id="{$GET*,wrapper_id}">
		<div class="float_surrounder">
			<div id="activities_feed">
				{+START,IF_NON_EMPTY,{TITLE}}
					<h2 class="activities_icon">{TITLE*}</h2>
				{+END}

				<div id="activitiesfeed_info" mode="{MODE*}" member_ids="{MEMBER_IDS*}"></div>
				<ul class="float_surrounder activities_holder raw_ajax_grow_spot" id="activities_holder">
					{+START,IF_EMPTY,{CONTENT}}
						<li id="-1"><p class="nothing_here">{!NO_ACTIVITIES}</p></li>
					{+END}

					{+START,LOOP,CONTENT}
						<li id="{LIID*}" class="activities_box box">
							{+START,INCLUDE,ACTIVITY}{+END}
						</li>
					{+END}
				</ul>
			</div>

			{+START,IF_NON_EMPTY,{PAGINATION}}
				<div class="float_surrounder ajax_block_wrapper_links">
					{PAGINATION}
				</div>
			{+END}
		</div>

		{+START,IF,{$EQ,{START},0}}
			<script type="text/javascript">//<![CDATA[
				// "Grow" means we should keep stacking new content on top of old. If not
				// then we should allow old content to "fall off" the bottom of the feed.
				{+START,IF,{GROW}}
					var activities_feed_grow=true;
				{+END}
				{+START,IF,{$NOT,{GROW}}}
					var activities_feed_grow=false;
				{+END}
				var activities_feed_max={MAX};
				if (jQuery('#activities_feed').length!=0) {
					var ugdRefresh=setInterval(sUpdateGetData,30000); //Refreshes feed every 30 seconds
					var ugdCanICant=0;
					jQuery('form[id*="feed_remove_"]').submit(sUpdateRemove);
				}
			//]]></script>
		{+END}

		{+START,INCLUDE,AJAX_PAGINATION}ALLOW_INFINITE_SCROLL=1{+END}
	</div>
{+END}

{+START,IF,{$EQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
	{+START,LOOP,CONTENT}
		<li id="{LIID*}" class="activities_box box">
			{+START,INCLUDE,ACTIVITY}{+END}
		</li>
	{+END}

	{PAGINATION}
{+END}
