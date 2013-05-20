"use strict";

window.menu_hold_time=500;

window.clean_menus_timeout=null;
window.active_menu=null;
window.last_active_menu=null;

function clean_menus()
{
	window.clean_menus_timeout=null;

	var m=document.getElementById('r_'+window.last_active_menu);
	if (!m) return;
	var tags=m.getElementsByTagName('ul');
	var e=(window.active_menu==null)?null:document.getElementById(window.active_menu),t;
	var i,hideable;
	for (i=tags.length-1;i>=0;i--)
	{
		if (first_class_name(tags[i].className)!='nlevel') continue;

		hideable=true;
		if (e)
		{
			t=e;
			do
			{
				if (tags[i].id==t.id) hideable=false;
				t=t.parentNode.parentNode;
			}
			while (t.id!='r_'+window.last_active_menu);
		}
		if (hideable)
		{
			tags[i].style.left='-999px';
			tags[i].style.display='none';
		}
	}
}

function set_active_menu(id,menu)
{
	window.active_menu=id;
	if (menu!=null) window.last_active_menu=menu;
}

function deset_active_menu()
{
	window.active_menu=null;

	recreate_clean_timeout();
}

function recreate_clean_timeout()
{
	if (window.clean_menus_timeout)
	{
		window.clearTimeout(window.clean_menus_timeout);
	}
	window.clean_menus_timeout=window.setTimeout(clean_menus,window.menu_hold_time);
}

function pop_up_menu(id,place,menu,event)
{
	if ((typeof place=='undefined') || (!place)) var place='right';

	var e=document.getElementById(id);

	if (window.clean_menus_timeout)
	{
		window.clearTimeout(window.clean_menus_timeout);
	}

	if (e.style.display=='block')
	{
		return false;
	}

	window.active_menu=id;
	window.last_active_menu=menu;
	clean_menus();

	var l=0;
	var t=0;
	var p=e.parentNode;

	if (abstract_get_computed_style(p.parentNode,'position')=='absolute')
	{
		l+=p.offsetLeft;
		t+=p.offsetTop;
	} else
	{
		while (p)
		{	
			if ((p) && (abstract_get_computed_style(p,'position')=='relative')) break;
			l+=p.offsetLeft;
			t+=p.offsetTop-sts(p.style.borderTop);
			p=p.offsetParent;
			if ((p) && (abstract_get_computed_style(p,'position')=='absolute')) break;
		}
	}
	if (place=='below')
	{
		t+=e.parentNode.offsetHeight;
	} else
	{
		l+=e.parentNode.offsetWidth;
	}

	var full_height=get_window_scroll_height(); // Has to be got before e is visible, else results skewed
	e.style.display='block';
	if (typeof window.fade_transition!='undefined')
	{
		set_opacity(e,0.0);
		fade_transition(e,100,30,8);
	}
	e.style.position='absolute';
	var full_width=(window.scrollX==0)?get_window_width():get_window_scroll_width();
	{+START,IF,{$CONFIG_OPTION,fixed_width}}
		var main_website_inner=document.getElementById('main_website_inner');
		if (main_website_inner) full_width=find_width(main_website_inner);
	{+END}
	if (place=='below')
	{
		if (l+find_width(e)+10>full_width) l=full_width-find_width(e)-10;
	} else
	{ // NB: For non-below, we can't assume 'l' is absolute, as it is actually relative to parent node which is itself positioned
		if (find_pos_x(p,true)+find_width(e)>full_width) l=-find_width(e);
	}
	e.style.left=l+'px';
	window.setTimeout(function() { // Force it after a refresh too, when real width is known
		if (l+find_width(e)+10>full_width) l=full_width-find_width(e)-10;
		e.style.left=l+'px';
	},0);
	if ((find_pos_y(e.parentNode,true)+find_height(e)+10>full_height) && (t-find_height(e)>0)) t-=find_height(e)+26;
	var ppp_id=e.parentNode.parentNode.parentNode.parentNode.id;
	if (ppp_id.substr(ppp_id.length-9)=='_menu_box')
		e.style.top=(t-e.clientHeight+20)+'px';
	else
		e.style.top=(t)+'px';
	e.style.zIndex=200;


	recreate_clean_timeout();

	if ((typeof event!='undefined') && (event))
	{
		cancel_bubbling(event);
	}

	return false;
}

