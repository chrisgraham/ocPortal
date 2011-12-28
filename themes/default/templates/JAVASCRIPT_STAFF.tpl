"use strict";

function scriptLoadStuffStaff()
{
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
					addEventListenerAbstract(elements[j],'click',handleImageClick,false);
				}
			}
		}
		if (document.images[i].className.indexOf('no_theme_img_click')==-1)
		{
			addEventListenerAbstract(document.images[i],'mouseover',handleImageMouseOver,false);
			addEventListenerAbstract(document.images[i],'mouseout',handleImageMouseOut,false);
			addEventListenerAbstract(document.images[i],'click',handleImageClick,false);
		}
	}
	var inputs=document.getElementsByTagName('input');
	for (i=0;i<inputs.length;i++)
	{
		if ((inputs[i].className.indexOf('no_theme_img_click')==-1) && (inputs[i].type=='image'))
		{
			addEventListenerAbstract(inputs[i],'mouseover',handleImageMouseOver,false);
			addEventListenerAbstract(inputs[i],'mouseout',handleImageMouseOut,false);
			addEventListenerAbstract(inputs[i],'click',handleImageClick,false);
		}
	}
	
	// Local cacheing for improved perceived performance
	var has_local_storage=false;
	try
	{
		has_local_storage=(typeof window.localStorage!='undefined');
	}
	catch (e) { };
	if ((has_local_storage) && ('{$CONFIG_OPTION;,advanced_admin_cache}'=='1') && (!window.unloaded) && (!browser_matches('gecko')/*Far too slow*/) && (!browser_matches('ie')/*Big problems loading script with sanity in document.write*/))
	{
		var html=getInnerHTML(document.documentElement,true);
		if ((html.length<1024*256) && (!document.getElementById('login_username')) && (document.title!='Preloading')) // Do not save more than 256kb
		{
			// Saving
			localPageCaching(html);
		}

		// Alter any <a> links so that local ones to cached URLs are handled nicely
		promotePageCaching();
	}

	// Contextual CSS editor
	contextualCSSEdit();
	window.setTimeout(contextualCSSEdit,2000); // For frames

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
	{+START,IF,{$ADDON_INSTALLED,awards}}
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
							addEventListenerAbstract(link,'mouseout',function(event) {
								if (!event) event=window.event;
								if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(link,event);
							} );
							addEventListenerAbstract(link,'mousemove',function(event) {
								if (!event) event=window.event;
								if (typeof window.activateTooltip!='undefined') repositionTooltip(link,event,false,false,null,true);
							} );
							addEventListenerAbstract(link,'mouseover',function(event) {
								if (!event) event=window.event;

								if (typeof window.activateTooltip!='undefined')
								{
									var id_chopped=id[1];
									if (typeof id[2]!='undefined') id_chopped+=':'+id[2];
									var comcode='[block="'+hook+'" id="'+window.decodeURIComponent(id_chopped)+'" no_links="1" title=""]main_content[/block]';
									if (typeof link.rendered_tooltip=='undefined')
									{
										link.is_over=true;

										var request=load_XML_doc(maintain_theme_in_link('{$FIND_SCRIPT_NOHTTP;,comcode_convert}?css=1&javascript=1&box_title={!PREVIEW;&}'+keep_stub(false)),function(ajax_result_frame,ajax_result) {
											if (ajax_result)
											{
												link.rendered_tooltip=getInnerHTML(ajax_result);
											}
											if (typeof link.rendered_tooltip!='undefined')
											{
												if (link.is_over)
													activateTooltip(link,event,link.rendered_tooltip,'400px',null,null,false,false,false,true);
											}
										},'data='+window.encodeURIComponent(comcode));
									} else
									{
										activateTooltip(link,event,link.rendered_tooltip,'400px',null,null,false,false,false,true);
									}
								}
							} );
						};
						myfunc(hook,id,links[i]);
					}
				}
			}
		}
	{+END}
}

function localPageCaching(html)
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
				localPageCaching(html);
			}
		}
	};
}

