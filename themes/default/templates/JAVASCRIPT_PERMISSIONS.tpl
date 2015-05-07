"use strict";

function permissions_toggle(cell)
{
	var index=cell.cellIndex;
	var table=cell.parentNode.parentNode;
	if (table.nodeName.toLowerCase()!='table') table=table.parentNode;
	var state_list=null,state_checkbox=null;
	for (var i=0;i<table.rows.length;i++)
	{
		if (i>=1)
		{
			var cell2=table.rows[i].cells[index];
			var input=cell2.getElementsByTagName('input')[0];
			if (input)
			{
				if (!input.disabled)
				{
					if (state_checkbox==null) state_checkbox=input.checked;
					input.checked=!state_checkbox;
				}
			} else
			{
				input=cell2.getElementsByTagName('select')[0];
				if (state_list==null) state_list=input.selectedIndex;
				input.selectedIndex=((state_list!=input.options.length-1)?(input.options.length-1):(input.options.length-2));
				input.disabled=false;

				permissions_overridden(table.rows[i].id.replace(/_sp_container$/,''));
			}
		}
	}
}

function fade_icons_out()
{
	var icons=get_elements_by_class_name(document,'perm_icon');
	for (var i=0;i<icons.length;i++)
	{
		set_opacity(icons[i],1.0);
		if (typeof window.fade_transition!='undefined') fade_transition(icons[i],20,50,-10);
	}
}

function fade_icons_in()
{
	var icons=get_elements_by_class_name(document,'perm_icon');
	for (var i=0;i<icons.length;i++)
	{
		if (typeof window.fade_transition!='undefined') fade_transition(icons[i],100,50,10);
	}
}

function show_permission_setting(ob,event)
{
	if (ob.disabled) return; // already showing default in disabled dropdown
	if (ob.done) return;
	ob.done=true;

	if (!ob.full_setting)
	{
		var serverid;

		if (typeof window.site_tree!='undefined')
		{
			var value=document.getElementById('tree_list').value;

			if (value.indexOf(',')!=-1) return; // Can't find any single value, as multiple resources are selected

			var node=window.site_tree.getElementByIdHack(value);
			serverid=node.getAttribute('serverid');
		} else
		{
			serverid=window.perm_serverid+':_new_';
		}

		var url='{$FIND_SCRIPT_NOHTTP;,find_permissions}?serverid='+window.encodeURIComponent(serverid)+'&x='+window.encodeURIComponent(ob.name);
		var ret=do_ajax_request(url+keep_stub(),false);
		if (!ret) return;
		ob.full_setting=ret.responseText;
	}

	ob.title+=' [{!permissions:DEFAULT_PERMISSION;^} '+ob.full_setting+']';
}

function cleanup_permission_list(name)
{
	// We always try and cleanup the 'custom' option if we're choosing something else (because it's confusing for it to stay there)
	var custom_option=document.getElementById(name+'_custom_option');
	if (custom_option) custom_option.parentNode.removeChild(custom_option);
}

function permissions_overridden(select)
{
	var element=document.getElementById(select+'_presets');
	if (element.options[0].id!=select+'_custom_option')
	{
		var new_option=document.createElement('option');
		set_inner_html(new_option,'{!permissions:PINTERFACE_LEVEL_CUSTOM;^}');
		new_option.id=select+'_custom_option';
		new_option.value='';
		element.insertBefore(new_option,element.options[0]);
	}
	element.selectedIndex=0;
}

