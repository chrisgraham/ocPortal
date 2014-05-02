<div itemscope="itemscope" itemtype="http://schema.org/ImageGallery">
	{TITLE}

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div itemprop="description">
			{$PARAGRAPH,{DESCRIPTION}}
		</div>
	{+END}

	{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,gallery,{CAT}}}
	{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

	{+START,IF_NON_EMPTY,{CHILDREN}}
		<div class="box box___gallery_regular_mode_screen"><div class="box_inner">
			<h2>{!SUBCATEGORIES_HERE}</h2>

			<ul class="category_list" itemprop="significantLinks">
				{CHILDREN}
			</ul>
		</div></div>
	{+END}

	{+START,IF_NON_EMPTY,{ENTRIES}}
		<div class="gallery_grid_cell_wrap" itemprop="significantLinks">
			{ENTRIES}
		</div>

		<p>
			{SORTING}
		</p>
	{+END}

	{+START,IF_EMPTY,{CHILDREN}{ENTRIES}}
		<p class="nothing_here">
			{!NO_ENTRIES}
		</p>
	{+END}

	{+START,IF_NON_EMPTY,{PAGINATION}}
		<div class="float_surrounder pagination_spacing">
			{PAGINATION}
		</div>
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{+START,INCLUDE,NOTIFICATION_BUTTONS}
		NOTIFICATIONS_TYPE=gallery_entry
		NOTIFICATIONS_ID={CAT}
		BREAK=1
		RIGHT=1
	{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={IMAGE_URL*}
		1_TITLE={!ADD_IMAGE}
		1_REL=add
		2_URL={VIDEO_URL*}
		2_TITLE={!ADD_VIDEO}
		2_REL=add
		3_URL={$?,{$OR,{$NOT,{$HAS_PRIVILEGE,may_download_gallery}},{$IS_EMPTY,{ENTRIES}}},,{$FIND_SCRIPT*,download_gallery}?cat={CAT*}{$KEEP*,0,1}}
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

	<div class="float_surrounder lined_up_boxes">
		{+START,IF_NON_EMPTY,{MEMBER_DETAILS}}
			<div class="right">
				<div class="box box___gallery_regular_mode_screen"><div class="box_inner">
					<h2>{_TITLE*}</h2>

					{MEMBER_DETAILS}
				</div></div>
			</div>

			{+START,IF_NON_EMPTY,{ENTRIES}}
				<div class="ratings right">
					{RATING_DETAILS}
				</div>
			{+END}
		{+END}
	</div>

	{+START,IF_NON_EMPTY,{ENTRIES}}
		<div class="content_screen_comments">
			{COMMENT_DETAILS}
		</div>
	{+END}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
</div>
