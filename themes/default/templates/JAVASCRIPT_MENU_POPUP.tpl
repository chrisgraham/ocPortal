"use strict";

var menuHoldTime=500;

var cleanMenusTimeout=null;
var activeMenu=null,lastActiveMenu=null;

function cleanMenus()
{
	cleanMenusTimeout=null;

	var m=document.getElementById('r_'+lastActiveMenu);
	if (!m) return;
	var tags=m.getElementsByTagName('ul');
	var e=(activeMenu==null)?null:document.getElementById(activeMenu),t;
	var i,hideable;
	for (i=tags.length-1;i>=0;i--)
	{
		if (firstClassName(tags[i].className)!='nlevel') continue;

		hideable=true;
		if (e)
		{
			t=e;
			do
			{
				if (tags[i].id==t.id) hideable=false;
				t=t.parentNode.parentNode;
			}
			while (t.id!='r_'+lastActiveMenu);
		}
		if (hideable)
		{
			tags[i].style.left = "-999px";
			tags[i].style.display='none';
		}
	}
}

function setActiveMenu(id,menu)
{
	activeMenu=id;
	if (menu!=null) lastActiveMenu=menu;
}

function desetActiveMenu()
{
	activeMenu=null;

	recreateCleanTimeout();
}

function recreateCleanTimeout()
{
	if (cleanMenusTimeout)
	{
		window.clearTimeout(cleanMenusTimeout);
	}
	cleanMenusTimeout=window.setTimeout(cleanMenus,menuHoldTime);
}

function popUpMenu(id,place,menu,event)
{
	if (!place) place='right';

	var e=document.getElementById(id);

	if (cleanMenusTimeout)
	{
		window.clearTimeout(cleanMenusTimeout);
	}

	if (e.style.display=='block')
	{
		return false;
	}

	activeMenu=id;
	lastActiveMenu=menu;
	cleanMenus();

	var l=0;
	var t=0;
	var p=e.parentNode;

	if (abstractGetComputedStyle(p.parentNode,'position')=='absolute')
	{
		l+=p.offsetLeft;
		t+=p.offsetTop;
	} else
	{
		while (p)
		{	
			if ((p) && (abstractGetComputedStyle(p,'position')=='relative')) break;
			l+=p.offsetLeft;
			t+=p.offsetTop-sts(p.style.borderTop);
			p=p.offsetParent;
			if ((p) && (abstractGetComputedStyle(p,'position')=='absolute')) break;
		}
	}
	if (place=='below')
	{
		t+=e.parentNode.offsetHeight+4;
	} else
	{
		l+=e.parentNode.offsetWidth;
	}

	var full_height=getWindowScrollHeight(); // Has to be got before e is visible, else results skewed
	e.style.display='block';
	if ((typeof window.nereidFade!='undefined') && (!browser_matches('ie6')))
	{
		setOpacity(e,0.0);
		nereidFade(e,100,30,8);
	}
	e.style.position='absolute';
	var full_width=(window.scrollX==0)?getWindowWidth():getWindowScrollWidth();
	if (l+findWidth(e)+10>full_width) l=full_width-findWidth(e)-10;
	e.style.left=l+'px';
	window.setTimeout(function() { // Force it after a refresh too, when real width is known
		if (l+findWidth(e)+10>full_width) l=full_width-findWidth(e)-10;
		e.style.left=l+'px';
	},0);
	if ((findPosY(e.parentNode,true)+findHeight(e)+10>full_height) && (t-findHeight(e)>0)) t-=findHeight(e)+26;
	var ppp_id=e.parentNode.parentNode.parentNode.parentNode.id;
	if (ppp_id.substr(ppp_id.length-9)=='_menu_box')
		e.style.top=(t-e.clientHeight+20)+'px';
	else
		e.style.top=(t)+'px';
	e.style.zIndex=200;


	recreateCleanTimeout();

	if (event)
	{
		cancelBubbling(event);
	}

	return false;
}

