"use strict";

// ==============
// MENU FUNCTIONS
// ==============

function makeFieldSelected(ob)
{
	if (ob.className=='menu_editor_selected_field') return;
	
	ob.className='menu_editor_selected_field';
	var changed=false;
	for (var i=0;i<ob.form.elements.length;i++)
	{
		if ((ob.form.elements[i].className=='menu_editor_selected_field') && (ob.form.elements[i]!=ob))
		{
			ob.form.elements[i].className='';
			changed=true;
		}
	}

	copyFieldsIntoBottom(ob.id.substr(8),changed);
}

function copyFieldsIntoBottom(i,changed)
{
	window.current_selection=i;
	var form=document.getElementById('edit_form');
	form.elements['caption_long'].value=document.getElementById('caption_long_'+i).value;
	form.elements['caption_long'].onchange=function () { document.getElementById('caption_long_'+i).value=this.value; };
	form.elements['url'].value=document.getElementById('url_'+i).value;
	form.elements['url'].onchange=function () { document.getElementById('url_'+i).value=this.value; };
	form.elements['match_tags'].value=document.getElementById('match_tags_'+i).value;
	form.elements['match_tags'].onchange=function () { document.getElementById('match_tags_'+i).value=this.value; };
	var s;
	for (s=0;s<form.elements['theme_img_code'].options.length;s++)
		if (document.getElementById('theme_img_code_'+i).value==form.elements['theme_img_code'].options[s].value) break;
	if (s!=form.elements['theme_img_code'].options.length) form.elements['theme_img_code'].selectedIndex=s;
	form.elements['theme_img_code'].onchange=function () { document.getElementById('theme_img_code_'+i).value=this.options[this.selectedIndex].value; };
	form.elements['new_window'].checked=document.getElementById('new_window_'+i).value=='1';
	form.elements['new_window'].onclick=function () { document.getElementById('new_window_'+i).value=this.checked?'1':'0'; };
	form.elements['check_perms'].checked=document.getElementById('check_perms_'+i).value=='1';
	form.elements['check_perms'].onclick=function () { document.getElementById('check_perms_'+i).value=this.checked?'1':'0'; };
	//setInnerHTML(form.elements['branch_type'],getInnerHTML(document.getElementById('branch_type_'+i))); Breaks in IE due to strict container rules
	form.elements['branch_type'].selectedIndex=document.getElementById('branch_type_'+i).selectedIndex;
	form.elements['branch_type'].onchange=function () { document.getElementById('branch_type_'+i).selectedIndex=this.selectedIndex; if (document.getElementById('branch_type_'+i).onchange) document.getElementById('branch_type_'+i).onchange(); };
	var mfh=document.getElementById('mini_form_hider');
	mfh.style.display='block';
	if ((typeof window.nereidFade!='undefined'))
	{
		if (!changed)
		{
			setOpacity(mfh,0.0);
			nereidFade(mfh,100,30,4);
		} else
		{
			setOpacity(form.elements['url'],0.0);
			nereidFade(form.elements['url'],100,30,4);
		}
	}
}

function menuEditorHandleKeypress(e)
{
	if (!e) e=window.event;
	var t=e.srcElement?e.srcElement:e.target;
	
	var up=(e.keyCode?e.keyCode:e.charCode)==38;
	var down=(e.keyCode?e.keyCode:e.charCode)==40;
	
	handleOrdering(t,up,down);
}

function branchDepth(branch)
{
	if (branch.parentNode) return branchDepth(branch.parentNode)+1;
	return 0;
}

function existsChild(elements,parent)
{
	for (var i=0;i<elements.length;i++)
	{
		if ((elements[i].name.substr(0,7)=='parent_') && (elements[i].value==parent)) return true;
	}
	return false;
}

function isChild(elements,possible_parent,possible_child)
{
	for (var i=0;i<elements.length;i++)
	{
		if ((elements[i].name.substr(7)==possible_child) && (elements[i].name.substr(0,7)=='parent_'))
		{
			if (elements[i].value==possible_parent) return true;
			return isChild(elements,possible_parent,elements[i].value);
		}
	}
	return false;
}

