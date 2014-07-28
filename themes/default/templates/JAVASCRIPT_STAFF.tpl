"use strict";

function script_load_stuff_staff()
{
	// Navigation loading screen
	{+START,IF,{$CONFIG_OPTION,enable_animations}}
		if ((window.parent==window) && ((window.location+'').indexOf('js_cache=1')==-1) && (((window.location+'').indexOf('/cms/')!=-1) || ((window.location+'').indexOf('/adminzone/')!=-1)))
			add_event_listener_abstract(window,'beforeunload',function() { staff_unload_action(); } );
	{+END}

	// Theme image editing hovers
	var map,elements,i,j;
	for (i=0;i<document.images.length;i++)
	{
		map=document.images[i].getAttribute('usemap');
		if (map)
		{
			elements=document.getElementsByTagName('area');
			for (j=0;j<elements.length;j++)
			{
				if (!elements[j].onclick)
				{
					elements[j].src=document.images[i].src;
					add_event_listener_abstract(elements[j],'click',handle_image_click,false);
				}
			}
		}
		if (document.images[i].className.indexOf('no_theme_img_click')==-1)
		{
			add_event_listener_abstract(document.images[i],'mouseover',handle_image_mouse_over,false);
			add_event_listener_abstract(document.images[i],'mouseout',handle_image_mouse_out,false);
			add_event_listener_abstract(document.images[i],'click',handle_image_click,false);
		}
	}
	var inputs=document.getElementsByTagName('input');
	for (i=0;i<inputs.length;i++)
	{
		if ((inputs[i].className.indexOf('no_theme_img_click')==-1) && (inputs[i].type=='image'))
		{
			add_event_listener_abstract(inputs[i],'mouseover',handle_image_mouse_over,false);
			add_event_listener_abstract(inputs[i],'mouseout',handle_image_mouse_out,false);
			add_event_listener_abstract(inputs[i],'click',handle_image_click,false);
		}
	}
	var all_e=document.getElementsByTagName('*');
	var bg;
	for (i=0;i<all_e.length;i++)
	{
		bg=abstract_get_computed_style(all_e[i],'background-image');
		if ((all_e[i].className.indexOf('no_theme_img_click')==-1) && (bg!='none') && (bg.indexOf('url')!=-1))
		{
			add_event_listener_abstract(all_e[i],'mouseover',handle_image_mouse_over,false);
			add_event_listener_abstract(all_e[i],'mouseout',handle_image_mouse_out,false);
			add_event_listener_abstract(all_e[i],'click',handle_image_click,false);
		}
	}

	// Local cacheing for improved perceived performance
	var has_local_storage=false;
	try
	{
		has_local_storage=(typeof window.localStorage!='undefined');
	}
	catch (e) { };
	if ((has_local_storage) && ('{$VALUE_OPTION;,advanced_admin_cache}'=='1') && (!window.unloaded) && (!browser_matches('gecko')/*Far too slow*/) && (!browser_matches('ie')/*Big problems loading script with sanity in document.write*/))
	{
		var html=get_inner_html(document.documentElement,true);
		if ((html.length<1024*256) && (!document.getElementById('login_username')) && (document.title!='Preloading')) // Do not save more than 256kb
		{
			// Saving
			local_page_caching(html);
		}

		// Alter any <a> links so that local ones to cached URLs are handled nicely
		promote_page_caching();
	}

	// Contextual CSS editor
	contextual_css_edit();
	window.setTimeout(contextual_css_edit,2000); // For frames

	// Thumbnail tooltips
	var url_patterns=[
		{+START,LOOP,URL_PATTERNS}
			{+START,IF,{$NEQ,{_loop_key},0}},{+END}
			{
				pattern: /^{$REPLACE,_WILD,([^&]*),{$REPLACE,_WILD\/,([^&]*)\/?,{$REPLACE,?,\?,{$REPLACE,/,\/,{PATTERN}}}}}/,
				hook: '{HOOK}'
			}
		{+END}
	];
	var cells=document.getElementsByTagName('td');
	var links=[];
	if (window.location.href.indexOf('/cms/')!=-1)
	{
		for (var i=0;i<cells.length;i++)
		{
			var as=cells[i].getElementsByTagName('a');
			for (var j=0;j<as.length;j++)
			{
				links.push(as[j]);
			}
		}
	}
	for (var i=0;i<links.length;i++)
	{
		for (var j=0;j<url_patterns.length;j++)
		{
			var url_pattern=url_patterns[j].pattern,hook=url_patterns[j].hook;

			if ((links[i].href) && (!links[i].onmouseover))
			{
				var id=links[i].href.match(url_pattern);
				if (id)
				{
					var myfunc=function(hook,id,link)
					{
						add_event_listener_abstract(link,'mouseout',function(event) {
							if (typeof event=='undefined') var event=window.event;
							if (typeof window.deactivate_tooltip!='undefined') deactivate_tooltip(link,event);
						} );
						add_event_listener_abstract(link,'mousemove',function(event) {
							if (typeof event=='undefined') var event=window.event;
							if (typeof window.activate_tooltip!='undefined') reposition_tooltip(link,event,false,false,null,true);
						} );
						add_event_listener_abstract(link,'mouseover',function(event) {
							if (typeof event=='undefined') var event=window.event;

							if (typeof window.activate_tooltip!='undefined')
							{
								var id_chopped=id[1];
								if (typeof id[2]!='undefined') id_chopped+=':'+id[2];
								var comcode='[block="'+hook+'" id="'+window.decodeURIComponent(id_chopped)+'" no_links="1"]main_content[/block]';
								if (typeof link.rendered_tooltip=='undefined')
								{
									link.is_over=true;

									var request=do_ajax_request(maintain_theme_in_link('{$FIND_SCRIPT_NOHTTP;,comcode_convert}?css=1&javascript=1&box_title={!PREVIEW;&}'+keep_stub(false)),function(ajax_result_frame,ajax_result) {
										if (ajax_result)
										{
											link.rendered_tooltip=get_inner_html(ajax_result);
										}
										if (typeof link.rendered_tooltip!='undefined')
										{
											if (link.is_over)
												activate_tooltip(link,event,link.rendered_tooltip,'400px',null,null,false,false,false,true);
										}
									},'data='+window.encodeURIComponent(comcode));
								} else
								{
									activate_tooltip(link,event,link.rendered_tooltip,'400px',null,null,false,false,false,true);
								}
							}
						} );
					};
					myfunc(hook,id,links[i]);
				}
			}
		}
	}
}

