{+START,SET,TOOLTIP}
	<div class="gallery_tooltip">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h3>
				{$TRUNCATE_LEFT,{TITLE},100,0,0}
			</h3>
		{+END}

		<table summary="{!MAP_TABLE}" class="results_table">
			{+START,IF,{$NOT,{$MOBILE}}}
				<colgroup>
					<col class="gallery_entry_field_name_column" />
					<col class="gallery_entry_field_value_column" />
				</colgroup>
			{+END}

			<tbody>
				<tr>
					<th class="de_th meta_data_title">{!ADDED}</th>
					<td>{$DATE_AND_TIME*,1,0,0,{ADD_DATE_RAW}}</td>
				</tr>

				<tr>
					<th class="de_th meta_data_title">{!BY}</th>
					<td><a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a></td>
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
			</tbody>
		</table>
	</div>
{+END}

<div class="gallery_regular_thumb">
	<div class="img_thumb_wrap" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{$GET*;^,TOOLTIP}','auto',null,null,false,true);">
		<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
	</div>

	{+START,IF_PASSED,RATING_DETAILS}{+START,IF_NON_EMPTY,{RATING_DETAILS}}
		<div class="grating">{RATING_DETAILS}</div>
	{+END}{+END}
	<p class="gallery_regular_thumb_comments_count">
		<a href="{VIEW_URL*}">{$COMMENT_COUNT,images,{ID}}</a>
	</p>
</div>
