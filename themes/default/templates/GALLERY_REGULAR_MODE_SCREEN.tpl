<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ImageGallery"}>
	{TITLE}

	{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
			{DESCRIPTION}
		</div>
		<br />
		<br />
	{+END}

	{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,gallery,{CAT}}}
	{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}<br />{+END}

	{+START,IF_NON_EMPTY,{CHILDREN}}
		{+START,BOX,{!SUBCATEGORIES_HERE},,light}
			<ul class="category_list"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
				{CHILDREN}
			</ul>
		{+END}
		<br />
	{+END}

	{+START,IF_NON_EMPTY,{ENTRIES}}
		<div class="gallery_media_expose_wrap"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
			{ENTRIES}
		</div>
			
		{SORTING}
	{+END}

	{+START,IF_EMPTY,{CHILDREN}{ENTRIES}}
		<p class="nothing_here">
			{!NO_ENTRIES}
		</p>
	{+END}

	{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
		<div class="float_surrounder results_browser_spacing">
			{RESULTS_BROWSER}
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

	<div>
		{COMMENT_DETAILS}
	</div>

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
</div>