function handleOrdering(t,up,down)
{
	if ((up) || (down))
	{
		var form=document.getElementById('edit_form');

		// Find the num
		var index=t.id.substring(t.id.indexOf('_')+1,t.id.length);
		var num=window.parseInt(form.elements['order_'+index].value);

		// Find the parent
		var parent_num=document.getElementById('parent_'+index).value;

		var i,b,bindex;
		var best=-1,bestindex=-1;
	}

	if (up) // Up
	{
		// Find previous branch with same parent (if exists)
		for (i=0;i<form.elements.length;i++)
		{
			if ((form.elements[i].name.substr(0,7)=='parent_') &&
				 (form.elements[i].value==parent_num))
			{
				bindex=form.elements[i].name.substr(7,form.elements[i].name.length);
				b=window.parseInt(form.elements['order_'+bindex].value);
				if ((b<num) && (b>best))
				{
					best=b;
					bestindex=bindex;
				}
			}
		}
	}

	if (down) // Down
	{
		// Find next branch with same parent (if exists)
		for (i=0;i<form.elements.length;i++)
		{
			if ((form.elements[i].name.substr(0,7)=='parent_') &&
				 (form.elements[i].value==parent_num))
			{
				bindex=form.elements[i].name.substr(7,form.elements[i].name.length);
				b=window.parseInt(form.elements['order_'+bindex].value);
				if ((b>num) && ((b<best) || (best==-1)))
				{
					best=b;
					bestindex=bindex;
				}
			}
		}
	}

	if (((up) || (down))/* && (best==-1)*/)
	{
		var elements=form.getElementsByTagName('input');
		for (i=0;i<elements.length;i++)
		{
			if (elements[i].name=='parent_'+index) // Found our spot
			{
				var us=elements[i];
				for (b=up?(i-1):(i+1);up?(b>0):(b<elements.length);up?b--:b++)
				{
					if ((!isChild(elements,index,elements[b].name.substr(7))) && (elements[b].name.substr(0,7)=='parent_') && ((up) || (document.getElementById('branch_type_'+elements[b].name.substr(7)).selectedIndex==0) || (!existsChild(elements,elements[b].name.substr(7)))))
					{
						var target=elements[b];
						var main=us.parentNode.parentNode;
						var place=target.parentNode.parentNode;
						if (((up) && (branchDepth(target)<=branchDepth(us))) || ((down) && (branchDepth(target)!=branchDepth(us))))
						{
							main.parentNode.removeChild(main);
							place.parentNode.insertBefore(main,place);
						} else
						{
							main.parentNode.removeChild(main);
							if (!place.nextSibling)
							{
								place.parentNode.appendChild(main);
							} else
							{
								place.parentNode.insertBefore(main,place.nextSibling);
							}
						}
						us.value=target.value;
						return;
					}
				}
			}
		}
	}
	return; // Ignore old code below

	if (((up) || (down)) && (best!=-1))
	{
		// Swap names (how it saves)
		swap_names('up',bestindex,index);
		swap_names('down',bestindex,index);
		swap_names('caption',bestindex,index);
		swap_names('caption_long',bestindex,index);
		swap_names('url',bestindex,index);
		swap_names('match_tags',bestindex,index);
		swap_names('theme_img_code',bestindex,index);
		swap_names('new_window',bestindex,index);
		swap_names('check_perms',bestindex,index);
		swap_names('branch_type',bestindex,index);
		swap_names('order',bestindex,index,null,true);
		swap_names('parent',bestindex,index);
		swap_names('del',bestindex,index);
		swap_names('branch_wrap',bestindex,index);
		swap_names('branch',bestindex,index);
		swap_names('branches_go_before',bestindex,index);
		swap_names('add_new_menu_link',bestindex,index);
		swap_names('branch',bestindex,index,'_follow_1');
		swap_names('branch',bestindex,index,'_follow_2');

		// Swap any children parent-referencing-IDs
		var index_a=document.getElementById('branch_wrap_'+index);
		var bestindex_a=document.getElementById('branch_wrap_'+bestindex);
		for (i=0;i<form.elements.length;i++)
		{
			if ((form.elements[i].name.substr(0,7)=='parent_') &&
				 (form.elements[i].value==index))
			{
				form.elements[i].value=bestindex;
			}
			else
			if ((form.elements[i].name.substr(0,7)=='parent_') &&
				 (form.elements[i].value==bestindex))
			{
				form.elements[i].value=index;
			}
		}

		// Move DOM branch (how it displays)
		if (up)
		{
			bestindex_a.parentNode.removeChild(bestindex_a);
			index_a.parentNode.insertBefore(bestindex_a,index_a);
		}
		if (down)
		{
			bestindex_a.parentNode.removeChild(bestindex_a);
			var ref=index_a.nextSibling;
			index_a.parentNode.insertBefore(bestindex_a,ref);
		}

		return false; // Cancel event (we do not want cursor to move)
	}
	
	return true;
}

