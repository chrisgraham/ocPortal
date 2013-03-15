<tr>
	<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{NAME*}"{+END} class="dottedborder_barrier">
		{TEXT*}
	</th>
	<td class="dottedborder_barrier">
		<div class="accessibility_hidden"><label for="i_{NAME*}">{TEXT*}</label></div>
		{+START,IF,{CHECKED}}
			<input type="checkbox" value="1" checked="checked" id="i_{NAME*}" name="{NAME*}" />
		{+END}
		{+START,IF,{$NOT,{CHECKED}}}
			<input {+START,IF_PASSED,DISABLED}disabled="disabled" {+END}type="checkbox" value="1" id="i_{NAME*}" name="{NAME*}" />
		{+END}
	</td>
	<!--{+START,IF_NON_EMPTY,{ADVANCED_URL}}
	<td class="dottedborder_barrier import_line_more">
		<a href="{ADVANCED_URL*}" title="{!ADVANCED_IMPORT}: {!DESCRIPTION_ADVANCED_IMPORT=}">{!ADVANCED_IMPORT}</a>
	</td>
	{+END}-->
</tr>
