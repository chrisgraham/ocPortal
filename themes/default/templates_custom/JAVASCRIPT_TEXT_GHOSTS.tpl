function show_ghost(html_message)
{
	var div=document.createElement('div');
	div.style.position='absolute';
	div.className='ghost';
	setInnerHTML(div,html_message);
	var limit=36;
	for (var counter=0;counter<limit;counter++)
	{
		window.setTimeout(build_ghost_func(div,counter,limit), counter*100);
	}
	window.setTimeout(function() { document.body.removeChild(div); }, counter*100);
	document.body.appendChild(div);
}

function build_ghost_func(div,counter,limit)
{
	return function() {
		div.style.fontSize=(1+0.05*counter)+'em';
		setOpacity(div,1.0-counter/limit/1.3);
		div.style.left=((getWindowWidth()-findWidth(div))/2+getWindowScrollX())+'px';
		div.style.top=((getWindowHeight()-findHeight(div))/2-20+getWindowScrollY())+'px';
	}
}
