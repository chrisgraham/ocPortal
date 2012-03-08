"use strict";

function set_edited_panel(object_ignore /* No longer used */,id)
{
	var store;

	/* The editing box */

	var object=document.getElementById('edit_'+id+'_textarea');
	if ((object) && (object.nodeName.toLowerCase()=='textarea'))
	{
		store=document.getElementById('store_'+id);
		if (!store)
		{
			store=document.createElement('textarea');
			store.name=object.name;
			store.id='store_'+id;
			document.getElementById('edit_field_store').appendChild(store);
		}
		store.value=getTextbox(object);
	}

	/* The WYSIWYG setting (not the actual HTML text value of the editor, the setting of whether WYSIWYG was used or not) */

	var object=document.getElementById('edit_'+id+'_textarea__is_wysiwyg');
	if (object)
	{
		store=document.getElementById('wysiwyg_store_'+id);
		if (!store)
		{
			store=document.createElement('textarea');
			store.name=object.name;
			store.id='wysiwyg_store_'+id;
			document.getElementById('edit_field_store').appendChild(store);
		}
		store.value=object.value;
	}

	/* The redirect setting */

	var object=document.getElementById('redirect_'+id);
	if ((object) && (object.nodeName.toLowerCase()=='select'))
	{
		store=document.getElementById('redirects_store_'+id);
		if (!store)
		{
			store=document.createElement('textarea');
			store.name=object.name;
			store.id='redirects_store_'+id;
			document.getElementById('edit_field_store').appendChild(store);
		}
		store.value=object.options[object.selectedIndex].value;
	}
}

function fetch_more_fields()
{
	set_edited_panel(null,'panel_left');
	set_edited_panel(null,'panel_right');
	set_edited_panel(null,'panel_top');
	set_edited_panel(null,'panel_bottom');
	set_edited_panel(null,'start');
	
	var form=document.getElementById('middle_fields');
	var edit_field_store=document.getElementById('edit_field_store');
	var i,store;
	for (i=0;i<form.elements.length;i++)
	{
		store=document.createElement('input');
		store.setAttribute('type','hidden');
		store.name=form.elements[i].name;
		if (form.elements[i].getAttribute('type')=='checkbox')
		{
			store.value=form.elements[i].checked?'1':'0';
		} else
		{
			store.value=form.elements[i].value;
		}
		edit_field_store.appendChild(store);
	}
//	window.setTimeout(function () { form.submit(); } , 1000);
}

function select_ze_tab(id,tab)
{
	var tabs=['view','edit','info','settings'];
	var i,j,element,elementh,selects;

	for (i=0;i<tabs.length;i++)
	{
		element=document.getElementById(tabs[i]+'_'+id);
		elementh=document.getElementById(tabs[i]+'_tab_'+id);
		if (element)
		{
			element.style.display=(tabs[i]==tab)?'block':'none';
			if ((tabs[i]==tab) && (tab=='edit'))
			{
				if (isWYSIWYGField(document.getElementById('edit_'+id+'_textarea')))
				{
					// Fix for Firefox
					if (typeof areaedit_editors['edit_'+id+'_textarea'].document!='undefined')
					{
						areaedit_editors['edit_'+id+'_textarea'].document.getBody().$.contentEditable='false';
						areaedit_editors['edit_'+id+'_textarea'].document.getBody().$.contentEditable='true';
					}
				}
			}
			if ((typeof window.nereidFade!='undefined') && (tabs[i]==tab))
			{
				if (!browser_matches('ie6'))
				{
					setOpacity(element,0.0);
					nereidFade(element,100,30,4);
				}
				
				elementh.className+=' ze_tab_selected';
			} else
			{
				elementh.className=elementh.className.replace(/ ze_tab_selected$/,'');
			}
		}
	}
}

function ze_ie6(element)
{
	// IE6 will not overlay over select inputs
	if (browser_matches('ie6'))
	{
		var i,selects;
		selects=document.getElementById('ze_panels_wrap').getElementsByTagName('select');
		for (j=0;j<selects.length;j++)
		{
			selects[j].style.visibility='hidden';
		}
		selects=element.getElementsByTagName('select');
		for (j=0;j<selects.length;j++)
		{
			selects[j].style.visibility='visible';
		}
	}
}

var ze_timer=[];
var ze_delay_function=[];
function ze_animate_to(ob,amount,towards_expanded,now)
{
	if (browser_matches('ie6')) // Slow
	{
		ob.style.width=(amount)+'em';
		return;
	}
	
	{+START,IF,{$VALUE_OPTION,disable_animations}}
		ob.style.width=(amount)+'em';
		return;
	{+END}

	if ((!now) && (!towards_expanded))
	{
		window.ze_delay_function[ob.id]=window.setTimeout(function() { ze_animate_to(ob,amount,towards_expanded,true); } ,1500);
		return;
	}

	if (window.ze_timer[ob.id])
	{
		window.clearTimeout(window.ze_timer[ob.id]);
		window.ze_timer[ob.id]=null;
	}

	var currently_expanded=(ob.className.indexOf('ze_panel_expanded')!=-1);

	if (
		( ((currently_expanded) && (towards_expanded)) || ((!currently_expanded) && (!towards_expanded)) ) &&
		(ob.style.width!=amount+'em')
	)
	{
		var w_now=window.parseFloat(ob.style.width.replace('em',''));
		if (w_now<amount)
		{
			ob.style.width=(w_now+0.5)+'em';
		} else
		{
			ob.style.width=(w_now-0.5)+'em';
		}
		window.ze_timer[ob.id]=window.setTimeout(function () { ze_animate_to(ob,amount,towards_expanded,now); } , 10 );
	} else
	{
		window.ze_timer[ob.id]=null;
	}
}

function reload_preview(id)
{
	if (typeof window.do_ajax_request=='undefined') return;
	if (typeof window.merge_text_nodes=='undefined') return;

	var element=document.getElementById('view_'+id);

	var edit_element=document.getElementById('edit_'+id+'_textarea');
	if (!edit_element) return; // Nothing interatively edited

	setInnerHTML(element,'<div{$?,{$VALUE_OPTION,html5}, aria-busy="true"} class="ajax_tree_list_loading"><img class="inline_image_2" src="'+'{$IMG,bottom/loading}'.replace(/^http:/,window.location.protocol)+'" /> {!LOADING^;}</div>');

	window.loading_preview_of=id;

	var data='';
	data+=getTextbox(edit_element);
	do_ajax_request('{$FIND_SCRIPT_NOHTTP;,comcode_convert}?fix_bad_html=1&css=1&javascript=1&from_html=0&is_semihtml='+(isWYSIWYGField(edit_element)?'1':'0')+'&panel='+(((id=='panel_left') || (id=='panel_right'))?'1':'0')+keep_stub(),reloaded_preview,(isWYSIWYGField(edit_element)?'data__is_wysiwyg=1&':'')+'data='+window.encodeURIComponent(data));
}

function reloaded_preview(ajax_result_frame,ajax_result)
{
	if (typeof window.loading_preview_of=='undefined') return;
	var element=document.getElementById('view_'+window.loading_preview_of);
	setInnerHTML(element,merge_text_nodes(ajax_result.childNodes).replace(/^((\s)|(\<br\s*\>)|(&nbsp;))*/,'').replace(/((\s)|(\<br\s*\>)|(&nbsp;))*$/,''));

	disable_preview_scripts(element);
}


