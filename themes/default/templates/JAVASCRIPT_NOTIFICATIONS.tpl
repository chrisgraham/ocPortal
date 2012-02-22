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