function swap_names(t,a,b,t2,values_also)
{
	if (!t2) t2='';
	var _a=document.getElementById(t+'_'+a+t2);
	var _b=document.getElementById(t+'_'+b+t2);
	_a.name=t+'_'+b+t2;
	_b.name=t+'_'+a+t2;
	_a.id=t+'_'+b+t2;
	_b.id=t+'_'+a+t2;
	if (values_also)
	{
		var temp=_a.value;
		_a.value=_b.value;
		_b.value=temp;
	}

	var _al=document.getElementById('label_'+t+'_'+a+t2);
	var _bl=document.getElementById('label_'+t+'_'+b+t2);
	if (_al)
	{
		_al.setAttribute('for',t+'_'+b+t2);
		_bl.setAttribute('for',t+'_'+a+t2);
		_al.id='label_'+t+'_'+b+t2;
		_bl.id='label_'+t+'_'+a+t2;
	}
}

function magicCopier(object,caption,url,error_message,confirm_message)
{
	var e=parent.document.getElementsByName('selected');

	var i,num,yes=false,target_type;
	for (i=0;i<e.length;i++)
	{
		if (e[i].checked)
		{
			num=e[i].value.substring(9,e[i].value.length);
			target_type=parent.document.getElementById('branch_type_'+num);
			if ((target_type.value=='page') || (target_type.getElementsByTagName('option').length<3))
			{
				if (parent.document.getElementById('url_'+num).value=='')
				{
					_doMagicCopier(num,url,caption);
				} else
				{
					window.fauxmodal_confirm(
						confirm_message,
						function(answer)
						{
							if (answer) _doMagicCopier(num,url,caption);
						}
					);
				}
			} else window.fauxmodal_alert(error_message);
			yes=true;
		}
	}
	if (!yes) window.fauxmodal_alert('{!RADIO_NOTHING_SELECTED^;}');

	return false;
}

function _doMagicCopier(num,url,caption)
{
	parent.document.getElementById('url_'+num).value=url;
	parent.document.getElementById('caption_'+num).value=caption;
}

function menuEditorBranchTypeChange(id)
{
	var disabled=(document.getElementById('branch_type_'+id).value!='page');
	/*document.getElementById('new_window_'+id).disabled=disabled;
	document.getElementById('check_perms_'+id).disabled=disabled;
	document.getElementById('url_'+id).disabled=disabled;*/
	var sub=document.getElementById('branch_'+id+'_follow_1');
	if (sub)
	{
		sub.style.display=disabled?'block':'none';
	}
	sub=document.getElementById('branch_'+id+'_follow_2');
	if (sub) sub.style.display=disabled?'block':'none';
}

function deleteBranch(id)
{
	var branch=document.getElementById(id);
	branch.parentNode.removeChild(branch);
}

function addNewMenuItem(parent_id,clickable_sections)
{
	var insert_before_id='branches_go_before_'+parent_id;

	var template=document.getElementById('template').value;

	var before=document.getElementById(insert_before_id);
	var new_id=Math.floor(Math.random()*10000);
	var template2=template.replace(/replace\_me\_with\_random/gi,new_id);
	var highest_order_element=document.getElementById('highest_order');
	var new_order=highest_order_element.value+1;
	highest_order_element.value++;
	template2=template2.replace(/replace\_me\_with\_order/gi,new_order);
	template2=template2.replace(/replace\_me\_with\_parent/gi,parent_id);

	// Backup form branches
	var form=document.getElementById('edit_form');
	var _elements_bak=form.elements,elements_bak=[];
	var i;
	for (i=0;i<_elements_bak.length;i++)
	{
		elements_bak.push([_elements_bak[i].name,_elements_bak[i].value]);
	}

	setInnerHTML(before,template2,true); // Technically we are actually putting after "branches_go_before_XXX", but it makes no difference. It only needs to act as a divider.

	// Restore form branches
	for (i=0;i<elements_bak.length;i++)
	{
		if (elements_bak[i][0])
		{
			form.elements[elements_bak[i][0]].value=elements_bak[i][1];
		}
	}

	if (!clickable_sections) menuEditorBranchTypeChange(new_id);

	//document.getElementById('selected_'+new_id).checked=true;

	document.getElementById('mini_form_hider').style.display='none';

	return false;
}

