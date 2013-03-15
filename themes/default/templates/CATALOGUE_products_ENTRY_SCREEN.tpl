<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/Offer"}>
	{TITLE}

	{WARNINGS}

	{ENTRY}

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
		<div{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/WebPage"}>
			{COMMENT_DETAILS}

			{+START,IF,{$CONFIG_OPTION,show_content_tagging}}{TAGS}{+END}
		</div>
	</div>

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}
</div>
