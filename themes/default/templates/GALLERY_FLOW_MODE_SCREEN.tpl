<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ImageGallery"}>
	{TITLE}

	{WARNING_DETAILS}

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div{$?,{$VALUE_OPTION,html5}, itemprop="descriptions"}>
			{DESCRIPTION}
		</div>
		<br />
		<br />
	{+END}

	{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,gallery,{CAT}}}
	{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}<br />{+END}

	{+START,IF_NON_EMPTY,{CHILDREN}}
		{+START,BOX,{!SUBCATEGORIES_HERE},,light}
			<ul class="category_list">
				{CHILDREN}
			</ul>
		{+END}
		<br />
	{+END}

	{BROWSE}

	{CURRENT_ENTRY}

	{+START,IF_NON_EMPTY,{CHILDREN}{CURRENT_ENTRY}{BROWSE}}
		<hr class="long_break" />
	{+END}

	{+START,IF_NON_EMPTY,{ENTRIES}}
		{+START,BOX,{!OTHER_IMAGES_IN_GALLERY},,med}
			{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

			{$SET,carousel_id,{$RAND}}

			<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
				<div class="move_left" onmousedown="carousel_move({$GET*,carousel_id},-100); return false;" onmouseover="this.className='move_left move_left_hover';" onmouseout="this.className='move_left';"></div>
				<div class="move_right" onmousedown="carousel_move({$GET*,carousel_id},+100); return false;" onmouseover="this.className='move_right move_right_hover';" onmouseout="this.className='move_right';"></div>

				<div class="main"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
				</div>
			</div>

			<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
				{ENTRIES}
			</div>

			<script type="text/javascript">// <![CDATA[
				addEventListenerAbstract(window,'load',function () {
					initialise_carousel({$GET,carousel_id});
				} );
			//]]></script>

			<p class="gallery_start_slideshow">&laquo; <a target="_blank" title="{!_SLIDESHOW}: {!LINK_NEW_WINDOW}" href="{$PAGE_LINK*,_SELF:galleries:{FIRST_ENTRY_ID*}:slideshow=1:wide_high=1}">{!_SLIDESHOW}</a> &raquo;</p>

			{SORTING}
		{+END}
	{+END}

	{+START,IF_EMPTY,{ENTRIES}{CURRENT_ENTRY}}
		<p class="nothing_here">
			{!NO_ENTRIES}
		</p>
	{+END}

	{+START,INCLUDE,NOTIFICATION_BUTTONS}
		NOTIFICATIONS_TYPE=gallery_entry
		NOTIFICATIONS_ID={CAT}
		BREAK=1
		RIGHT=1
	{+END}

	<br />

	<div class="float_surrounder lined_up_boxes">
		{+START,IF_NON_EMPTY,{MEMBER_DETAILS}}
			<div class="right">
				{+START,BOX,{_TITLE*},,med}
					{MEMBER_DETAILS}
				{+END}
			</div>

			<div class="ratings right">
				{RATING_DETAILS}
			</div>
		{+END}
	</div>

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={IMAGE_URL*}
		1_TITLE={!ADD_IMAGE}
		1_REL=add
		2_URL={VIDEO_URL*}
		2_TITLE={!ADD_VIDEO}
		2_REL=add
		3_URL={$?,{$OR,{$NOT,{$HAS_SPECIFIC_PERMISSION,may_download_gallery}},{$IS_EMPTY,{ENTRIES}}},,{$FIND_SCRIPT*,download_gallery}?cat={CAT*}{$KEEP*,0,1}}
		3_TITLE={!DOWNLOAD_GALLERY_CONTENTS}
		3_CLASS=archive_link
		4_URL={ADD_GALLERY_URL*}
		4_TITLE={!ADD_GALLERY}
		4_REL=edit
		5_ACCESSKEY=q
		5_URL={EDIT_URL*}
		5_TITLE={!EDIT_GALLERY}
		5_REL=edit
	{+END}

	<div>
		{COMMENT_DETAILS}
	</div>

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
</div>
