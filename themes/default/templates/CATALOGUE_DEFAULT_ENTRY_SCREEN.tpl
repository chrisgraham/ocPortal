<div itemscope="itemscope" itemtype="http://schema.org/ItemPage" class="catalogue_entry_screen">
	{TITLE}

	<div class="meta_details" role="contentinfo">
		<ul class="meta_details_list">
			<li>
				{!BY_SIMPLE,<a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}" itemprop="author">{$USERNAME*,{SUBMITTER}}}</a>
				{+START,INCLUDE,MEMBER_TOOLTIP}{+END}
			</li>
			<li>{!ADDED_SIMPLE,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" pubdate="pubdate">{ADD_DATE*}</time>}</li>
			{+START,IF,{$INLINE_STATS}}<li>{!VIEWS_SIMPLE,{VIEWS*}}</li>{+END}
		</ul>
	</div>

	{WARNINGS}

	{ENTRY}

	<div class="float_surrounder lined_up_boxes">
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

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={EDIT_URL*}
		1_TITLE={!_EDIT_LINK}
		1_ACCESSKEY=q
		1_REL=edit
	{+END}

	<div class="content_screen_comments">
		{COMMENT_DETAILS}
	</div>

	{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
		<div class="edited" role="note">
			<img alt="" src="{$IMG*,edited}" />
			{!EDITED}
			<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}">{$DATE*,,,,{EDIT_DATE_RAW}}</time>
		</div>
	{+END}

	{$,Uncomment and modify to create a reply link <a href="\{$PAGE_LINK*,site:contactmember:misc:\{SUBMITTER\}:subject=Response to listing, \{FIELD_1\}:message=\}">Respond</a>}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
</div>