function contextualCSSEdit()
{
	var spt=document.getElementById('special_page_type'),css_option,i,l,sheet;
	if (!spt) return;
	var possibilities=findCSSSheets(window);
	for (i=0;i<possibilities.length;i++)
	{
		sheet=possibilities[i];
		if (!document.getElementById('opt_for_sheet_'+sheet))
		{
			css_option=document.createElement('option');
			setInnerHTML(css_option,((sheet=='global')?'{!CONTEXTUAL_CSS_EDITING_GLOBAL;}':'{!CONTEXTUAL_CSS_EDITING;}').replace('\{1}',escape_html(sheet+'.css')));
			css_option.value=sheet+'.css';
			css_option.id='opt_for_sheet_'+sheet;
			if (findActiveSelectors(sheet,window).length!=0)
				spt.insertBefore(css_option,spt.options[2]);
		}
	}
}

function findCSSSheets(win)
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
						l=win.document.styleSheets[i].href.lastIndexOf('/templates_cached/'+ocp_lang+'/');
						if (l!=-1)
						{
							sheet=win.document.styleSheets[i].href.substring(l+('/templates_cached/'+ocp_lang+'/').length,win.document.styleSheets[i].href.length).replace('_non_minified','').replace('_ssl','').replace('_mobile','').replace('.css','');
							possibilities.push(sheet);
						}
					}
				}
				catch (e) {}
			}

			for (i=0;i<win.frames.length;i++)
			{
				result2=findCSSSheets(win.frames[i]);
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
	catch (e) {}
	return possibilities;
}

function findActiveSelectors(match,win)
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
		result2=findActiveSelectors(match,win.frames[i]);
		for (var j=0;j<result2.length;j++) selectors.push(result2[j]);
	}

	return selectors;
}

function promotePageCaching()
{
	for (var i=0;i<document.links.length;i++)
	{
		if ((typeof document.links[i]!='undefined') && (typeof localStorage[document.links[i].href]!='undefined') && (localStorage[document.links[i].href]))
		{
			document.links[i].href+=((document.links[i].href.indexOf('?')==-1)?'?':'&')+'js_cache=1';
		}
	}
}

function handleImageMouseOver(event)
{
	if (typeof window.ocp_theme=='undefined') window.ocp_theme='{$THEME;}';
	if (typeof window.ocp_lang=='undefined') window.ocp_lang='{$LANG;}';
	if (typeof window.ocp_theme=='undefined') return;

	var target=event.target || event.srcElement;
	if (target.previousSibling && target.previousSibling.className=='magic_image_edit_link') return;
	if (findWidth(target)<100) return;
	if (target.src.indexOf('/themes/')==-1) return;
	if (window.location.href.indexOf('admin_themes')!=-1) return;

	{+START,IF,{$NOT,{$VALUE_OPTION,disable_theme_img_buttons}}}
		if ((typeof target.mo_link_out!='undefined') && (target.mo_link_out))
		{
			window.clearInterval(target.mo_link_out);
			target.mo_link_out=null;
		}
		target.mo_link=window.setInterval(function() {
			if (!document.getElementById('editimg_'+target.id))
			{
				var ml=document.createElement('input');
				ml.onclick=function(event) { handleImageClick(event,target,true); };
				ml.type='button';
				ml.id='editimg_'+target.id;
				ml.value='{!EDIT;}';
				ml.className='magic_image_edit_link';
				ml.style.position='absolute';
				ml.style.zIndex=3000;
				target.parentNode.insertBefore(ml,target);
			}
		} , 2000);
	{+END}

	window.old_status_img=window.status;
	window.status='{$SPECIAL_CLICK_TO_EDIT;}';
}

function handleImageMouseOut(event)
{
	var target=event.target || event.srcElement;

	{+START,IF,{$NOT,{$VALUE_OPTION,disable_theme_img_buttons}}}
		if ((typeof target.mo_link!='undefined') && (target.mo_link))
		{
			window.clearTimeout(target.mo_link);
			target.mo_link=null;
		}

		if (target.previousSibling && target.previousSibling.className=='magic_image_edit_link')
		{
			target.mo_link=window.setInterval(function() {
				if ((typeof target.edit_window=='undefined') || (!target.edit_window) || (target.edit_window.closed))
				{
					target.parentNode.removeChild(target.previousSibling);
					window.clearTimeout(target.mo_link);
					target.mo_link=null;
				}
			} , 3000);
		}
	{+END}

	if (typeof window.old_status_img=='undefined') window.old_status_img='';
	window.status=window.old_status_img;
}

