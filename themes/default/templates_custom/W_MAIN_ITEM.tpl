<tr>
	<td>
		{+START,IF_NON_EMPTY,{PICTURE_URL}}<a title="{+END}{NAME*}{+START,IF_NON_EMPTY,{PICTURE_URL}}: {!LINK_NEW_WINDOW}" target="_blank" href="{PICTURE_URL*}">{+END}{NAME*}{+START,IF_NON_EMPTY,{PICTURE_URL}}</a>{+END}{AUX*} [{COUNT*}]
	</td>
	{+START,IF_PASSED,COST}
	<td>
		{!W_COST_POINTS,{COST*}}
	</td>
	{+END}
	<td>
		<form onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{DESCRIPTION*;~}','auto',null,null,null,true);" class="inline" action="{+START,IF_PASSED,COST}{$PAGE_LINK*,_SELF:_SELF:type=buy:item={NAME}:user={USER}}{+END}{+START,IF_NON_PASSED,COST}{$PAGE_LINK*,_SELF:_SELF:type=take:item={NAME}:user={USER}}{+END}" method="post"><input class="buttonhyperlink" type="submit" value="{ACTION*}" /></form>

		{+START,IF,{EDIT_ACCESS}}(<a title="{!EDIT}: {NAME*}" href="{$PAGE_LINK*,_SELF:_SELF:type=edititemcopy:item={NAME}:user={USER}}">{!EDIT}</a>){+END}

		{+START,IF_PASSED,SELLER}
			{!W_FROM,{SELLER*}}
		{+END}
	</td>
</tr>

