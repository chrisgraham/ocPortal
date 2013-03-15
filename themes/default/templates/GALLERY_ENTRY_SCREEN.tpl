<div class="gallery_entry_screen" id="gallery_entry_screen" itemscope="itemscope" itemtype="http://schema.org/{+START,IF_PASSED,VIDEO}Video{+END}{+START,IF_NON_PASSED,VIDEO}Image{+END}Object">
	{TITLE}

	{+START,IF,{$NOT,{SLIDESHOW}}}
		{WARNING_DETAILS}
	{+END}

	{NAV}

	<div class="media_box">
		{+START,IF_NON_PASSED,VIDEO}
			<img class="scale_down" alt="{!IMAGE}" src="{URL*}" itemprop="contentURL" />
		{+END}
		{+START,IF_PASSED,VIDEO}
			{VIDEO}

			<!-- <p><a href="{URL*}">{!TO_DOWNLOAD_VIDEO}</a></p> -->
		{+END}
	</div>

	{+START,IF,{$NOT,{SLIDESHOW}}}
		<div class="float_surrounder lined_up_boxes">
			<div class="gallery_entry_details right">
				<div class="box box___gallery_entry_screen"><div class="box_inner" role="contentinfo">
					<h2>{!DETAILS}</h2>

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
								<td>
									<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" pubdate="pubdate" itemprop="datePublished">{ADD_DATE*}</time>
								</td>
							</tr>

							<tr>
								<th class="de_th meta_data_title">{!BY}</th>
								<td>
									<a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}" itemprop="author">{$USERNAME*,{SUBMITTER}}</a>

									{+START,INCLUDE,MEMBER_TOOLTIP}{+END}
								</td>
							</tr>

							{+START,IF_NON_EMPTY,{EDIT_DATE}}
								<tr>
									<th class="de_th meta_data_title">{!EDITED}</th>
									<td>{EDIT_DATE*}</td>
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

					{+START,IF,{$ADDON_INSTALLED,recommend}}{+START,IF,{$NOT,{$VALUE_OPTION,disable_ecards}}}
						{+START,IF_NON_PASSED,VIDEO}
							<p class="associated_link vertical_alignment"><img src="{$IMG*,filetypes/email_link}" alt="" /> <a href="{$PAGE_LINK*,:recommend:misc:subject={!ECARD_FOR_YOU_SUBJECT}:page_title={!SEND_AS_ECARD}:s_message={!ECARD_FOR_YOU,{$SELF_URL},{URL*},{$SITE_NAME}}}">{!SEND_AS_ECARD}</a></p>
						{+END}
					{+END}{+END}
				</div></div>
			</div>

			{+START,IF_NON_EMPTY,{MEMBER_DETAILS}}{+START,IF_PASSED,MEMBER_ID}
				<div class="right">
					<div class="box box___gallery_entry_screen"><div class="box_inner">
						<h2>{GALLERY_TITLE*}</h2>

						{MEMBER_DETAILS}
					</div></div>
				</div>
			{+END}{+END}

			{+START,IF_NON_EMPTY,{TRACKBACK_DETAILS}}
				<div class="trackbacks right">
					{TRACKBACK_DETAILS}
				</div>
			{+END}
			{+START,IF_NON_EMPTY,{RATING_DETAILS}}
				<div class="ratings right">
					{RATING_DETAILS}
				</div>
			{+END}
		</div>

		{+START,IF_NON_PASSED,VIDEO}
			{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,image,{ID}}}
		{+END}
		{+START,IF_PASSED,VIDEO}
			{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,video,{ID}}}
		{+END}
		{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

		{+START,IF_NON_EMPTY,{COMMENTS}}
			<div itemprop="caption">
				{COMMENTS}
			</div>
		{+END}

		{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

		{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
		{+START,INCLUDE,STAFF_ACTIONS}
			1_URL={EDIT_URL*}
			1_TITLE={!EDIT}
			1_REL=edit
		{+END}

		<div class="content_screen_comments">
			{COMMENT_DETAILS}
		</div>
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
<!--DO_NOT_REMOVE_THIS_COMMENT--></div>