function handleImageClick(event,ob,force)
{
	if (!event) event=window.event;
	if (!ob) ob=this;

	var src=ob.origsrc?ob.origsrc:ob.src;
	if ((src) && ((force) || (magicKeypress(event))))
	{
		// Bubbling needs to be stopped because shift+click will open a new window on some lower event handler (in firefox anyway)
		cancelBubbling(event);
		
		if (typeof event.preventDefault!='undefined') event.preventDefault();

		if (src.indexOf('{$BASE_URL_NOHTTP;}/themes/')!=-1)
			ob.edit_window=window.open('{$BASE_URL;,0}/adminzone/index.php?page=admin_themes&type=edit_image&lang='+window.encodeURIComponent(window.ocp_lang)+'&theme='+window.encodeURIComponent(window.ocp_theme)+'&url='+window.encodeURIComponent(src.replace('{$BASE_URL;,0}/',''))+keep_stub(),'edit_theme_image_'+ob.id);
		else window.fauxmodal_alert('{!NOT_THEME_IMAGE^;}');

		return false;
	}

	return true;
}

function handleZoneClick(src,event,zone_name)
{
	if (magicKeypress(event))
	{
		zone_name=zone_name.replace(/:.*$/,'');
		
		// Bubbling needs to be stopped because shift+click will open a new window on some lower event handler (in firefox anyway)
		cancelBubbling(event);
		if (typeof event.preventDefault!='undefined') event.preventDefault();

		var target='{$BASE_URL;,0}/adminzone/index.php?page=admin_zones&type=_edit&id='+window.encodeURIComponent(zone_name)+'&redirect='+window.encodeURIComponent(window.location.href)+keep_stub();
		window.location.href=target;
		src.disabled=true; // Our handler is on onmousedown because IE will not capture events on onclick if ctrl is held. We need to disable the link to stop onclick firing.
		src.onclick=function() { cancelBubbling(event); if (typeof event.preventDefault!='undefined') event.preventDefault(); return false; }; // Needed for some browsers as you can't cancel on onmousedown

		return false;
	}

	return true;
}

function load_management_menu(type,no_confirm_needed)
{
	if (!type) type='management';

	var on_url,off_url;

	if (type=='management')
	{
		on_url="{$IMG,bottom/managementmenu}".replace(/^http:/,window.location.protocol);
		off_url="{$IMG,bottom/managementmenu}".replace(/^http:/,window.location.protocol);
	} else
	{
		{+START,IF,{$ADDON_INSTALLED,bookmarks}}
			on_url="{$IMG,bottom/bookmarksmenu}".replace(/^http:/,window.location.protocol);
			off_url="{$IMG,bottom/bookmarksmenu}".replace(/^http:/,window.location.protocol);
		{+END}
	}

	var tmp_element,img;
	var management_menu_box=document.getElementById(type+'_menu_box');
	if (management_menu_box)
	{
		img=document.getElementById(type+'_menu_img');
		if (management_menu_box.style.display!='block')
		{
			management_menu_box.style.display='block';
			img.src=off_url;
		} else
		{
			management_menu_box.style.display='none';
			img.src=on_url;
		}
		fixImage(img);
		return false;
	}

	if ((!window.popUpMenu) || (!window.ajax_supported))
	{
		if (document.getElementById(type+'_menu_img_loader'))
		{
			window.setTimeout(function() { load_management_menu(type,no_confirm_needed); },200);
			return false;
		}

		img=document.getElementById(type+'_menu_img');
		setOpacity(img,0.4);
		tmp_element=document.createElement('img');
		tmp_element.style.position='absolute';
		tmp_element.style.left=findPosX(img)+'px';
		//tmp_element.style.top=findPosY(img)+'px'; Doesn't apply because the bottom is absolutely positioned itself (and hence, the reference point)
		tmp_element.style.top='9px';
		tmp_element.id=type+'_menu_img_loader';
		tmp_element.src="{$IMG,bottom/loading}".replace(/^http:/,window.location.protocol);
		img.parentNode.appendChild(tmp_element);
		fixImage(img);

		require_javascript("javascript_ajax");
		require_javascript("javascript_menu_popup");
		window.setTimeout(function() { load_management_menu(type,no_confirm_needed); },200);

		return false;
	}
	if ((window.ajax_supported) && (ajax_supported()))
	{
		var show_overlay=function()
		{
			addEventListenerAbstract(document,'click',function (e) { if (!e) e=window.event; var el=e.target; if (!el) el=e.srcElement; if (el.id!=type+'_menu_img') { document.getElementById(type+'_menu_img').src=on_url; document.getElementById(type+'_menu_box').style.display='none'; } },false);

			var img=document.getElementById(type+'_menu_img');
			img.src=off_url;
			fixImage(img);

			tmp_element=document.getElementById(type+'_menu_img_loader');
			if (tmp_element) tmp_element.parentNode.removeChild(tmp_element);
			setOpacity(img,1.0);
			var e=document.createElement('div');
			e.setAttribute('id',type+'_menu_box');
			e.style.zIndex=200;
			var b=document.getElementById(type+'_menu_rel');
			e.style.position='absolute';
			e.style.bottom='10px';
			setInnerHTML(e,load_snippet(type+'_menu'));
			b.appendChild(e);
		}

		if (no_confirm_needed)
		{
			show_overlay();
		} else
		{
			confirm_session(
				function(result)
				{
					show_overlay(result);
				}
			);
		}

		return false; // No need to load link now, because we've done an overlay
	}
	window.location.href=document.getElementById(type+'_menu_button').href;
	return false;
}

