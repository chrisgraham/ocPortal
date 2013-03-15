<div itemscope="itemscope" itemtype="http://schema.org/ItemPage">
	{TITLE}

	{+START,IF_NON_EMPTY,{OUTMODE_URL}}
		<p class="red_alert">
			<a href="{OUTMODE_URL*}">{!OUTMODED}</a>
		</p>
	{+END}

	{WARNING_DETAILS}

	<div class="float_surrounder">
		<div class="download_meta_data">
			<div class="download_now_wrapper">
				<div class="box box___download_screen">
					{+START,IF_PASSED,LICENCE_HYPERLINK}
					<p class="download_licence">
						{!D_BEFORE_PROCEED_AGREE,{LICENCE_HYPERLINK}}
					</p>

					<div class="toggleable_tray_title">
						<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {!_I_AGREE}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
						<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{!_I_AGREE}</a>
					</div>

					<div class="toggleable_tray" style="display: {$JS_ON,none,block}" aria-expanded="false">
					{+END}
					{+START,IF_NON_PASSED,LICENCE_HYPERLINK}
					<div class="box_inner">
					{+END}
						<div class="download_now" itemprop="significantLinks">
							<p class="download_link associated_link suggested_link"><a rel="nofollow" href="{$FIND_SCRIPT*,dload}?id={ID*}{$KEEP*,0,1}{+START,IF,{$EQ,{$CONFIG_OPTION,anti_leech},1}}&amp;for_session={$SESSION_HASHED*}{+END}"><strong>{!DOWNLOAD_NOW}</strong></a></p>
							<p class="download_filesize">({FILE_SIZE*})</p>
						</div>
					</div>
				</div>
			</div>

			<div class="download_stats_wrapper">
				<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="download_stats results_table wide_table" role="contentinfo">
					{+START,IF,{$NOT,{$MOBILE}}}
						<colgroup>
							<col class="download_field_name_column" />
							<col class="download_field_value_column" />
						</colgroup>
					{+END}

					<tbody>
						<tr>
							<th class="de_th meta_data_title">{!ADDED}</th>
							<td>
								<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{DATE_RAW}}" pubdate="pubdate" itemprop="datePublished">{DATE*}</time>
							</td>
						</tr>

						<tr>
							{+START,IF_NON_EMPTY,{AUTHOR_URL}}
								<th class="de_th meta_data_title">{!BY}</th>
								<td><a rel="author" href="{AUTHOR_URL*}" title="{!AUTHOR}: {AUTHOR*}">{AUTHOR*}</a></td>
							{+END}

							{+START,IF_EMPTY,{AUTHOR_URL}}{+START,IF_NON_EMPTY,{$USERNAME,{SUBMITTER}}}
								<th class="de_th meta_data_title">{!BY}</th>
								<td>
									<a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>
									{+START,INCLUDE,MEMBER_TOOLTIP}{+END}
								</td>
							{+END}{+END}
						</tr>

						{+START,IF_NON_EMPTY,{EDIT_DATE}}
							<tr>
								<th class="de_th meta_data_title">{!EDITED}</th>
								<td>
									<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}">{EDIT_DATE*}</time>
								</td>
							</tr>
						{+END}

						{+START,IF,{$INLINE_STATS}}
							<tr>
								<th class="de_th meta_data_title">{!COUNT_VIEWS}</th>
								<td>{VIEWS*}</td>
							</tr>
						{+END}

						<tr>
							<th class="de_th meta_data_title">{!COUNT_DOWNLOADS}</th>
							<td>
								<meta itemprop="interactionCount" content="UserDownloads:{$PREG_REPLACE*,[^\d],,{NUM_DOWNLOADS}}"/>
								{NUM_DOWNLOADS*}
							</td>
						</tr>
					</tbody>
				</table></div>
			</div>

			{+START,IF_NON_EMPTY,{RATING_DETAILS}}
				<div class="ratings right">
					{RATING_DETAILS}
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{TRACKBACK_DETAILS}}
				<div class="trackbacks right">
					{TRACKBACK_DETAILS}
				</div>
			{+END}
		</div>

		<div class="download_description" itemprop="description">
			{+START,IF_NON_EMPTY,{DESCRIPTION}}
				{$PARAGRAPH,{DESCRIPTION}}
			{+END}

			{+START,IF_NON_EMPTY,{ADDITIONAL_DETAILS}}
				<h2>{!ADDITIONAL_INFO}</h2>

				{ADDITIONAL_DETAILS}
			{+END}

			{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,download,{ID}}}
			{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}
		</div>
	</div>

	{+START,IF_NON_EMPTY,{IMAGES_DETAILS}}
		<div class="box box___download_screen"><div class="box_inner">
			<h2>{!IMAGES}</h2>

			{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}

			{$SET,carousel_id,{$RAND}}

			<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
				<div class="move_left" onmousedown="carousel_move({$GET*,carousel_id},-100); return false;"></div>
				<div class="move_right" onmousedown="carousel_move({$GET*,carousel_id},+100); return false;"></div>

				<div class="main">
				</div>
			</div>

			<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
				{IMAGES_DETAILS}
			</div>

			<script type="text/javascript">// <![CDATA[
				add_event_listener_abstract(window,'load',function () {
					initialise_carousel({$GET,carousel_id});
				} );
			//]]></script>

			{$,<p class="download_start_slideshow"><span class="associated_link"><a target="_blank" title="\{!galleries:_SLIDESHOW\}: \{!LINK_NEW_WINDOW\}" href="\{$PAGE_LINK*,_SEARCH:galleries:image:\{$GET*,FIRST_IMAGE_ID\}:slideshow=1:wide_high=1\}">\{!galleries:_SLIDESHOW\}</a></span></p>}
		</div></div>
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={NAME}}{+END}

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={EDIT_URL*}
		1_TITLE={!EDIT}
		1_ACCESSKEY=q
		1_REL=edit
		{+START,IF,{$ADDON_INSTALLED,galleries}}
		2_URL={ADD_IMG_URL*}
		2_TITLE={!ADD_IMAGE}
		{+END}
	{+END}

	<div class="content_screen_comments">
		{COMMENT_DETAILS}
	</div>
</div>
