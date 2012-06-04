<tr>
	<td>
		{+START,IF_NON_EMPTY,{PICTURE_URL}}<a title="{NAME*}: {!LINK_NEW_WINDOW}" target="_blank" href="{PICTURE_URL*}">{+END}{NAME*}{+START,IF_NON_EMPTY,{PICTURE_URL}}</a>{+END}{AUX*} <span class="associated_details">({COUNT*})</span>
	</td>
	{+START,IF_PASSED,COST}
	<td>
		{!W_COST_POINTS,{COST*}}
	</td>
	{+END}
	<td>
		<form onblur="this.onmouseout(event);" onfocus="this.onmouseover(event);" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{DESCRIPTION*;~}','auto',null,null,null,true);" class="inline" action="{+START,IF_PASSED,COST}{$PAGE_LINK*,_SELF:_SELF:type=buy:item={NAME}:user={USER}}{+END}{+START,IF_NON_PASSED,COST}{$PAGE_LINK*,_SELF:_SELF:type=take:item={NAME}:user={USER}}{+END}" method="post"><input class="button_hyperlink" type="submit" value="{ACTION*}" /></form>

		{+START,IF,{EDIT_ACCESS}}<a class="associated_link suggested_link" title="{!EDIT}: {NAME*}" href="{$PAGE_LINK*,_SELF:_SELF:type=edititemcopy:item={NAME}:user={USER}}">{!EDIT}</a>{+END}

		{+START,IF_PASSED,SELLER}
			{!W_FROM,{SELLER*}}
		{+END}
	</td>
</tr>