function copy_permission_presets(name,value,just_track)
{
	if (value=='') return false;

	var made_change=false;

	var usual_suspects=['bypass_validation_xrange_content','edit_xrange_content','edit_own_xrange_content','delete_xrange_content','delete_own_xrange_content','submit_xrange_content','edit_cat_xrange_content'];
	var access=[2,3,2,3,2,1,3]; // The minimum access level that turns on each of the above permissions

	var holder=document.getElementById(name+'_sp_container');
	var elements=holder.getElementsByTagName('select');
	var i,j,test,stub=name+'_sp_',name2,x;

	var node=null;
	if (typeof window.site_tree!='undefined') node=window.site_tree.getElementByIdHack(document.getElementById('tree_list').value.split(',')[0]);

	if (value!='-1')
	{
		for (i=0;i<elements.length;i++)
		{
			if (elements[i].name.indexOf('presets')!=-1) continue;

			if (typeof window.site_tree=='undefined') elements[i].disabled=false;
			test=-1;
			name2=elements[i].name.substr(stub.length);
			x=name2.replace(/(high|mid|low)/,'x');

			for (j=0;j<usual_suspects.length;j++)
			{
				if (usual_suspects[j]==x)
				{
					test=(access[j]<=parseInt(value))?1:0;
					break;
				}
			}
			if ((test!=-1) || ((node) && (node.getAttribute('serverid')!='_root')))
			{
				if (elements[i].selectedIndex!=test+1)
				{
					made_change=true;
					if (elements[i].selectedIndex!=test+1)
					{
						made_change=true;
						if (!just_track) elements[i].selectedIndex=test+1; // -1 is at index 0
					}
				}
			}
		}
	} else
	{
		for (i=0;i<elements.length;i++)
		{
			if (elements[i].name.indexOf('presets')!=-1) continue;

			if (typeof window.site_tree=='undefined') elements[i].disabled=true;
			// Any disabled ones will be set to show the default permission rather than the "use-default" one, WHILST all-global is on
			elements[i].selectedIndex=eval(elements[i].name+';')+1; // -1 is at index 0
		}
	}

	if ((!just_track) && (elements.length==2) && (made_change))
	{
		window.fauxmodal_alert('{!permissions:JUST_PRESETS;^}');
	}

	return made_change;
}

function setup_sp_override_selector(name,default_access,sp,title,all_global)
{
	eval('window.'+name+'_sp_'+sp+'='+default_access);
	var select_element=document.getElementById(name+'_sp_'+sp);
	if (all_global)
	{
		// Any disabled ones will be set to show the default permission rather than the "use-default" one, WHILST all-global is on
		select_element.selectedIndex=eval(name+'_sp_'+sp)+1; // -1 is at index 0
		if (typeof window.site_tree=='undefined') select_element.disabled=true;
	}
}

function permission_repeating(button,name)
{
	var old_permission_copying=window.permission_copying;

	var tr=button.parentNode.parentNode;
	var trs=tr.parentNode.getElementsByTagName('tr');

	if (window.permission_copying) // Undo current copying
	{
		document.getElementById('copy_button_'+window.permission_copying).style.textDecoration='none';
		window.permission_copying=null;
		for (var i=0;i<trs.length;i++)
		{
			trs[i].onclick=function () {};
		}
	}

	if (old_permission_copying!=name) // Starting a new copying session
	{
		button.style.textDecoration='blink';
		window.permission_copying=name;
		window.fauxmodal_alert('{!permissions:REPEAT_PERMISSION_NOTICE;^}');
		for (var i=0;i<trs.length;i++)
		{
			if (trs[i]!=tr) trs[i].onclick=copy_permissions_function(trs[i],tr,name);
		}
	}
}

function copy_permissions_function(to_row,from_row,name)
{
	return function()
	{
		var inputs_to=to_row.getElementsByTagName('input');
		var inputs_from=from_row.getElementsByTagName('input');
		for (var i=0;i<inputs_to.length;i++)
		{
			inputs_to[i].checked=inputs_from[i].checked;
		}
		var selects_to=to_row.getElementsByTagName('select');
		var selects_from=from_row.getElementsByTagName('select');
		for (var i=0;i<selects_to.length;i++)
		{
			while (selects_to[i].options.length>0)
			{
				selects_to[i].remove(0);
			}
			for (var j=0;j<selects_from[i].options.length;j++)
			{
				selects_to[i].add(selects_from[i].options[j].cloneNode(true),null);
			}
			selects_to[i].selectedIndex=selects_from[i].selectedIndex;
			selects_to[i].disabled=selects_from[i].disabled;
		}
	}
}

// =========================================
// These are for the Permissions Tree Editor
// =========================================