function local_page_caching(html)
{
	var loc=(window.location+'').replace(/&js_cache=1&/,'&').replace(/&js_cache=1$/,'').replace(/\?js_cache=1&/,'?').replace(/\?js_cache=1$/,'');
	var now=new Date().getTime();
	var count=0;
	try
	{
		if ((typeof localStorage[loc]!='undefined') && (localStorage[loc]))
			count=JSON.parse(localStorage[loc])[1];
		localStorage[loc]=JSON.stringify([html,count+1,now,window.page_data_hash]);
	}
	catch (e) // Do not want privacy settings or whatever causing visible JS errors
	{
		if ((e.name=='QUOTA_EXCEEDED_ERR') && (localStorage.length!=0))
		{
			// Need to free some space, delete the oldest
			var best_date_so_far=null,best_id=null,keyat,parsed;
			for (var i=0;i<localStorage.length;i++)
			{
				try
				{
					keyat=localStorage.key(i);
					parsed=JSON.parse(localStorage[keyat]);
					if ((best_date_so_far==null) || (parsed[2]<best_date_so_far))
					{
						best_date_so_far=parsed[2];
						best_id=keyat;
					}
				} catch (e) {}; // Maybe not JSON
			}

			if (best_id)
			{
				localStorage.removeItem(best_id);

				// Try again
				local_page_caching(html);
			}
		}
	};
}