function load_ocpchat(event)
{
	cancelBubbling(event);
	if (typeof event.preventDefault!='undefined') event.preventDefault();
	
	var html=' \
		<div style="margin: 20px; font-size: 0.85em; float: right; width: 260px;"> \
			<h2>{!OCP_COMMUNITY_HELP}</h2> \
			<ul class="spaced_list">{!OCP_CHAT_EXTRA;}</ul> \
			<br /> \
			<p class="community_block_tagline">[ <a title="{!OCP_CHAT_STANDALONE}: {!LINK_NEW_WINDOW}" target="_blank" href="http://chat.zoho.com/guest.sas?k=%7B%22g%22%3A%22Anonymous%22%2C%22c%22%3A%2299b05040669de8c406b674d2366ff9b0401fe3523f0db988%22%2C%22o%22%3A%22e89335657fd675dcfb8e555ea0615984%22'+'%7D'+'&amp;participants=true">{!OCP_CHAT_STANDALONE}</a> | <a href="#" onclick="return load_ocpchat(event);">{!HIDE}</a>]</p> \
		</div> \
		<iframe style="overflow:hidden;width:450px;height:90%;" frameborder="0" border="0" src="http://chat.zoho.com/shout.sas?k=%7B%22g%22%3A%22Anonymous%22%2C%22c%22%3A%2299b05040669de8c406b674d2366ff9b0401fe3523f0db988%22%2C%22o%22%3A%22e89335657fd675dcfb8e555ea0615984%22'+'%7D'+'&amp;chaturl=ocPortal%20chat&amp;V=000000-70a9e1-eff4f9-70a9e1-ocPortal%20chat&amp;user={$SITE_NAME.*}'+((typeof window.ocp_username!='undefined')?window.encodeURIComponent('/'+window.ocp_username):'')+'&amp;participants=true"></iframe> \
	'.replace(/\\{1\\}/,escape_html((window.location+'').replace(get_base_url(),'http://baseurl')));
	
	var box=document.getElementById('ocpchat_box');
	if (box)
	{
		box.parentNode.removeChild(box);

		setOpacity(document.getElementById('ocpchat_img'),1.0);
	} else
	{
		box=document.createElement('div');

		box.id='ocpchat_box';
		box.style.width='750px';
		box.style.background='#EEE';
		box.style.color='#000';
		box.style.padding='5px';
		box.style.border='3px solid #AAA';
		box.style.height='420px';
		box.style.position='absolute';
		box.style.zIndex=2000;
		box.style.left=(getWindowWidth()-650)/2+"px";
		var top_temp=100;
		box.style.top=top_temp+"px";

		setInnerHTML(box,html);
		document.body.appendChild(box);
		
		smoothScroll(0);

		setOpacity(document.getElementById('ocpchat_img'),0.5);
		
		//window.setTimeout( function() { try { window.frames[window.frames.length-1].documentElement.getElementById('texteditor').focus(); } catch (e) {} } ), 5000);		Unfortunately cannot do, JS security context issue
	}
	
	return false;
}

function staff_actions_select(ob)
{
	var form;
	if (ob.nodeName.toLowerCase()=='form')
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
		form.submit();
	}
}