function update_permission_box(setting)
{
	if (typeof window.site_tree=='undefined') return;

	if (setting.value=='')
	{
		document.getElementById('selection_form_fields').style.display='none';
		document.getElementById('selection_button').disabled=true;
		set_inner_html(document.getElementById('selection_message'),'{!permissions:PERMISSIONS_TREE_EDITOR_NONE_SELECTED;^}');
	} else
	{
		// Go through and set maximum permissions/override from those selected
		var values=setting.value.split(',');
		var id,name,value,i,node,j,group,element,sp,sp_title,known_groups=[],known_sps=[],k,html,new_option,num_sp_default,num_sp,ths,tds,cells,new_cell,row;
		var matrix=document.getElementById('enter_the_matrix').getElementsByTagName('table')[0];
		var num_sp_total=0;
		var is_cms=null;
		for (i=0;i<values.length;i++) // For all items that we are loading permissions for (we usually just do it for one, but sometimes we load whole sets if we are batch setting permissions)
		{
			node=window.site_tree.getElementByIdHack(values[i]);

			if (i==0) // On first iteration we do a cleanup
			{
				// Find usergroups
				for (j=0;j<node.attributes.length;j++)
				{
					if (node.attributes[j].name.substr(0,7)=='g_view_')
					{
						group=node.attributes[j].name.substr(7);
						known_groups.push(group);
					}
				}

				// Blank out everything in the permissions box, remove all SP's
				for (j=0;j<known_groups.length;j++)
				{
					group=known_groups[j];
					element=document.getElementById('access_'+group);
					element.checked=false;
					element=document.getElementById('access_'+group+'_presets');
					if (element.options[0].id!='access_'+group+'_custom_option')
					{
						new_option=document.createElement('option');
						set_inner_html(new_option,'{!permissions:PINTERFACE_LEVEL_CUSTOM;^}');
						new_option.id='access_'+group+'_custom_option';
						new_option.value='';
						element.insertBefore(new_option,element.options[0]);
					}
					element.selectedIndex=0;

					// Delete existing SP nodes
					ths=matrix.getElementsByTagName('th');
					tds=matrix.getElementsByTagName('td');
					cells=[];
					for (k=0;k<ths.length;k++) cells.push(ths[k]);
					for (k=0;k<tds.length;k++) cells.push(tds[k]);
					for (k=0;k<cells.length;k++)
					{
						if ((cells[k].className.match(/(^|\s)sp\_header($|\s)/)) || (cells[k].className.match(/(^|\s)sp\_cell($|\s)/)))
						{
							cells[k].parentNode.removeChild(cells[k]);
						}
					}
				}
			}

			if ((node.getAttribute('serverid').indexOf(':cms_')!=-1) && (is_cms!==false)) is_cms=true; else is_cms=false;

			// Set view access
			var done_group=false;
			for (j=0;j<node.attributes.length;j++)
			{
				if (node.attributes[j].name.substr(0,7)=='g_view_')
				{
					group=node.attributes[j].name.substr(7);
					element=document.getElementById('access_'+group);
					{+START,IF,{$OCF}}
						element.disabled=(node.getAttribute('serverid')==':') && (!done_group);
					{+END}
					element.style.display=((values.length==1) && (node.getAttribute('serverid')=='_root'))?'none':'inline';
					if (!element.checked)
					{
						element.checked=(node.attributes[j].value=='true');
					}
					element=document.getElementById('access_'+group);
					element.style.disabled=((values.length==1) && (node.getAttribute('serverid')=='_root'));
					done_group=true;
				}
			}

			// Create SP nodes
			num_sp=0;
			known_sps=[];
			id=node.getAttribute('id');
			if (typeof window.attributes_full=='undefined') window.attributes_full=[];
			if (typeof window.attributes_full[id]=='undefined') window.attributes_full[id]=node.attributes;
			for (name in window.attributes_full[id])
			{
				value=window.attributes_full[id][name];
				if (name.substr(0,3)=='sp_')
				{
					sp=name.substr(3);
					sp_title=value;
					for (k=0;k<known_groups.length;k++)
					{
						group=known_groups[k];

						element=document.getElementById('access_'+group+'_sp_'+sp);
						if (!element) // We haven't added it yet for one of the resources we're doing permissions for
						{
							if (k==0)
							{
								row=matrix.getElementsByTagName('tr')[0];
								new_cell=row.insertBefore(document.createElement('th'),row.cells[row.cells.length-1]);
								new_cell.className='sp_header';
								set_inner_html(new_cell,'<img class="gd_text" src="'+'{$BASE_URL*;,0}'.replace(/^https?:/,window.location.protocol)+'/data/gd_text.php?color='+window.column_color+'&amp;text='+window.encodeURIComponent(sp_title)+escape_html(keep_stub())+'" title="'+escape_html(sp_title)+'" alt="'+escape_html(sp_title)+'" />');

								num_sp_total++;
							}

							// Manually build up cell
							row=document.getElementById('access_'+group+'_sp_container');
							new_cell=row.insertBefore(document.createElement('td'),row.cells[row.cells.length-1]);
							new_cell.className='form_table_field_input sp_cell';
							set_inner_html(new_cell,'<div class="accessibility_hidden"><label for="access_'+group+'_sp_'+sp+'">{!permissions:OVERRIDE;^}</label></div><select title="'+escape_html(sp_title)+'" onmouseover="if (this.options[this.selectedIndex].value==\'-1\') show_permission_setting(this,event);" id="access_'+group+'_sp_'+sp+'" name="access_'+group+'_sp_'+sp+'"><option selected="selected" value="-1">/</option><option value="0">{!permissions:NO_COMPACT;^}</option><option value="1">{!permissions:YES_COMPACT;^}</option></select>');

							element=document.getElementById('access_'+group+'_sp_'+sp);

							setup_sp_override_selector('access_'+group,'-1',sp,sp_title,false);
						}
						element.options[0].disabled=((values.length==1) && (node.getAttribute('serverid')=='_root'));
					}
					known_sps.push(sp);
					num_sp++;
				}
			}

			// Set SP's for all usergroups (to highest permissions from all usergroups selected)
			for (name in window.attributes_full[id])
			{
				value=window.attributes_full[id][name];
				if (name.substr(0,4)=='gsp_')
				{
					group=name.substr(name.lastIndexOf('_')+1);
					sp=name.substr(4,name.length-group.length-5);
					element=document.getElementById('access_'+group+'_sp_'+sp);
					if (element.selectedIndex<value+1)
						element.selectedIndex=parseInt(value)+1; // -1 corresponds to 0.
				}
			}

			// Blank out any rows of defaults
			for (k=0;k<known_groups.length;k++)
			{
				group=known_groups[k];
				num_sp_default=0;
				for (j=0;j<known_sps.length;j++)
				{
					element=document.getElementById('access_'+group+'_sp_'+known_sps[j]);
					if (element.selectedIndex==0) num_sp_default++;
				}
				if (num_sp_default==num_sp)
				{
					element=document.getElementById('access_'+group+'_presets');
					element.selectedIndex=1;
					cleanup_permission_list('access_'+group);
					for (j=0;j<known_sps.length;j++)
					{
						element=document.getElementById('access_'+group+'_sp_'+known_sps[j]);
						if (typeof window.site_tree=='undefined') element.disabled=true;
					}
				}
			}

			// Hide certain things if we only have view settings here, else show them
			if (num_sp_total==0)
			{
				set_inner_html(matrix.getElementsByTagName('tr')[0].cells[0],'{!GROUP;^}');
				for (k=0;k<known_groups.length;k++)
				{
					document.getElementById('access_'+known_groups[k]+'_presets').style.display='none';
					var button=document.getElementById('access_'+known_groups[k]+'_sp_container').getElementsByTagName('button')[0]
					if (typeof button!='undefined') button.disabled=true;
				}
			} else
			{
				set_inner_html(matrix.getElementsByTagName('tr')[0].cells[0],'<span class="heading_group">{!GROUP;^}</span> <span class="heading_presets">{!permissions:PINTERFACE_PRESETS;^}</span>');
				for (k=0;k<known_groups.length;k++)
				{
					document.getElementById('access_'+known_groups[k]+'_presets').style.display='block';
					var button=document.getElementById('access_'+known_groups[k]+'_sp_container').getElementsByTagName('button')[0]
					if (typeof button!='undefined') button.disabled=false;
				}
			}

			// Test to see what we wouldn't have to make a change to get - and that is what we're set at
			for (k=0;k<known_groups.length;k++)
			{
				group=known_groups[k];
				var list=document.getElementById('access_'+group+'_presets');
				if (!copy_permission_presets('access_'+group,'0',true)) list.selectedIndex=list.options.length-4;
				else if (!copy_permission_presets('access_'+group,'1',true)) list.selectedIndex=list.options.length-3;
				else if (!copy_permission_presets('access_'+group,'2',true)) list.selectedIndex=list.options.length-2;
				else if (!copy_permission_presets('access_'+group,'3',true)) list.selectedIndex=list.options.length-1;
			}
		}

		// Set correct admin colspan
		for (var i=0;i<matrix.rows.length;i++)
		{
			if (matrix.rows[i].cells.length==3) {
				matrix.rows[i].cells[2].colSpan=num_sp_total+1;
			}
		}

		document.getElementById('selection_form_fields').style.display='block';
		document.getElementById('selection_button').disabled=false;
		set_inner_html(document.getElementById('selection_message'),(values.length<=1)?'{!permissions:PERMISSIONS_TREE_EDITOR_ONE_SELECTED;^}':'{!permissions:PERMISSIONS_TREE_EDITOR_MULTI_SELECTED;^}');
	}
}