function contextual_css_edit()
{
	var spt=document.getElementById('special_page_type'),css_option,i,l,sheet;
	if (!spt) return;
	var possibilities=find_css_sheets(window);
	for (i=0;i<possibilities.length;i++)
	{
		sheet=possibilities[i];
		if (!document.getElementById('opt_for_sheet_'+sheet))
		{
			css_option=document.createElement('option');
			set_inner_html(css_option,((sheet=='global')?'{!CONTEXTUAL_CSS_EDITING_GLOBAL;}':'{!CONTEXTUAL_CSS_EDITING;}').replace('\{1}',escape_html(sheet+'.css')));
			css_option.value=sheet+'.css';
			css_option.id='opt_for_sheet_'+sheet;
			if (find_active_selectors(sheet,window).length!=0)
				spt.options[2].parentNode.insertBefore(css_option,spt.options[2]);
		}
	}
}

function find_css_sheets(win)
{
	var possibilities=[],sheet,i,j,k,ok;
	try
	{
		if (typeof window.ocp_theme=='undefined') window.ocp_theme='{$THEME;}';
		if (typeof window.ocp_lang=='undefined') window.ocp_lang='{$LANG;}';
		if ((typeof win.document.querySelectorAll!='undefined') && (typeof window.ocp_lang!='undefined') && (typeof window.ocp_theme!='undefined'))
		{
			for (i=0;i<win.document.styleSheets.length;i++)
			{
				try
				{
					if (!win.document.styleSheets[i].href)
					{
						sheet='no_cache';
						possibilities.push(sheet);
					} else
					{
						var l=win.document.styleSheets[i].href.lastIndexOf('/templates_cached/'+window.ocp_lang+'/');
						if ((l!=-1) && (win.document.styleSheets[i].href.indexOf('merged__')==-1))
						{
							sheet=win.document.styleSheets[i].href.substring(l+('/templates_cached/'+window.ocp_lang+'/').length,win.document.styleSheets[i].href.length).replace('_non_minified','').replace('_ssl','').replace('_mobile','').replace(/\?\d+/,'').replace('.css','');
							possibilities.push(sheet);
						}
					}
				}
				catch (e) {}
			}

			for (i=0;i<win.frames.length;i++)
			{
				if (win.frames[i]) // If test needed for opera, as window.frames can get out-of-date
				{
					var result2=find_css_sheets(win.frames[i]);
					for (j=0;j<result2.length;j++)
					{
						ok=true;
						for (k=0;k<possibilities.length;k++)
						{
							if (possibilities[k]==result2[j]) ok=false;
						}
						if (ok) possibilities.push(result2[j]);
					}
				}
			}
		}
	}
	catch (e) {}

	return possibilities;
}

function find_active_selectors(match,win)
{
	var test,selector,selectors=[],classes,i,j,result2;
	try
	{
		for (i=0;i<win.document.styleSheets.length;i++)
		{
			try
			{
				if ((!match) || (!win.document.styleSheets[i].href && ((win.document.styleSheets[i].ownerNode && win.document.styleSheets[i].ownerNode.id=='style_for_'+match) || (!win.document.styleSheets[i].ownerNode && win.document.styleSheets[i].id=='style_for_'+match))) || (win.document.styleSheets[i].href && win.document.styleSheets[i].href.indexOf('/'+match)!=-1))
				{
					classes=win.document.styleSheets[i].rules || win.document.styleSheets[i].cssRules
					for (j=0;j<classes.length;j++)
					{
						selector=classes[j].selectorText;
						test=win.document.querySelectorAll(selector);
						if (test.length!=0) selectors.push(classes[j]);
					}
				}
			}
			catch (e) { };
		}
	}
	catch (e) { };

	for (i=0;i<win.frames.length;i++)
	{
		if (win.frames[i]) // If test needed for opera, as window.frames can get out-of-date
		{
			result2=find_active_selectors(match,win.frames[i]);
			for (var j=0;j<result2.length;j++) selectors.push(result2[j]);
		}
	}

	return selectors;
}

