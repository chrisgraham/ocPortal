"use strict";

function chooseURLJump(ob,max,url_stub,message,num_pages)
{
	var res=window.prompt(message,num_pages);
	if (res)
	{
		res=parseInt(res);
		if ((res>=1) && (res<=num_pages))
		{
			ob.href=url_stub+((url_stub.indexOf('?')==-1)?'?':'&')+'start='+(max*(res-1));
			return true;
		}
	}
	return false;
}