function set_permissions(setting)
{
	if (typeof window.site_tree=='undefined') return;
	if (typeof window.do_ajax_request=='undefined') return;

	if (setting.value=='')
	{
		return; // Shouldn't get here
	} else
	{
		// Go through and set maximum permissions/override from those selected
		var values=setting.value.split(',');
		var id,i,node,j,group,element,sp,known_groups=[],k,serverid,set_request='',set_request_b,new_value;
		for (i=0;i<values.length;i++)
		{
			node=window.site_tree.getElementByIdHack(values[i]);
			serverid=node.getAttribute('serverid');

			// Find usergroups
			for (j=0;j<node.attributes.length;j++)
			{
				if (node.attributes[j].name.substr(0,7)=='g_view_')
				{
					group=node.attributes[j].name.substr(7);
					known_groups.push(group);
				}
			}

			set_request_b='';

			for (j=0;j<known_groups.length;j++)
			{
				group=known_groups[j];

				// Set view access
				element=document.getElementById('access_'+group);
				new_value=element.checked?'true':'false';
				if (new_value!=node.getAttribute('g_view_'+group))
				{
					node.setAttribute('g_view_'+group,new_value);
					set_request_b=set_request_b+'&'+i+'g_view_'+group+'='+((new_value=='true')?1:0);
				}
			}

			// Set SP's for all usergroups
			id=node.getAttribute('id');
			if (typeof window.attributes_full=='undefined') window.attributes_full=[];
			if (typeof window.attributes_full[id]=='undefined') window.attributes_full[id]=node.attributes;
			for (var name in window.attributes_full[id])
			{
				var value=window.attributes_full[id][name];
				if (name.substr(0,3)=='sp_')
				{
					for (j=0;j<known_groups.length;j++)
					{
						group=known_groups[j];
						sp=name.substr(3);
						value=window.attributes_full[id]['gsp_'+sp+'_'+group];
						if (!value) value=-1;
						element=document.getElementById('access_'+group+'_sp_'+sp);
						if (element)
						{
							new_value=element.selectedIndex-1;
							if (new_value!=value)
							{
								window.attributes_full[id]['gsp_'+sp+'_'+group]=new_value;
								set_request_b=set_request_b+'&'+i+'gsp_'+sp+'_'+group+'='+new_value;
							}
						}
					}
				}

				// Update UI indicators
				set_inner_html(document.getElementById('tree_listextra_'+id),permissions_img_func_1(node,id)+permissions_img_func_2(node,id));
			}

			if (set_request_b!='') set_request=set_request+'&map_'+i+'='+window.encodeURIComponent(serverid)+set_request_b;
		}

		// Send AJAX request
		if (set_request!='') do_ajax_request('{$BASE_URL_NOHTTP;}/data/site_tree.php?set_perms=1'+keep_stub(),null,set_request);
	}
	window.fauxmodal_alert('{!permissions:PERMISSIONS_TREE_EDITOR_SAVED;^}');
}

