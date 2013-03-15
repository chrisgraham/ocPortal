<tr>
	<th{+START,IF,{$NOT,{$VALUE_OPTION,html5}}} abbr="{$STRIP_TAGS,{LANG*}}"{+END} class="dottedborder_barrier search_for_search_domain">{LANG*}</th>
	<td class="dottedborder_barrier">
		{+START,IF,{$NOT,{ADVANCED_ONLY}}}
			<div class="accessibility_hidden"><label for="search_{NAME*}">{LANG*}</label></div>
			{+START,IF,{$NOT,{CHECKED}}}
				<input type="checkbox" id="search_{NAME*}" name="search_{NAME*}" value="1" />
			{+END}
			{+START,IF,{CHECKED}}
				<input type="checkbox" id="search_{NAME*}" checked="checked" name="search_{NAME*}" value="1" />
			{+END}
		{+END}
	</td>
	<td class="dottedborder_barrier search_for_search_domain_more">
		{+START,IF_NON_EMPTY,{OPTIONS}}
			<a title="{!ADVANCED}: {$STRIP_TAGS,{LANG*}}" href="{OPTIONS*}">{!ADVANCED}</a>
		{+END}
	</td>
</tr>

