{+START,SET,fractional_edit}
	{+START,IF,{$NOT,{$MOBILE}}}
		{+START,IF,{$NOT,{EXPLICIT_EDITING_LINKS}}}
			<span class="fractional_edit_nonover" onmouseout="window.status=window.old_status; this.className='fractional_edit_nonover';" onmouseover="window.old_status=window.status; window.status='{$SPECIAL_CLICK_TO_EDIT;}'; this.className='fractional_edit';" onkeypress="if (enter_pressed(event,'e')) return this.onclick.call(this,event);" onclick="if (typeof window.fractional_edit!='undefined') return fractional_edit(event,this,'{URL*;}','{EDIT_TEXT*;}','{EDIT_PARAM_NAME*;}');">{VALUE}</span>
		{+END}

		{+START,IF,{EXPLICIT_EDITING_LINKS}}
			<span>{VALUE}</span>

			<a href="#" onclick="fractional_edit(event,this.previousSibling.previousSibling,'{URL*;}','{EDIT_TEXT*;}','{EDIT_PARAM_NAME*;}'); return false;" class="associated_link">{!EDIT}</a>
		{+END}
	{+END}
	{+START,IF,{$MOBILE}}
		{VALUE}
	{+END}
{+END}
{$GET,fractional_edit}