"use strict";

var current_list_for;

function update_ajax_admin_search_list(target,e)
{
	update_ajax_member_list(target,'admin_search',false,e);
}

function update_ajax_search_list(target,e)
{
	update_ajax_member_list(target,'search',false,e);
}

function update_ajax_author_list(target,e)
{
	update_ajax_member_list(target,'author',false,e);
}

function close_down()
{
	var current=document.getElementById('ajax_list');
	if (current) current.parentNode.removeChild(current);
}

window.currently_doing_list=null;

function update_ajax_member_list(target,special,delayed,e)
{
	if (typeof e=='undefined') var e=window.event;

	// Uncomment the below to disable backspace
	//if (!e) target.onkeyup=function (e2) { update_ajax_member_list(target,special,delayed,e2); } ; // Make sure we get the event next time
	//if ((e) && (e.keyCode==8)) return; // No back key allowed

	if (e && enter_pressed(e)) return null;

	target.setAttribute('autocomplete','off');
	if (target.disabled) return;

	if (!target.onblur) target.onblur=function () { setTimeout(function() { close_down(); } ,300); }

	if (!delayed) // A delay, so as not to throw out too many requests
	{
		if (window.currently_doing_list)
		{
			window.clearTimeout(window.currently_doing_list);
			window.currently_doing_list=null;
		}
		var e_copy={ 'keyCode': e.keyCode, 'which': e.which };
		window.currently_doing_list=window.setTimeout(function() { update_ajax_member_list(target,special,true,e_copy); } ,400);
		return;
	} else
	{
		window.currently_doing_list=null;
	}

	target.special=special;

	var v=target.value;

	current_list_for=target;
	var url='{$BASE_URL_NOHTTP}/data/namelike.php?id='+encodeURIComponent(v);
	if (special) url=url+'&special='+special;

	if (typeof window.do_ajax_request!='undefined') do_ajax_request(url+keep_stub(),update_ajax_member_list_response);
}

