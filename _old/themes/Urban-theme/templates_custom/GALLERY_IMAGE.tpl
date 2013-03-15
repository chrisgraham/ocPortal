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
					<col width="85" />
					<col width="160" />
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
			</tbody>
		</table>
	</div>
{+END}
<div class="gallery_regular_thumb">
	<div class="thumb_container">
		<a href="{VIEW_URL*}"><img src="{$THUMBNAIL,{$TRIM,{FULL_URL}},147x97,galleries_thumbs,,,crop,both,,only_make_smaller}" /></a>
		<div class="gallery_thumb_img_right"></div>
		<div class="gallery_thumb_img_under"></div>
	</div>

	<div class="gallery_regular_description">{$TRUNCATE_LEFT,{DESCRIPTION},100,0,1}</div>
	<a href="{VIEW_URL*}" class="more">{!news:READ_MORE}</a>
</div>