function promote_page_caching()
{
	for (var i=0;i<document.links.length;i++)
	{
		if ((typeof document.links[i]!='undefined') && (typeof localStorage[document.links[i].href]!='undefined') && (localStorage[document.links[i].href]))
		{
			document.links[i].href+=((document.links[i].href.indexOf('?')==-1)?'?':'&')+'js_cache=1';
		}
	}
}

function handle_image_mouse_over(event)
{
	if (typeof window.ocp_theme=='undefined') window.ocp_theme='{$THEME;}';
	if (typeof window.ocp_lang=='undefined') window.ocp_lang='{$LANG;}';
	if (typeof window.ocp_theme=='undefined') return;

	var target=event.target || event.srcElement;
	if (target.previousSibling && (typeof target.previousSibling.className!='undefined') && (typeof target.previousSibling.className.indexOf!='undefined') && (target.previousSibling.className.indexOf('magic_image_edit_link')!=-1)) return;
	if (find_width(target)<130) return;

	var src=(typeof target.src=='undefined')?abstract_get_computed_style(target,'background-image'):target.src;
	if ((typeof target.src=='undefined') && (!event.ctrlKey) && (!event.metaKey) && (!event.altKey)) return; // Needs ctrl key for background images
	if (src.indexOf('/themes/')==-1) return;
	if (window.location.href.indexOf('admin_themes')!=-1) return;

	{+START,IF,{$CONFIG_OPTION,enable_theme_img_buttons}}
		// Remove other edit links
		var old=get_elements_by_class_name(document,'magic_image_edit_link');
		for (var i=old.length-1;i>=0;i--)
		{
			old[i].parentNode.removeChild(old[i]);
		}

		// Add edit button
		var ml=document.createElement('input');
		ml.onclick=function(event) { handle_image_click(event,target,true); };
		ml.type='button';
		ml.id='editimg_'+target.id;
		ml.value='{!themes:EDIT_THEME_IMAGE;}';
		ml.className='magic_image_edit_link button_micro';
		ml.style.position='absolute';
		ml.style.left=find_pos_x(target)+'px';
		ml.style.top=find_pos_y(target)+'px';
		ml.style.zIndex=3000;
		ml.style.display='none';
		target.parentNode.insertBefore(ml,target);

		if (target.mo_link)
			window.clearTimeout(target.mo_link);
		target.mo_link=window.setTimeout(function() {
			if (ml) ml.style.display='block';
		} , 2000);
	{+END}

	window.old_status_img=window.status;
	window.status='{!SPECIAL_CLICK_TO_EDIT;}';
}

function handle_image_mouse_out(event)
{
	var target=event.target || event.srcElement;

	{+START,IF,{$CONFIG_OPTION,enable_theme_img_buttons}}
		if (target.previousSibling && (typeof target.previousSibling.className!='undefined') && (typeof target.previousSibling.className.indexOf!='undefined') && (target.previousSibling.className.indexOf('magic_image_edit_link')!=-1))
		{
			if ((typeof target.mo_link!='undefined') && (target.mo_link)) // Clear timed display of new edit button
			{
				window.clearTimeout(target.mo_link);
				target.mo_link=null;
			}

			// Time removal of edit button
			if (target.mo_link)
				window.clearTimeout(target.mo_link);
			target.mo_link=window.setTimeout(function() {
				if ((typeof target.edit_window=='undefined') || (!target.edit_window) || (target.edit_window.closed))
				{
					if (target.previousSibling && (typeof target.previousSibling.className!='undefined') && (typeof target.previousSibling.className.indexOf!='undefined') && (target.previousSibling.className.indexOf('magic_image_edit_link')!=-1))
						target.parentNode.removeChild(target.previousSibling);
				}
			} , 3000);
		}
	{+END}

	if (typeof window.old_status_img=='undefined') window.old_status_img='';
	window.status=window.old_status_img;
}