function permissions_img_func_1(node,id)
{
	var temp=permissions_img_func_1_b(node,id);
	var url=temp[0];
	var title=temp[1];
	return '<img class="vertical_alignment perm_icon" src="'+url+'" alt="'+title+'" title="'+title+'" />&nbsp;';
}

function permissions_img_func_1_b(node,id)
{
	var group=document.getElementById('group').value;

	if (typeof id=='undefined') id=node.getAttribute('id');

	if (typeof window.attributes_full=='undefined') window.attributes_full=[];
	if (typeof window.attributes_full[id]=='undefined') window.attributes_full[id]=node.attributes;

	if (((window.attributes_full[id]['gsp_delete_highrange_content_'+group]) && (window.attributes_full[id]['gsp_delete_highrange_content_'+group]=='1')) ||
		 ((window.attributes_full[id]['gsp_delete_midrange_content_'+group]) && (window.attributes_full[id]['gsp_delete_midrange_content_'+group]=='1')) ||
		 ((window.attributes_full[id]['gsp_delete_lowrange_content_'+group]) && (window.attributes_full[id]['gsp_delete_lowrange_content_'+group]=='1')))
			return Array('{$IMG;,permlevels/3}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_LEVEL_3;^}');
	else
	if (((window.attributes_full[id]['gsp_bypass_validation_highrange_content_'+group]) && (window.attributes_full[id]['gsp_bypass_validation_highrange_content_'+group]=='1')) ||
		 ((window.attributes_full[id]['gsp_bypass_validation_midrange_content_'+group]) && (window.attributes_full[id]['gsp_bypass_validation_midrange_content_'+group]=='1')) ||
		 ((window.attributes_full[id]['gsp_bypass_validation_lowrange_content_'+group]) && (window.attributes_full[id]['gsp_bypass_validation_lowrange_content_'+group]=='1')))
			return Array('{$IMG;,permlevels/2}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_LEVEL_2;^}');
	else
	if (((window.attributes_full[id]['gsp_submit_highrange_content_'+group]) && (window.attributes_full[id]['gsp_submit_highrange_content_'+group]=='1')) ||
		 ((window.attributes_full[id]['gsp_submit_midrange_content_'+group]) && (window.attributes_full[id]['gsp_submit_midrange_content_'+group]=='1')) ||
		 ((window.attributes_full[id]['gsp_submit_lowrange_content_'+group]) && (window.attributes_full[id]['gsp_submit_lowrange_content_'+group]=='1')))
			return Array('{$IMG;,permlevels/1}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_LEVEL_1;^}');
	else
	if (window.attributes_full[id]['inherits_something'])
			return Array('{$IMG;,permlevels/inherit}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_LEVEL_GLOBAL;^}');
	else
	if (window.attributes_full[id]['no_sps']) return Array('{$IMG;,blank}'.replace(/^https?:/,window.location.protocol),'');

	return Array('{$IMG;,permlevels/0}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_LEVEL_0;^}');
}

function permissions_img_func_2(node,id)
{
	var temp=permissions_img_func_2_b(node,id);
	var url=temp[0];
	var title=temp[1];
	return '<img class="vertical_alignment" src="'+url+'" alt="'+title+'" title="'+title+'" />';
}

function permissions_img_func_2_b(node,id)
{
	if (typeof id=='undefined') id=node.getAttribute('id');

	var group=document.getElementById('group').value;

	if (node.getAttribute('g_view_'+group)=='true')
		return Array('{$IMG;,led_on}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_VIEW;^}');
	return Array('{$IMG;,led_off}'.replace(/^https?:/,window.location.protocol),'{!permissions:PINTERFACE_VIEW_NO;^}');
}

function update_group_displayer(setting)
{
	if (typeof window.site_tree=='undefined') return;

	set_inner_html(document.getElementById('group_name'),escape_html(window.usergroup_titles[setting.options[setting.selectedIndex].value]));
	var html=document.getElementById('tree_list__root_tree_list');
	set_inner_html(html,'');
	window.site_tree.render_tree(window.site_tree.tree_list_data,html);
}

