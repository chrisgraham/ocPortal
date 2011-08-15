{$SET,FIRST_IMAGE_ID,{ID}}
<span class="block">
	<a href="{VIEW_URL*}">{$TRIM,{THUMB}}</a>
</span>
{+START,IF_NON_EMPTY,{COMMENT}}
	<span class="block associated_caption">
		{COMMENT}
	</span>
{+END}
{+START,IF_NON_EMPTY,{EDIT_URL}}
	<span class="block associated_link_to_small">
		[ <a href="{EDIT_URL*}" title="{!EDIT_IMAGE}, #{ID*}">{!_EDIT_LINK}</a> ]
	</span>
{+END}
