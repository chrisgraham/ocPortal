"use strict";

function advanced_notifications_check_sensible(form)
{
	var checkboxes=get_elements_by_class_name(form,'notifications_types')[0].getElementsByTagName('input');
	var checked=false;
	for (var i=0;i<checkboxes.length;i++)
	{
		checked=checked || ((checkboxes[i].type=='checkbox') && (checkboxes[i].checked)) || ((checkboxes[i].type=='hidden') && (checkboxes[i].value=='1'));
	}
	if (!checked)
	{
		window.fauxmodal_alert('{!notifications:NOTIFICATIONS_ALERT_MESSAGE;}');
	}
	return checked;
}

function advanced_notifications_check_all(button)
{
	var form=button.form;

	var btntxt=button.value;

	if (btntxt=='{!notifications:NOTIFICATIONS_CHECK_ALL;}')
	{
		var enable=true;
		var btntxt='{!notifications:NOTIFICATIONS_UNCHECK_ALL;}';

		if (!advanced_notifications_check_sensible(form)) return;
	} else
	{
		var enable=false;
		var btntxt='{!notifications:NOTIFICATIONS_CHECK_ALL;}';
	}

	window.fauxmodal_confirm(
		enable?'{!notifications:NOTIFICATIONS_CHECK_ALL_CONFIRM_MESSAGE;}':'{!notifications:NOTIFICATIONS_UNCHECK_ALL_CONFIRM_MESSAGE;}',
		function(answer)
		{
			if (answer)
			{
				for (var i=0;i<form.elements.length;i++)
				{
					if ((form.elements[i].type=='checkbox') && (form.elements[i].name.indexOf('category')!=-1))
						form.elements[i].checked=enable;
				}
				button.value=btntxt;
			}
		}
	);
}
