{+START,IF_EMPTY,{$META_DATA,image}}
	{$META_DATA,image,{SCRIPT}?id={ID}{SUP_PARAMS}{$KEEP,0,1}&thumb=0&for_session={$SESSION_HASHED}&no_count=1}
{+END}

<!-- Layout table needed for stretchyness (inline-block won't work due to auto-wrapping against width-suggestion needed) -->
<table summary="" class="comcode_exp_thumb variable_table" style="float: {FLOAT|}; {+START,IF,{$EQ,{FLOAT},left}}margin-right: 5px{+END}{+START,IF,{$EQ,{FLOAT},right}}margin-left: 5px{+END}">
	<tbody>
		<tr><td>
			<a rel="lightbox" title="{!VIEW} {!IMAGE} {!LINK_NEW_WINDOW}" target="_blank" class="link_exempt" href="{URL_FULL*}"><img title="" alt="{!THUMBNAIL}: {$STRIP_TAGS*,{TEXT}}" src="{URL_THUMB*}" /></a>
			<p>{TEXT*}</p>
		</td></tr>
	</tbody>
</table>

