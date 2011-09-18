<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ItemPage"}>
	{TITLE}

	{+START,IF_NON_EMPTY,{OUTMODE_URL}}
		{+START,BOX}
			<p class="download_outmoded">
				<a href="{OUTMODE_URL*}">{!OUTMODED}</a>
			</p>
		{+END}
		<br />
	{+END}

	{WARNING_DETAILS}

	<div class="float_surrounder">
		<div class="download_meta_data">
			<div class="standardbox_spaced">
				<div class="download_now_wrapper">
					{+START,BOX,,,med}
						{+START,IF_PASSED,LICENCE_HYPERLINK}
						<p class="download_licence">
							{!D_BEFORE_PROCEED_AGREE,{LICENCE_HYPERLINK}}
						</p>
						<a class="hide_button" href="#" onclick="hideTag(this.parentNode); return false;"><img alt="{!EXPAND}: {!_I_AGREE}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>

						<a class="hide_button non_link" href="#" onclick="hideTag(this.parentNode); return false;">{!_I_AGREE}</a>
						<div class="hide_tag hide_button_spacing" style="display: {$JS_ON,none,block}">
						{+END}
						<div class="download_now"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
							<p class="download_link">[ <a href="{$FIND_SCRIPT*,dload}?id={ID*}{$KEEP*,0,1}&amp;for_session={$SESSION_HASHED}"><strong>{!DOWNLOAD_NOW}</strong></a> ]</p>
							<p class="download_filesize">({FILE_SIZE*})</p>
						</div>
						{+START,IF_PASSED,LICENCE_HYPERLINK}
						</div>
						{+END}
					{+END}
				</div>

				<div id="download_stats_wrapper">
					<div class="wide_table_wrap"><table id="download_stats" summary="{!MAP_TABLE}" class="solidborder wide_table">
						{+START,IF,{$NOT,{$MOBILE}}}
							<colgroup>
								<col style="width: 45%" />
								<col style="width: 55%" />
							</colgroup>
						{+END}

						<tbody>
							<tr>
								<th class="de_th meta_data_title">{!_ADDED}</th>
								<td>
									{+START,IF,{$VALUE_OPTION,html5}}
										<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{DATE_RAW}}" pubdate="pubdate" itemprop="datePublished">{DATE*}</time>
									{+END}
									{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
										{DATE*}
									{+END}
								</td>
							</tr>

							<tr>
								{+START,IF_NON_EMPTY,{AUTHOR_URL}}
									<th class="de_th meta_data_title">{!BY}</th>
									<td><a rel="author" href="{AUTHOR_URL*}" title="{!AUTHOR}: {AUTHOR*}">{AUTHOR*}</a></td>
								{+END}

								{+START,IF_EMPTY,{AUTHOR_URL}}{+START,IF_NON_EMPTY,{$USERNAME,{SUBMITTER}}}
									<th class="de_th meta_data_title">{!BY}</th>
									<td><a href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a></td>
								{+END}{+END}
							</tr>

							{+START,IF_NON_EMPTY,{EDIT_DATE}}
								<tr>
									<th class="de_th meta_data_title">{!EDITED}</th>
									<td>
										{+START,IF,{$VALUE_OPTION,html5}}
											<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}">{EDIT_DATE*}</time>
										{+END}
										{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
											{EDIT_DATE*}
										{+END}
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
									{+START,IF,{$VALUE_OPTION,html5}}
										<meta itemprop="interactionCount" content="UserDownloads:{$PREG_REPLACE*,[^\d],,{NUM_DOWNLOADS}}"/>
									{+END}
									{NUM_DOWNLOADS*}
								</td>
							</tr>
						</tbody>
					</table></div>
				</div>

				{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={NAME}}{+END}

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
		</div>
	
		<div class="download_description"{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{+START,IF_NON_EMPTY,{DESCRIPTION}}
				{DESCRIPTION}
			{+END}
		
			{+START,IF_NON_EMPTY,{ADDITIONAL_DETAILS}}
				<h2>{!ADDITIONAL_INFO}</h2>
	
				{ADDITIONAL_DETAILS}
			{+END}

			{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,download,{ID}}}
			{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}<br /><br />{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}
		</div>
	</div>

	{+START,IF_NON_EMPTY,{IMAGES_DETAILS}}
		<br />
		{+START,BOX,{!IMAGES},,med}
			{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

			{$SET,carousel_id,{$RAND}}

			<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
				<div class="move_left" onmousedown="carousel_move({$GET*,carousel_id},-100); return false;" onmouseover="this.className='move_left move_left_hover';" onmouseout="this.className='move_left';"></div>
				<div class="move_right" onmousedown="carousel_move({$GET*,carousel_id},+100); return false;" onmouseover="this.className='move_right move_right_hover';" onmouseout="this.className='move_right';"></div>

				<div class="main">
				</div>
			</div>

			<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
				{IMAGES_DETAILS}
			</div>

			<script type="text/javascript">// <![CDATA[
				addEventListenerAbstract(window,'load',function () {
					initialise_carousel({$GET,carousel_id});
				} );
			//]]></script>

			<!--<p class="download_start_slideshow">&laquo; <a target="_blank" title="{!galleries:_SLIDESHOW}: {!LINK_NEW_WINDOW}" href="{$PAGE_LINK*,_SEARCH:galleries:image:{$GET*,FIRST_IMAGE_ID}:slideshow=1:wide_high=1}">{!galleries:_SLIDESHOW}</a> &raquo;</p>-->
		{+END}
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={EDIT_URL*}
		1_TITLE={!EDIT}
		1_ACCESSKEY=q
		1_REL=edit
		2_URL={ADD_IMG_URL*}
		2_TITLE={!ADD_IMAGE}
	{+END}

	{COMMENTS_DETAILS}
</div>
