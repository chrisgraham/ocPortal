<tr>
	{+START,IF,{$NOT,{$MOBILE}}}
		{+START,IF,{$CONFIG_OPTION,is_on_topic_emoticons}}
			<td class="ocf_forum_topic_row_emoticon ocf_column1">
				{+START,IF_EMPTY,{EMOTICON}}
					<img class="vertical_alignment" alt="" src="{$IMG*,ocf_emoticons/none}" />
				{+END}
				{EMOTICON}
			</td>
		{+END}
	{+END}

	<td class="ocf_forum_topic_row_preview ocf_column2">
		<a class="ocf_forum_topic_row_preview_button" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{$TRUNCATE_LEFT*~;^,{POST},1000,0,1}','30%',null,null,null,true);" href="{URL*}">{!PREVIEW} <span style="display: none">{ID*}</span></a>

		<div>
			{TOPIC_ROW_LINKS}

			{+START,IF_NON_EMPTY,{TOPIC_ROW_MODIFIERS}}{TOPIC_ROW_MODIFIERS}{+END}

			<a href="{URL*}" title="{$ALTERNATOR_TRUNCATED,{TITLE},60,{!TOPIC_STARTED_DATE_TIME,{HOVER*;~}},,1}">{+START,FRACTIONAL_EDITABLE,{TITLE},title,_SEARCH:topics:type=_edit_topic:id={ID}}{+START,IF,{UNREAD}}<span class="ocf_unread_topic_title">{+END}{$TRUNCATE_LEFT,{TITLE},46,1}{+START,IF,{UNREAD}}</span>{+END}{+END}</a>

			{PAGES}

			{+START,IF_PASSED,BREADCRUMBS}{+START,IF_NON_EMPTY,{BREADCRUMBS}}
				<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p class="associated_details">{BREADCRUMBS}</p></nav>
			{+END}{+END}
		</div>
		{+START,IF_NON_EMPTY,{DESCRIPTION}}{+START,IF,{$NEQ,{TITLE},{DESCRIPTION}}}
			<div class="ocf_forum_topic_description">{DESCRIPTION*}</div>
		{+END}{+END}

		{+START,IF,{$MOBILE}}
			<ul class="horizontal_meta_details associated_details" role="contentinfo">
				<li><span class="field_name">{!COUNT_POSTS}:</span> {NUM_POSTS*}</li>
				<li><span class="field_name">{!COUNT_VIEWS}:</span> {NUM_VIEWS*}</li>
			</ul>
			</p>
		{+END}
	</td>

	<td class="ocf_forum_topic_row_poster ocf_column3">
		{POSTER}
	</td>

	{+START,IF,{$NOT,{$MOBILE}}}
		<td class="ocf_forum_topic_row_num_posts ocf_column4">
			{NUM_POSTS*}
		</td>
		<td class="ocf_forum_topic_row_num_views ocf_column5">
			{NUM_VIEWS*}
		</td>
	{+END}

	<td class="ocf_forum_topic_row_last_post ocf_column6">
		{LAST_POST}
	</td>

	{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$NOT,{$_GET,overlay}}}
		{MARKER}
	{+END}{+END}
</tr>

