{+START,SET,TOOLTIP}
	<div class="gallery_tooltip">
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
			<div class="gallery_tooltip_description">
				{$TRUNCATE_LEFT,{DESCRIPTION},100,0,1}
			</div>
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
					<td><a href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a></td>
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

				{$SET,rating,{$RATING,images,{ID},1}}
				{+START,IF_NON_EMPTY,{$TRIM,{$GET,rating}}}
					<tr>
						<th class="de_th meta_data_title">{!RATING}</th>
						<td>{$GET,rating}</td>
					</tr>
				{+END}
			</tbody>
		</table>
	</div>
{+END}

{+START,IF,{$EQ,{_GUID},043ac7d15ce02715ac02309f6e8340ff}}
	<a onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$GET^;*,TOOLTIP}','auto',null,null,false,true);" href="{VIEW_URL*}"><img height="140" src="{$THUMBNAIL*,{THUMB_URL},140x140,website_specific,,,height}" /></a>
{+END}

{+START,IF,{$NEQ,{_GUID},043ac7d15ce02715ac02309f6e8340ff}}
	<div class="gallery_regular_thumb" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{$GET^;*,TOOLTIP}','auto',null,null,false,true);">
		<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
		<div class="gmeta">
			{+START,IF_PASSED,RATING_DETAILS}{+START,IF_NON_EMPTY,{RATING_DETAILS}}
				<span class="grating">{RATING_DETAILS}</span>
			{+END}{+END}
			<a href="{VIEW_URL*}">{$COMMENT_COUNT,images,{ID}}</a>
		</div>
	</div>
{+END}