function validateMenu(missingCaptionError,missingURLError)
{
	var form=document.getElementById('edit_form');
	var i,id,name,the_parent,ignore,caption,url,branch_type;
	for (i=0;i<form.elements.length;i++)
	{
		name=form.elements[i].name.substr(0,7);
		if (name=='parent_') // We don't care about this, but it does tell us we have found a menu branch id
		{
			id=form.elements[i].name.substring(7,form.elements[i].name.length);

			// Is this visible? (if it is we need to validate the IDs
			the_parent=form.elements[i];
			do
			{
				if (the_parent.style.display=='none')
				{
					ignore=true;
					break;
				}
				the_parent=the_parent.parentNode;
			}
			while (the_parent.parentNode);

			if (!ignore) // It's the real deal
			{
				// Check we have a caption
				caption=document.getElementById('caption_'+id);
				url=document.getElementById('url_'+id);
				if ((caption.value=='') && (url.value!=''))
				{
					window.fauxmodal_alert(missingCaptionError);
					return false;
				}

				// If we are a page, check we have a URL
				branch_type=document.getElementById('branch_type_'+id);
				if (branch_type.options[branch_type.selectedIndex].value=='page')
				{
					if ((caption.value!='') && (url.value==''))
					{
						window.fauxmodal_alert(missingURLError);
						return false;
					}
				}
			}
		}
	}

	return true;
}

function delete_menu_branch(ob)
{
	var id=ob.id.substring(4,ob.id.length);
	
	if ((typeof window.showModalDialog!='undefined'{+START,IF,{$NOT,{$VALUE_OPTION,no_faux_popups}}} || true{+END}) || (ob.form.elements['branch_type_'+id]!='page'))
	{
		var choices=['{!INPUTSYSTEM_CANCEL^;}','{!DELETE^;}','{!MOVETO_MENU^;}'];
		generate_question_ui(
			'{!CONFIRM_DELETE_LINK_NICE^;,xxxx}'.replace('xxxx',document.getElementById('caption_'+id).value),
			choices,
			'{!DELETE_MENU_ITEM^;}',
			null,
			function(result)
			{
				if (result.toLowerCase()=='{!DELETE^;}'.toLowerCase())
				{
					deleteBranch('branch_wrap_'+ob.name.substr(4,ob.name.length));
				} else if (result.toLowerCase()=='{!MOVETO_MENU^;}'.toLowerCase())
				{
					var choices=['{!INPUTSYSTEM_CANCEL^;}'];
					for (var i=0;i<window.all_menus.length;i++)
					{
						choices.push(window.all_menus[i]);
					}
					generate_question_ui(
						'{!CONFIRM_MOVE_LINK_NICE^;,xxxx}'.replace('xxxx',document.getElementById('caption_'+id).value),
						choices,
						'{!MOVE_MENU_ITEM^;}',
						null,
						function(result)
						{
							if (result.toLowerCase()!='{!INPUTSYSTEM_CANCEL^;}'.toLowerCase())
							{
								var post='',name,value;
								for (var i=0;i<ob.form.elements.length;i++)
								{
									name=ob.form.elements[i].name;
									if (name.substr(name.length-('_'+id).length)=='_'+id)
									{
										if (ob.nodeName.toLowerCase()=='select')
										{
											value=ob.form.elements[i].value;
											myValue=ob.options[ob.selectedIndex].value;
										} else
										{
											if ((ob.type.toLowerCase()=='checkbox') && (!ob.checked)) continue;

											value=ob.form.elements[i].value;
										}
										if (post!='') post+='&';
										post+=name+'='+window.encodeURIComponent(value);
									}
								}
								load_XML_doc('{$FIND_SCRIPT_NOHTTP;,menu_management}'+'?id='+window.encodeURIComponent(id)+'&menu='+window.encodeURIComponent(result)+keep_stub(),null,post);
								deleteBranch('branch_wrap_'+ob.name.substr(4,ob.name.length));
							}
						}
					);
				}
			}
		);
	} else
	{
		window.fauxmodal_confirm(
			'{!CONFIRM_DELETE_LINK^;,xxxx}'.replace('xxxx',document.getElementById('caption_'+id).value),
			function(result)
			{
				if (result)
					deleteBranch('branch_wrap_'+ob.name.substr(4,ob.name.length));
			}
		);
	}
}
