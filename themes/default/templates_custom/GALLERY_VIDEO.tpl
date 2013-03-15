{+START,SET,TOOLTIP}
	<div class="gallery_tooltip">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h3 class="gallery_tooltip_description">
				{$TRUNCATE_LEFT,{TITLE},100,0,0}
			</h3>
		{+END}

		<table summary="{!MAP_TABLE}" class="solidborder">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col style="width: 85px" />
					<col style="width: 160px" />
				</colgroup>
			{+END}

			<tbody>
				<tr>
					<th class="de_th meta_data_title">{!_ADDED}</th>
					<td>{$DATE_AND_TIME*,1,0,0,{ADD_DATE_RAW}}</td>
				</tr>

				<tr>
					<th class="de_th meta_data_title">{!BY}</th>
					<td><a rel="author" href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a></td>
				</tr>

				{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
					<tr>
						<th class="de_th meta_data_title">{!EDITED}</th>
						<td>{$DATE_AND_TIME*,1,0,0,{EDIT_DATE_RAW}}</td>
					</tr>
				{+END}

				{+START,IF,{$INLINE_STATS}}
					<tr>
						<th class="de_th meta_data_title">{!COUNT_VIEWS}</th>
						<td>{VIEWS*}</td>
					</tr>
				{+END}

				{$SET,rating,{$RATING,videos,{ID},1}}
				{+START,IF_NON_EMPTY,{$TRIM,{$GET,rating}}}
					<tr>
						<th class="de_th meta_data_title">{!RATING}</th>
						<td>{$GET,rating}</td>
					</tr>
				{+END}

				{$PREG_REPLACE,</(table|div)>,,{$PREG_REPLACE,<(table|div)[^>]*>,,{VIDEO_DETAILS}}}
			</tbody>
		</table>
	</div>
{+END}

{+START,IF,{$EQ,{_GUID},66b7fb4d3b61ef79d6803c170d102cbf}}
	<a onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$GET^;*,TOOLTIP}','auto',null,null,false,true);" href="{VIEW_URL*}"><img src="{$THUMBNAIL*,{THUMB_URL},140x140,website_specific,vid{ID},,height}" /></a>
{+END}

{+START,IF,{$NEQ,{_GUID},66b7fb4d3b61ef79d6803c170d102cbf}}
	<div class="gallery_regular_thumb" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$GET^;*,TOOLTIP}','auto',null,null,false,true);">
		<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
		<div class="gmeta">
			{+START,IF_PASSED,RATING_DETAILS}{+START,IF_NON_EMPTY,{RATING_DETAILS}}
				<span class="grating">{RATING_DETAILS}</span>
			{+END}{+END}
			<a href="{VIEW_URL*}">{$COMMENT_COUNT,videos,{ID}}</a>
		</div>
	</div>
{+END}
