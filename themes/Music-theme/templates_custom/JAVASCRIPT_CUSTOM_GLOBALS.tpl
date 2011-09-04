function music_select_tab(ob,select,prefix)
{
	var headers=ob.parentNode.parentNode.getElementsByTagName('li');
	for (var i=0;i<headers.length;i++)
	{
		headers[i].className=(headers[i]==ob)?'active':'';
	}
	var num=1;
	var ob_x;
	do
	{
		ob_x=document.getElementById(prefix+num);
		if (ob_x)
		{
			ob_x.style.display=(prefix+num==select)?'block':'none';
			num++;
		}
	}
	while (ob_x);
	return false;
}