function handle_image_click(event,ob,force)
{
	if (typeof event=='undefined') var event=window.event;
	if ((typeof ob=='undefined') || (!ob)) var ob=this;

	var src=ob.origsrc?ob.origsrc:((typeof ob.src=='undefined')?abstract_get_computed_style(ob,'background-image').replace(/.*url\(['"]?(.*)['"]?\).*/,'$1'):ob.src);
	if ((src) && ((force) || (magic_keypress(event))))
	{
		// Bubbling needs to be stopped because shift+click will open a new window on some lower event handler (in firefox anyway)
		cancel_bubbling(event);

		if (typeof event.preventDefault!='undefined') event.preventDefault();

		if (src.indexOf('{$BASE_URL_NOHTTP;}/themes/')!=-1)
			ob.edit_window=window.open('{$BASE_URL;,0}/adminzone/index.php?page=admin_themes&type=edit_image&lang='+window.encodeURIComponent(window.ocp_lang)+'&theme='+window.encodeURIComponent(window.ocp_theme)+'&url='+window.encodeURIComponent(src.replace('{$BASE_URL;,0}/',''))+keep_stub(),'edit_theme_image_'+ob.id);
		else window.fauxmodal_alert('{!NOT_THEME_IMAGE;^}');

		return false;
	}

	return true;
}

function load_software_chat(event)
{
	cancel_bubbling(event);
	if (typeof event.preventDefault!='undefined') event.preventDefault();

	var html=' \
		<div class="software_chat"> \
			<h2>{!OCP_COMMUNITY_HELP}</h2> \
			<ul class="spaced_list">{!SOFTWARE_CHAT_EXTRA;}</ul> \
			<p class="associated_link associated_links_block_group"><a title="{!SOFTWARE_CHAT_STANDALONE} {!LINK_NEW_WINDOW}" target="_blank" href="http://chat.zoho.com/guest.sas?k=%7B%22g%22%3A%22Anonymous%22%2C%22c%22%3A%2299b05040669de8c406b674d2366ff9b0401fe3523f0db988%22%2C%22o%22%3A%22e89335657fd675dcfb8e555ea0615984%22'+'%7D'+'&amp;participants=true">{!SOFTWARE_CHAT_STANDALONE}</a> <a href="#" onclick="return load_software_chat(event);">{!HIDE}</a></p> \
		</div> \
		<iframe class="software_chat_iframe" frameborder="0" border="0" src="http://chat.zoho.com/shout.sas?k=%7B%22g%22%3A%22Anonymous%22%2C%22c%22%3A%2299b05040669de8c406b674d2366ff9b0401fe3523f0db988%22%2C%22o%22%3A%22e89335657fd675dcfb8e555ea0615984%22'+'%7D'+'&amp;chaturl=ocPortal%20chat&amp;V=000000-70a9e1-eff4f9-70a9e1-ocPortal%20chat&amp;user={$SITE_NAME.*}'+((typeof window.ocp_username!='undefined')?window.encodeURIComponent('/'+window.ocp_username):'')+'&amp;participants=true"></iframe> \
	'.replace(/\\{1\\}/,escape_html((window.location+'').replace(get_base_url(),'http://baseurl')));

	var box=document.getElementById('software_chat_box');
	if (box)
	{
		box.parentNode.removeChild(box);

		set_opacity(document.getElementById('software_chat_img'),1.0);
	} else
	{
		box=document.createElement('div');

		box.id='software_chat_box';
		box.style.width='750px';
		box.style.background='#EEE';
		box.style.color='#000';
		box.style.padding='5px';
		box.style.border='3px solid #AAA';
		box.style.height='420px';
		box.style.position='absolute';
		box.style.zIndex=2000;
		box.style.left=(get_window_width()-650)/2+'px';
		var top_temp=100;
		box.style.top=top_temp+'px';

		set_inner_html(box,html);
		document.body.appendChild(box);

		smooth_scroll(0);

		set_opacity(document.getElementById('software_chat_img'),0.5);

		//window.setTimeout( function() { try { window.frames[window.frames.length-1].documentElement.getElementById('texteditor').focus(); } catch (e) {} } ), 5000);		Unfortunately cannot do, JS security context issue
	}

	return false;
}

function staff_actions_select(ob)
{
	var form;

	var is_form_submit=(ob.nodeName.toLowerCase()=='form');
	if (is_form_submit)
	{
		form=ob;
		ob=form.elements['special_page_type'];
	} else
	{
		form=ob.form;
	}

	var val=ob.options[ob.selectedIndex].value;
	if (val!='view')
	{
		if (typeof form.elements['cache']!='undefined')
			form.elements['cache'].value=(val.substring(val.length-4,val.length)=='.css')?'1':'0';
		var test=window.open('','ocp_dev_tools'+Math.floor(Math.random()*10000),'width=1000,height=700,scrollbars=yes');
		if (test) form.setAttribute('target',test.name);
		if (!is_form_submit)
			form.submit();
	}
}

function set_task_hiding(hide_done)
{
	new Image().src='{$IMG;,checklist/cross2}';
	new Image().src='{$IMG;,checklist/toggleicon2}';

	var checklist_rows=get_elements_by_class_name(document,'checklist_row'),row_imgs,src;
	for (var i=0;i<checklist_rows.length;i++)
	{
		row_imgs=checklist_rows[i].getElementsByTagName('img');
		if (hide_done)
		{
			src=row_imgs[row_imgs.length-1].getAttribute('src');
			if (row_imgs[row_imgs.length-1].origsrc) src=row_imgs[row_imgs.length-1].origsrc;
			if (src && src.indexOf('checklist1')!=-1)
			{
				checklist_rows[i].style.display='none';
				checklist_rows[i].className+=' task_hidden';
			} else
			{
				checklist_rows[i].className=checklist_rows[i].className.replace(/ task_hidden/g,'');
			}
		} else
		{
			if ((typeof window.fade_transition!='undefined') && (checklist_rows[i].style.display=='none'))
			{
				set_opacity(checklist_rows[i],0.0);
				fade_transition(checklist_rows[i],100,30,4);
			}
			checklist_rows[i].style.display='block';
			checklist_rows[i].className=checklist_rows[i].className.replace(/ task_hidden/g,'');
		}
	}

	if (hide_done)
	{
		document.getElementById('checklist_show_all_link').style.display='block';
		document.getElementById('checklist_hide_done_link').style.display='none';
	} else
	{
		document.getElementById('checklist_show_all_link').style.display='none';
		document.getElementById('checklist_hide_done_link').style.display='block';
	}
}

function submit_custom_task(form)
{
	var new_task=load_snippet('checklist_task_manage&type=add&recurevery='+window.encodeURIComponent(form.elements['recurevery'].value)+'&recurinterval='+window.encodeURIComponent(form.elements['recur'].value)+'&tasktitle='+window.encodeURIComponent(form.elements['new_task'].value));

	form.elements['recurevery'].value='';
	form.elements['recur'].value='';
	form.elements['new_task'].value='';

	set_inner_html(document.getElementById('custom_tasks_go_here'),new_task,true);

	return false;
}

function delete_custom_task(ob,id)
{
	load_snippet('checklist_task_manage&type=delete&id='+window.encodeURIComponent(id));
	ob.parentNode.parentNode.parentNode.style.display='none';

	return false;
}

function mark_done(ob,id)
{
	load_snippet('checklist_task_manage&type=mark_done&id='+window.encodeURIComponent(id));
	ob.onclick=function() { mark_undone(ob,id); };
	ob.getElementsByTagName('img')[1].setAttribute('src','{$IMG;,checklist/checklist1}');
}

function mark_undone(ob,id)
{
	load_snippet('checklist_task_manage&type=mark_undone&id='+window.encodeURIComponent(id));
	ob.onclick=function() { mark_done(ob,id); };
	ob.getElementsByTagName('img')[1].setAttribute('src','{$IMG;,checklist/not_completed}');
}

function staff_block_flip_over(name)
{
	var show=document.getElementById(name+'_form');
	var hide=document.getElementById(name);

	set_display_with_aria(show,(hide.style.display!='none')?'block':'none');
	set_display_with_aria(hide,(hide.style.display!='none')?'none':'block');

	return false;
}
