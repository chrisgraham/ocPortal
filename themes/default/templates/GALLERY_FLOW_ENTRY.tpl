<div class="flowmode_thumb">
	<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>

	{+START,IF,{$SUPPORTS_FRACTIONAL_EDITABLE,_SEARCH:cms_galleries:type={$?,{$EQ,{TYPE},video},__ev,__ed}:id={ID},{$HAS_EDIT_PERMISSION,mid,{SUBMITTER},{$MEMBER},cms_galleries,galleries,{CAT}}}}
		<p>
			{+START,FRACTIONAL_EDITABLE,{_TITLE},title,_SEARCH:cms_galleries:type={$?,{$EQ,{TYPE},video},__ev,__ed}:id={ID},1,1,{$HAS_EDIT_PERMISSION,mid,{SUBMITTER},{$MEMBER},cms_galleries,galleries,{CAT}}}{_TITLE*}{+END}
		</p>
	{+END}
</div>
