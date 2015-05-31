<div itemscope="itemscope" itemtype="http://schema.org/ImageObject">
	<div class="media_box">
		<img src="{THUMB_URL*}" alt="{!IMAGE}" itemprop="contentURL" />
	</div>

	{+START,IF_PASSED,DESCRIPTION}
		<div itemprop="caption">
			{$PARAGRAPH,{DESCRIPTION}}
		</div>
	{+END}

	<div class="float_surrounder lined_up_boxes">
		<div class="gallery_entry_details right">
			<section class="box box___gallery_flowmode_image"><div class="box_inner">
				<h3>{!DETAILS}</h3>

				<table summary="{!MAP_TABLE}" class="results_table">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col class="gallery_entry_field_name_column" />
							<col class="gallery_entry_field_value_column" />
						</colgroup>
					{+END}

					<tbody>
						{+START,IF_NON_EMPTY,{_TITLE}}
							<tr>
								<th class="de_th meta_data_title">{!TITLE}</th>
								<td>
									{_TITLE*}
								</td>
							</tr>
						{+END}

						<tr>
							<th class="de_th meta_data_title">{!ADDED}</th>
							<td>
								<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" itemprop="datePublished">{$DATE_AND_TIME*,1,0,0,{ADD_DATE_RAW}}</time>
							</td>
						</tr>

						<tr>
							<th class="de_th meta_data_title">{!BY}</th>
							<td>
								<a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}" itemprop="author">{$USERNAME*,{SUBMITTER}}</a>

								{+START,INCLUDE,MEMBER_TOOLTIP}{+END}
							</td>
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

				<ul class="horizontal_links associated_links_block_group">
					{+START,IF,{$ADDON_INSTALLED,recommend}}
						<li><img class="vertical_alignment" src="{$IMG*,filetypes/email_link}" alt="" /> <a href="{$PAGE_LINK*,:recommend:misc:subject={!ECARD_FOR_YOU_SUBJECT}:page_title={!SEND_AS_ECARD}:s_message={!ECARD_FOR_YOU,{$SELF_URL},{FULL_URL*},{$SITE_NAME}}}">{!SEND_AS_ECARD}</a></li>
					{+END}
					<li><a href="{VIEW_URL*}">{$COMMENT_COUNT,images,{ID}}</a></li>
				</ul>

				{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
				{+START,INCLUDE,STAFF_ACTIONS}
					1_URL={EDIT_URL*}
					1_TITLE={!EDIT_IMAGE}
				{+END}
			</div></section>
		</div>

		<div class="ratings right">
			{RATING_DETAILS}
		</div>
	</div>
</div>
