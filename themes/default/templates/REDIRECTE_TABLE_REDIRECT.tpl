<tr>
	<td>
		<div class="accessibility_hidden"><label for="from_zone_{I*}">{!REDIRECT_FROM_ZONE}</label></div>
		{+START,IF_NON_EMPTY,{FROM_ZONES}}
			<select class="quite_wide_field" id="from_zone_{I*}" name="from_zone_{I*}">{FROM_ZONES}</select>
		{+END}
		{+START,IF_EMPTY,{FROM_ZONES}}
			<input maxlength="80" size="10" class="quite_wide_field" id="from_zone_{I*}" name="from_zone_{I*}" value="{FROM_ZONE*}" type="text" />
		{+END}
		:
	</td>
	<td>
		<div class="accessibility_hidden"><label for="from_page_{I*}">{!REDIRECT_FROM_PAGE}</label></div>
		<input maxlength="80" class="quite_wide_field" type="text" id="from_page_{I*}" name="from_page_{I*}" value="{FROM_PAGE*}" />
		&rarr;
	</td>
	<td>
		<div class="accessibility_hidden"><label for="to_zone_{I*}">{!REDIRECT_TO_ZONE}</label></div>
		{+START,IF_NON_EMPTY,{TO_ZONES}}
			<select class="quite_wide_field" id="to_zone_{I*}" name="to_zone_{I*}">{TO_ZONES}</select>
		{+END}
		{+START,IF_EMPTY,{TO_ZONES}}
			<input maxlength="80" size="10" class="quite_wide_field" id="to_zone_{I*}" name="to_zone_{I*}" value="{TO_ZONE*}" type="text" />
		{+END}
		:
	</td>
	<td>
		<div class="accessibility_hidden"><label for="to_page_{I*}">{!REDIRECT_TO_PAGE}</label></div>
		<input maxlength="80" class="quite_wide_field" type="text" id="to_page_{I*}" name="to_page_{I*}" value="{TO_PAGE*}" />
	</td>
	<td>
		<div class="accessibility_hidden"><label for="is_transparent_{I*}">{!IS_TRANSPARENT_REDIRECT}</label></div>
		{+START,IF,{TICKED}}
			<input onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{!IS_TRANSPARENT_REDIRECT;}','40%');" title="{!IS_TRANSPARENT_REDIRECT}" class="input_tick" type="checkbox" id="{NAME*}" name="{NAME*}" checked="checked" value="1" />
		{+END}
		{+START,IF,{$NOT,{TICKED}}}
			<input onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{!IS_TRANSPARENT_REDIRECT;}','40%');" title="{!IS_TRANSPARENT_REDIRECT}" class="input_tick" type="checkbox" id="{NAME*}" name="{NAME*}" value="1" />
		{+END}
	</td>
	<td>
		{+START,IF,{$NEQ,{I},new}}
			<a href="#" onclick="if (window.confirm('{!ARE_YOU_SURE_DELETE;}')) this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);"><img src="{$IMG*,tableitem/delete}" alt="{!DELETE}" title="{!DELETE}" /></a>
		{+END}
	</td>
</tr>

