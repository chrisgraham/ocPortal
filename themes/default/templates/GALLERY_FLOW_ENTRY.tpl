<div class="flow_mode_thumb">
	{+START,IF,{$HAS_DELETE_PERMISSION,mid,{SUBMITTER},{$MEMBER},cms_galleries}}
		{+START,INCLUDE,MASS_SELECT_MARKER}
			TYPE={TYPE}
			ID={ID}
		{+END}
	{+END}

	<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
</div>
