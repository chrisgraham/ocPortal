<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ItemPage"}>
	{TITLE}

	{WARNINGS}

	<!--<p class="standard_meta_block"{$?,{$VALUE_OPTION,html5}, role="contentinfo"}>
		{+START,IF,{$VALUE_OPTION,html5}}{!ADDED,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{ADD_DATE_RAW}}" pubdate="pubdate">{ADD_DATE*}</time>}{+END}{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}{!ADDED,{ADD_DATE*}}{+END}{+START,IF,{$INLINE_STATS}}. {!VIEWS,{VIEWS*}}{+END}
	</p>-->

	{ENTRY}
	<br />

	{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={EDIT_URL*}
		1_TITLE={!_EDIT_LINK}
		1_ACCESSKEY=q
		1_REL=edit
	{+END}

	<br />

	<div>
		<div class="float_surrounder">
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
		<div>
			{COMMENT_DETAILS}
		</div>
	</div>

	{+START,IF_NON_EMPTY,{EDIT_DATE_RAW}}
		<div class="edited edited_block"{$?,{$VALUE_OPTION,html5}, role="note"}>
			<img alt="" title="" src="{$IMG*,edited}" />
			{!EDITED}
			{+START,IF,{$VALUE_OPTION,html5}}
				<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{EDIT_DATE_RAW}}">{$DATE*,{EDIT_DATE_RAW}}</time>
			{+END}
			{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
				{$DATE*,{EDIT_DATE_RAW}}
			{+END}
		</div>
	{+END}

	{$,Uncomment and modify to create a reply link <a href="\{$PAGE_LINK*,site:contactmember:misc:{SUBMITTER}:subject=Response to listing, {FIELD_1}:message=\}">Respond</a>}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
</div>
