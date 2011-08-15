function track_children()
{
	var _email=document.getElementById('email');
	var email=false;
	if (_email) email=((_email.type=='checkbox') && (_email.checked)) || ((_email.type=='hidden') && (_email.value=='1'));
	var _sms=document.getElementById('sms');
	var sms=false;
	if (_sms) sms=((_sms.type=='checkbox') && (_sms.checked)) || ((_sms.type=='hidden') && (_sms.value=='1'));
	if(!email && !sms)
	{
		window.alert('{!tracking:TRACKING_ALERT_MESSAGE;}');
		return false;
	}
}

function check_all(form, checkBox, button)
{
	var btntxt	=	button.value;

	if(btntxt=='{!CHECK_ALL;}')
	{
		var enable	=	true;
		var btntxt	=	'{!UNCHECK_ALL;}';
	}
	else
	{
		var enable=false;
		var btntxt	=	'{!CHECK_ALL;}';
	}

	if(confirm(enable?'{!tracking:CHECK_ALL_CONFIRM_MESSAGE;}':'{!tracking:UNCHECK_ALL_CONFIRM_MESSAGE;}'))
	{
		var objCheckBoxes = document.forms[form].elements[checkBox];
		var countCheckBoxes = objCheckBoxes.length;
		for(var i = 0; i < countCheckBoxes; i++)
			objCheckBoxes[i].checked = enable;
		button.value	=	btntxt;
	}
}
