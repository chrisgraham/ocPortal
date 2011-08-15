{$SET,FIRST_ENTRY_ID,type=image:id={ID}}

<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ImageObject"}>
	<div class="gallery_media_full_expose">
		<img src="{THUMB_URL*}" alt="{!IMAGE}" title=""{$?,{$VALUE_OPTION,html5}, itemprop="contentURL"} />
	</div>

	<br />

	<div class="float_surrounder lined_up_boxes">
		<div class="gallery_entry_details right">
			{+START,BOX,{!DETAILS},,med}
				<table summary="{!MAP_TABLE}" class="solidborder">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col style="width: 100px" />
							<col style="width: 180px" />
						</colgroup>
					{+END}

					<tbody>
						<tr>
							<th class="de_th meta_data_title">{!_ADDED}</th>
							<td>
								{+START,IF,{$VALUE_OPTION,html5}}
									<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" pubdate="pubdate" itemprop="datePublished">{$DATE_AND_TIME*,1,0,0,{ADD_DATE_RAW}}</time>
								{+END}
								{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
									{$DATE_AND_TIME*,1,0,0,{ADD_DATE_RAW}}
								{+END}
							</td>
						</tr>

						<tr>
							<th class="de_th meta_data_title">{!BY}</th>
							<td><a href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}"{$?,{$VALUE_OPTION,html5}, itemprop="author"}>{$USERNAME*,{SUBMITTER}}</a></td>
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

				{+START,IF,{$ADDON_INSTALLED,recommend}}
					<p class="ecard_link"><img class="inline_image" src="{$IMG*,filetypes/email_link}" alt="" /> <a href="{$PAGE_LINK*,:recommend:misc:subject={!ECARD_FOR_YOU_SUBJECT}:page_title={!SEND_AS_ECARD}:s_message={!ECARD_FOR_YOU,{$SELF_URL},{FULL_URL*},{$SITE_NAME}}}">{!SEND_AS_ECARD}</a></p>
				{+END}
				<p class="view_alone_link"><a href="{VIEW_URL*}">{$COMMENT_COUNT,images,{ID}}</a></p>

				{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
				{+START,INCLUDE,STAFF_ACTIONS}
					1_URL={EDIT_URL*}
					1_TITLE={!EDIT_IMAGE}
				{+END}
			{+END}
		</div>

		<div class="ratings right">
			{RATING_DETAILS}
		</div>

		{+START,IF_PASSED,DESCRIPTION}
			<div{$?,{$VALUE_OPTION,html5}, itemprop="caption"}>
				{DESCRIPTION}
			</div>
		{+END}
	</div>
</div>
