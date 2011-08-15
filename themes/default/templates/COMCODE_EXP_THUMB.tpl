<!-- Layout table needed for stretchyness (inline-block won't work due to auto-wrapping against width-suggestion needed) -->
<table summary="" class="comcode_exp_thumb variable_table" style="float: {FLOAT|}; {+START,IF,{$EQ,{FLOAT},left}}margin-right: 5px{+END}{+START,IF,{$EQ,{FLOAT},right}}margin-left: 5px{+END}">
	<tbody>
		<tr><td>
			<a title="{!VIEW} {!IMAGE} {!LINK_NEW_WINDOW}" target="_blank" class="link_exempt" href="{URL_FULL*}" onclick="window.open('{URL_FULL*}','','status=no,resizable=yes,scrollbars=yes'); return false;"><img alt="{!THUMBNAIL}: {$STRIP_TAGS*,{TEXT}}" src="{URL_THUMB*}" /></a>
			<p>{TEXT*}</p>
		</td></tr>
	</tbody>
</table>

