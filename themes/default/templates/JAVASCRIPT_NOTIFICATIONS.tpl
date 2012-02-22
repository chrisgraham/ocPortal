"use strict";

function advanced_notifications_copy_under(row,num_children)
{
	var inputs_from=row.getElementsByTagName('input');

	for (var i=0;i<num_children;i++)
	{
		row=row.nextSibling;
		while (row.nodeName.toLowerCase()!='tr') row=row.nextSibling;
		var inputs_to=row.getElementsByTagName('input');
		for (var j=0;j<inputs_to.length;j++)
		{
			if (inputs_to[j].type=='checkbox')
			{
				inputs_to[j].checked=inputs_from[j].checked;
			}
		}
	}
}

function handle_notification_type_tick(ob,row,value)
{
	var elements=row.getElementsByTagName('input');
	if ((value==-1) || (value==-2))
	{
		for (var i=0;i<elements.length;i++)
		{
			if ((elements[i]!=ob) && (elements[i].type=='checkbox'))
			{
				elements[i].checked=false;
			}
		}
	} else
	{
		elements[0].checked=false;
		elements[1].checked=false;
	}
}
