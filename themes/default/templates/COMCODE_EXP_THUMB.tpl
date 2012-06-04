{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{URL_FULL}}
{+END}

<figure class="comcode_exp_thumb autosized_table box {FLOAT|} float_separation">
	<a rel="lightbox" title="{!VIEW} {!IMAGE} {!LINK_NEW_WINDOW}" target="_blank" class="link_exempt" href="{URL_FULL*}"><img alt="{!THUMBNAIL}: {$STRIP_TAGS*,{TEXT}}" src="{URL_THUMB*}" /></a>
	<figcaption>{TEXT*}</figcaption>
</figure>
