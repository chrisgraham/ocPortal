<tr>
	{+START,IF,{$NOT,{$MOBILE}}}
		{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
			<td class="ocf_forum_topic_row_emoticon ocf_row1">
				{+START,IF_EMPTY,{EMOTICON}}
					<img class="inline_image" alt="" src="{$IMG*,ocf_emoticons/none}" />
				{+END}
				{EMOTICON}
			</td>
		{+END}
	{+END}
	<td class="ocf_forum_topic_row_preview ocf_row2">
		<a class="ocf_forum_topic_row_preview_button" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$TRUNCATE_LEFT^;~*,{POST},1000,0,1}','30%',null,null,null,true);" href="{URL*}">{!PREVIEW} <span style="display: none">{ID*}</span></a>

		<div>
			{TOPIC_ROW_LINKS}{+START,IF_NON_EMPTY,{TOPIC_ROW_MODIFIERS}}{TOPIC_ROW_MODIFIERS}&nbsp;{+END}
			<a href="{URL*}" title="{$ALTERNATOR_TRUNCATED,{TITLE},60,{!TOPIC_STARTED_DATE_TIME,{HOVER*;~}},,1}">{+START,FRACTIONAL_EDITABLE,{TITLE},title,_SEARCH:topics:type=_edit_topic:id={ID}}{+START,IF,{UNREAD}}<span class="ocf_unread_topic_title">{+END}{$TRUNCATE_LEFT,{TITLE},60}{+START,IF,{UNREAD}}</span>{+END}{+END}</a>

			{PAGES}
			{+START,IF_PASSED,BREADCRUMBS}{+START,IF_NON_EMPTY,{BREADCRUMBS}}<br /><span class="associated_details">{BREADCRUMBS}</span>{+END}{+END}
		</div>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}{+START,IF,{$NEQ,{TITLE},{DESCRIPTION}}}
			<div class="ocf_forum_topic_description">{DESCRIPTION*}</div>
		{+END}{+END}

		{+START,IF,{$MOBILE}}
			<p class="associated_details">
				{!COUNT_POSTS}: {NUM_POSTS*}
				&middot;
				{!COUNT_VIEWS}: {NUM_VIEWS*}
			</p>
		{+END}
	</td>
	<td class="ocf_forum_topic_row_poster ocf_row2p5">
		{POSTER}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		<td class="ocf_forum_topic_row_num_posts ocf_row3">
			{NUM_POSTS*}
		</td>
		<td class="ocf_forum_topic_row_num_views ocf_row4">
			{NUM_VIEWS*}
		</td>
	{+END}
	<td class="ocf_forum_topic_row_last_post ocf_row5">
		{LAST_POST}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		{MARKER}
	{+END}
</tr>