function update_ajax_member_list_response(result,list_contents)
{
	if (!list_contents) return;
	if (current_list_for==null) return;

	close_down();

	//if (list_contents.childNodes.length==0) return;
	var list=document.createElement('select');
	list.className='people_list';
	if (list_contents.childNodes.length==1) // We need to make sure it is not a dropdown. Normally we'd use size (multiple isn't correct, but we'll try this for 1 as it may be more stable on some browsers with no side effects)
	{
		list.setAttribute('multiple','multiple');
	} else
	{
		list.setAttribute('size',list_contents.childNodes.length+1);
	}
	list.setAttribute('id','ajax_list');
	list.style.position='absolute';
	list.style.left=(findPosX(current_list_for))+'px';
	list.style.top=(findPosY(current_list_for)+findHeight(current_list_for))+'px';
	setTimeout(function() { list.style.zIndex++; } ,100); // Fixes Opera by causing a refresh

	if (list_contents.childNodes.length==0) return;

	var i,item;
	for (i=0;i<list_contents.childNodes.length;i++)
	{
		item=document.createElement('option');
		item.value=list_contents.childNodes[i].getAttribute('value');
		item.text=list_contents.childNodes[i].getAttribute('value');
		item.innerText=list_contents.childNodes[i].getAttribute('value');
		list.appendChild(item);
	}
	item=document.createElement('option');
	item.disabled=true;
	item.text='{!SUGGESTIONS_ONLY;}'.toUpperCase();
	item.innerText='{!SUGGESTIONS_ONLY;}'.toUpperCase();
	list.appendChild(item);
	current_list_for.parentNode.appendChild(list);
	if (typeof window.nereidFade!='undefined')
	{
		setOpacity(list,0.0);
		nereidFade(list,100,30,8);
	}

	var current_list_for_copy=current_list_for;

	if (typeof current_list_for.old_onkeyup=='undefined')
		current_list_for.old_onkeyup=current_list_for.onkeyup;
	if (typeof current_list_for.old_onchange=='undefined')
		current_list_for.old_onchange=current_list_for.onchange;

	var make_selection=function(e)
	{
		if (typeof e=='undefined') var e=window.event;
		var el=e.target;
		if (!el) el=e.srcElement;
		current_list_for_copy.value=el.value;
		current_list_for_copy.onkeyup=current_list_for_copy.old_onkeyup;
		current_list_for_copy.onchange=current_list_for_copy.old_onchange;
		current_list_for_copy.onkeypress=function() {};
		if (typeof current_list_for_copy.onrealchange!='undefined' && current_list_for_copy.onrealchange) current_list_for_copy.onrealchange(e);
		if (typeof current_list_for_copy.onchange!='undefined' && current_list_for_copy.onchange) current_list_for_copy.onchange(e);
		var al=document.getElementById('ajax_list');
		al.parentNode.removeChild(al);
		window.setTimeout(function() {
			current_list_for_copy.focus();
		}, 300);
	};

	current_list_for.down_once=false;
	var handle_arrow_usage=function(event) {
		if (typeof event=='undefined') var event=window.event;
		if (key_pressed(event,40,true)) // DOWN
		{
			current_list_for_copy.disabled=true;
			window.setTimeout(function() { current_list_for_copy.disabled=false; }, 1000);
			
			var temp=current_list_for_copy.onblur;
			current_list_for_copy.onblur=function() {};
			list.focus();
			current_list_for_copy.onblur=temp;
			if (!current_list_for_copy.down_once)
			{
				current_list_for_copy.down_once=true;
				list.selectedIndex=0;
			} else
			{
				if (list.selectedIndex<list.options.length-1) list.selectedIndex++;
			}
			list.options[list.selectedIndex].selected=true;
			return cancelBubbling(event);
		}
		if (key_pressed(event,38,true)) // UP
		{
			current_list_for_copy.disabled=true;
			window.setTimeout(function() { current_list_for_copy.disabled=false; }, 1000);
			
			var temp=current_list_for_copy.onblur;
			current_list_for_copy.onblur=function() {};
			list.focus();
			current_list_for_copy.onblur=temp;
			if (!current_list_for_copy.down_once)
			{
				current_list_for_copy.down_once=true;
				list.selectedIndex=0;
			} else
			{
				if (list.selectedIndex>0) list.selectedIndex--;
			}
			list.options[list.selectedIndex].selected=true;
			return cancelBubbling(event);
		}
		return null;
	}
	current_list_for.onkeyup=function(event)
	{
		if (typeof event=='undefined') var event=window.event;
		var ret=handle_arrow_usage(event);
		if (ret!=null) return ret;
		return update_ajax_member_list(current_list_for_copy,current_list_for_copy.special,false,event);
	}
	current_list_for.onchange=function(event)
	{
		current_list_for_copy.onkeyup=current_list_for_copy.old_onkeyup;
		current_list_for_copy.onchange=current_list_for_copy.old_onchange;
		if (current_list_for_copy.onchange) current_list_for_copy.onchange(event);
	}
	list.onkeyup=function(event)
	{
		if (typeof event=='undefined') var event=window.event;

		var ret=handle_arrow_usage(event);
		if (ret!=null) return ret;
		if (enter_pressed(event)) // ENTER
		{
			make_selection(event);
			current_list_for_copy.disabled=true;
			window.setTimeout(function() { current_list_for_copy.disabled=false; }, 200);

			return cancelBubbling(event);
		}
		if (key_pressed(event,[40,38],true))
		{
			if (typeof event.preventDefault!='undefined') event.preventDefault();
			return cancelBubbling(event);
		}
		return null;
	}
	current_list_for.onkeypress=function(event)
	{
		if (typeof event=='undefined') var event=window.event;

		if (key_pressed(event,[40,38],true))
		{
			if (typeof event.preventDefault!='undefined') event.preventDefault();
			return cancelBubbling(event);
		}
		return null;
	}
	list.onkeypress=function(event)
	{
		if (typeof event=='undefined') var event=window.event;

		if (key_pressed(event,[40,38,13],true))
		{
			if (typeof event.preventDefault!='undefined') event.preventDefault();
			return cancelBubbling(event);
		}
		return null;
	}

	addEventListenerAbstract(list,'click',make_selection,false);

	current_list_for=null;
}

