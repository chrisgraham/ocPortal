{$,Ideally this template should not be edited. See the note at the bottom of how JAVASCRIPT_CUSTOM_GLOBALS.tpl is appended to this template}

"use strict";

var _editor_url="{$BASE_URL#,0}".replace(/^http:/,window.location.protocol)+"/data/areaedit/";
var _editor_backend=null;
var _editor_lang=(window.ocp_lang)?ocp_lang.toLowerCase():'en';

{$,Startup}
var pageLoaded=false;
function scriptLoadStuff()
{
	if (pageLoaded) return; // Been called twice for some reason

	var i;

	if (window==window.top && !window.opener || window.name=='') window.name='_site_opener';

	{$,Dynamic images need preloading}
	var preloader=new Image();
	var images=[];
	images[0]="{$IMG,menus/menu_bullet_hover}".replace(/^http:/,window.location.protocol);
	images[1]="{$IMG,menus/menu_bullet_expand_hover}".replace(/^http:/,window.location.protocol);
	images[2]="{$IMG,expand}".replace(/^http:/,window.location.protocol);
	images[3]="{$IMG,contract}".replace(/^http:/,window.location.protocol);
	images[4]="{$IMG,exp_con}".replace(/^http:/,window.location.protocol);
	images[5]="{$IMG,bottom/loading}".replace(/^http:/,window.location.protocol);
	for(i=0;i<images.length;i++) preloader.src=images[i];

	{$,Inline image expansion mechanism}
	for (i=0;i<document.images.length;i++)
	{
		var j=document.images[i];
		if ((firstClassName(j.className)=='img_thumb') || (j.className.indexOf(' img_thumb')!=-1))
		{
			setOpacity(j,0.7);
		}

		if ((firstClassName(j.className)=='scale_down') || (j.className.indexOf(' scale_down')!=-1))
		{
			j.onclick=function(j) { return function() { if (j.className=='scale_down') { j.className='dont_scale_down'; j.setAttribute('title',''); } else { j.className='scale_down'; j.setAttribute('title','{!CLICK_EXPAND_FULL^;}'); } } } (j);
		}
	}

	{$,Opacity/Alpha-blending}
	var helper_pic=document.getElementById('global_helper_panel_pic');
	if (helper_pic) setOpacity(helper_pic,0.08);
	fixImages();

	{$,Textarea scroll support}
	handleTextareaScrolling();

	{$,Tell the server we have Javascript, so do not degrade things for reasons of compatibility - plus also set other things the server would like to know}
	{+START,IF,{$CONFIG_OPTION,detect_javascript}}
		SetCookie('js_on',1,120);
	{+END}
	if ((!window.parent) || (window.parent==window))
	{
		//SetCookie('screen_width',getWindowWidth(),120);	Violation of EU Cookie Guidelines :(
		if (typeof window.server_timestamp!='undefined')
		{
			SetCookie('client_time',new Date().toString(),120);
			SetCookie('client_time_ref',window.server_timestamp,120);
		}
	}

	for (i=0;i<document.forms.length;i++)
	{
		new_html__initialise(document.forms[i]);
	}

	{$,Staff functionality}
	if (typeof window.scriptLoadStuffStaff!='undefined') scriptLoadStuffStaff();

	{$,Mouse/keyboard listening}
	window.mouseX=0;
	window.mouseY=0;
	window.ctrlPressed=false;
	window.altPressed=false;
	window.metaPressed=false;
	window.shiftPressed=false;
	addEventListenerAbstract(document.body,'mousemove',getMouseXY);
	if (typeof window.addEventListener!='undefined')
		window.addEventListener('click',captureClickKeyStates,true); {$,Workaround for a dodgy firefox extension}

	{$,So we can change base tag especially when on debug mode}
	if (document.getElementsByTagName('base')[0])
	{
		for (i=0;i<document.links.length;i++)
		{
			var href=document.links[i].getAttribute('href');
			if ((href) && (href.substr(0,1)=='#'))
			{
				document.links[i].setAttribute('href',window.location.href.replace(/#.*$/,'')+href);
			}
		}
	}

	{$,Lightboxes}
	{+START,IF,{$CONFIG_OPTION,js_overlays}}
		for (i=0;i<document.links.length;i++)
		{
			var j=document.links[i];
			var rel=j.getAttribute('rel');
			if (rel && rel.match(/(^|\s)lightbox($|\s)/))
			{
				j.onclick=function(j) { return function() {
					open_image_into_lightbox(j);
					return false;
				} }(j);
			}
		}
	{+END}

	{$,Autosaving}
	if ((typeof window.want_form_saving!='undefined') && (window.want_form_saving))
	{
		window.setTimeout(function() { if (typeof init_form_saving!='undefined') init_form_saving(); },4000);
	}

	if (typeof window.scriptLoadStuffB!='undefined') window.scriptLoadStuffB();

	pageLoaded=true;
}

function new_html__initialise(element)
{
	switch (element.nodeName.toLowerCase())
	{
		case 'form':
			if (element.className.indexOf('autocomplete')!=-1)
			{
				element.setAttribute('autocomplete','on');
			} else
			{
				var dont_autocomplete=['edit_username','edit_password'];
				for (var j=0;j<dont_autocomplete.length;j++) {$,Done in very specific way, as Firefox will nuke any explicitly non-autocompleted values when clicking back also}
					if (element.elements[dont_autocomplete[j]]) element.elements[dont_autocomplete[j]].setAttribute('autocomplete','off');
			}

			{$,HTML editor}
			if (typeof window.load_html_edit!='undefined')
			{
				load_html_edit(element);
			}

			{$,Remove tooltips from forms for mouse users as they are for screenreader accessibility only}
			if (element.getAttribute('target')!='_blank')
				addEventListenerAbstract(element,'mouseover',function() { try {element.setAttribute('title','');element.title='';}catch(e){};/*IE6 does not like*/ } );
	}
}

function initialise_error_mechanism()
{
	window.onerror=function(msg,file,code)
		{
			if (typeof msg.indexOf=='undefined') return null;

			if (
				(msg.indexOf('AJAX_REQUESTS is not defined')!=-1) || // Intermittent during page out-clicks

				// Internet Explorer false positives
				(((msg.indexOf("'null' is not an object")!=-1) || (msg.indexOf("'undefined' is not a function")!=-1)) && ((typeof file=='undefined') || (file=='undefined'))) || // Weird errors coming from outside
				((code=='0') && (msg.indexOf('Script error.')!=-1)) || // Too generic, can be caused by user's connection error

				// Firefox false positives
				(msg.indexOf("attempt to run compile-and-go script on a cleared scope")!=-1) || // Intermittent buggyness
				(msg.indexOf('UnnamedClass.toString')!=-1) || // Weirdness
				(msg.indexOf('ASSERT: ')!=-1) || // Something too generic
				((file) && (file.indexOf('TODO: FIXME')!=-1)) || // Something too generic / Can be caused by extensions
				(msg.indexOf('TODO: FIXME')!=-1) || // Something too generic / Can be caused by extensions
				(msg.indexOf('Location.toString')!=-1) || // Buggy extensions may generate
				(msg.indexOf('Error loading script')!=-1) || // User's connection error
				(msg.indexOf('NS_ERROR_FAILURE')!=-1) || // Usually an internal error

				// Google Chrome false positives
				(msg.indexOf('can only be used in extension processes')!=-1) || // Can come up with MeasureIt
				(msg.indexOf('extension.')!=-1) || // E.g. "Uncaught Error: Invocation of form extension.getURL() doesn't match definition extension.getURL(string path) schema_generated_bindings"

				false // Just to allow above lines to be reordered
			)
				return null; {$,Comes up on due to various Firefox/extension/etc bugs}

			if ((typeof window.done_one_error=='undefined') || (!window.done_one_error))
			{
				window.done_one_error=true;
				var alert='{!JAVASCRIPT_ERROR^;}\n\n'+code+': '+msg+'\n'+file;
				window.fauxmodal_alert(alert,null,'{!ERROR_OCCURRED^;}');
			}
			return false;
		};
	addEventListenerAbstract(window,'unload',function() { window.onerror=null; } );
}
if ((typeof window.take_errors!='undefined') && (window.take_errors)) initialise_error_mechanism();
window.unloaded=false;
addEventListenerAbstract(window,'unload',function() { window.unloaded=true; } );

function staff_unload_action()
{
	undo_staff_unload_action();
	var bi=document.getElementById('body_inner');
	if (bi)
	{
		if (typeof window.nereidFade!='undefined')
		{
			nereidFade(bi,20,30,-4);
		} else
		{
			setOpacity(bi,0.2);
		}
	}
	var div=document.createElement('div');
	div.className='unload_action';
	div.style.width='100%';
	div.style.top=(getWindowHeight()/2-160)+'px';
	div.style.position='absolute';
	div.style.zIndex=10000;
	div.style.textAlign='center';
	setInnerHTML(div,'<span{$?,{$VALUE_OPTION,html5}, aria-busy="true"} style="width: 10em; display: inline-block" class="lightborder"><h2>{!LOADING^;}</h2><img id="loading_image" alt="" src="'+'{$IMG;,bottom/loading}'.replace(/^http:/,window.location.protocol)+'" /></span>');
	window.setTimeout( function() { if (document.getElementById('loading_image')) document.getElementById('loading_image').src+=''; } , 100); // Stupid workaround for Google Chrome not loading an image on unload even if in cache
	document.body.appendChild(div);
	if (typeof window.scrollTo!='undefined')
	{
		try
		{
			window.scrollTo(0,0);
		}
		catch (e) {};
	}

	addEventListenerAbstract(window,'pageshow',undo_staff_unload_action);
	addEventListenerAbstract(window,'keydown',undo_staff_unload_action);
	addEventListenerAbstract(document.body,'keydown',undo_staff_unload_action); // Needed for IE6
	addEventListenerAbstract(window,'click',undo_staff_unload_action);
}

function undo_staff_unload_action()
{
	var pre=get_elements_by_class_name(document.body,'unload_action');
	for (var i=0;i<pre.length;i++)
	{
		pre[i].parentNode.removeChild(pre[i]);
	}
	var bi=document.getElementById('body_inner');
	if (bi)
	{
		if ((typeof window.thumbFadeTimers!='undefined') && (thumbFadeTimers[bi.faderKey]))
		{
			window.clearTimeout(thumbFadeTimers[bi.faderKey]);
			thumbFadeTimers[bi.faderKey]=null;
		}
		setOpacity(bi,1.0);
	}
}

function checkFieldForBlankness(field,event)
{
	if (!field) return true; {$,Shame we need this, seems on Google Chrome things can get confused on JS assigned to page-changing events}
	if (typeof field.nodeName=='undefined') return true; {$,Also bizarre}

	var value;
	if (field.nodeName.toLowerCase()=='select')
	{
		value=field.options[field.selectedIndex].value;
	} else
	{
		value=field.value;
	}

	var ee=document.getElementById('error_'+field.id);

	if ((value.replace(/\s/g,'')=='') || (value=='****') || (value=="{!POST_WARNING^#}"))
	{
		if (event)
		{
			cancelBubbling(event);
		}

		if (ee!==null)
		{
			ee.style.display='block';
			setInnerHTML(ee,"{!REQUIRED_NOT_FILLED_IN^#}");
		}

		window.fauxmodal_alert("{!IMPROPERLY_FILLED_IN^#}");
		return false;
	}

	if (ee!==null)
	{
		ee.style.display='none';
	}

	return true;
}
function disable_button_just_clicked(input)
{
	if (input.nodeName.toLowerCase()=='form')
	{
		for (var i=0;i<input.elements.length;i++)
			if ((input.elements[i].type=='submit') || (input.elements[i].type=='button') || (input.elements[i].type=='image') || (input.elements[i].nodeName.toLowerCase()=='button'))
				disable_button_just_clicked(input.elements[i]);
		return;
	}

	if (input.form.target=='_blank') return;

	window.setTimeout(function() {
		input.disabled=true;
		input.under_timer=true;
	},20);
	input.style.cursor='wait';
	var goback=function() {
		input.disabled=false;
		input.under_timer=false;
		input.style.cursor='default';
	};
	window.setTimeout(goback,5000);

	addEventListenerAbstract(window,"pagehide",goback);
}

function manageScrollHeight(ob)
{
	var dif=0;
	if ((browser_matches('chrome'))/* || (browser_matches('ie')) This is some gap but it is needed for the scrollbox rendering */) dif=-4;
	var height=(ob.scrollHeight-sts(ob.style.paddingTop)-sts(ob.style.paddingBottom)-sts(ob.style.marginTop)-sts(ob.style.marginBottom)+dif)
	if ((height>5) && (sts(ob.style.height)<height) && (findHeight(ob)<height)/*findHeight needed for IE6*/)
	{
		ob.style.height=height+'px';
		trigger_resize();
	}
}

// 'Cancel' should come as index 0 and Ok/default-option should come as index 1. This is so that the fallback works right.
function generate_question_ui(message,button_set,window_title,fallback_message,callback)
{
	var image_set=[];
	if (typeof button_set.length=='undefined')
	{
		var new_button_set=[];
		for (var s in button_set)
		{
			new_button_set.push(button_set[s]);
			image_set.push(s);
		}
		button_set=new_button_set;
	}

	if ((typeof window.showModalDialog!='undefined'){+START,IF,{$CONFIG_OPTION,js_overlays}} || true{+END})
	{
		var height=180;
		if (button_set.length>4) height+=5*(button_set.length-4);

		{$,Intentionally FIND_SCRIPT and not FIND_SCRIPT_NOHTTP, because no needs-HTTPS security restriction applies to popups, yet popups do not know if they run on HTTPS if behind a transparent reverse proxy}
		var url=maintain_theme_in_link('{$FIND_SCRIPT;,question_ui}?message='+window.encodeURIComponent(message)+'&image_set='+window.encodeURIComponent(image_set.join(','))+'&button_set='+window.encodeURIComponent(button_set.join(','))+'&window_title='+window.encodeURIComponent(window_title)+keep_stub());
		window.faux_showModalDialog(
			url,
			null,
			'dialogWidth=440;dialogHeight='+height+';status=no;unadorned=yes',
			function(result)
			{
				if ((typeof result=="undefined") || (result===null))
				{
					callback(button_set[0]); // just pressed 'cancel', so assume option 0
				} else
				{
					callback(result);
				}
			}
		);

		return;
	}

	if (button_set.length==1)
	{
		window.fauxmodal_alert(
			fallback_message?fallback_message:message,
			function()
			{
				callback(button_set[0]);
			},
			window_title
		);
		return;
	} else
	if (button_set.length==2)
	{
		window.fauxmodal_confirm(
			fallback_message?fallback_message:message,
			function(result)
			{
				callback(result?button_set[1]:button_set[0]);
			},
			window_title
		);
		return;
	} else
	{
		if (!fallback_message)
		{
			message+="\n\n{!INPUTSYSTEM_TYPE_EITHER^#}";
			for (var i=0;i<button_set.length;i++)
			{
				message+=button_set[i]+',';
			}
			message=message.substr(0,message.length-1);
		} else message=fallback_message;

		window.fauxmodal_prompt(
			message,
			'',
			function(result)
			{
				if ((typeof result=="undefined") || (result===null))
				{
					callback(button_set[0]); // just pressed 'cancel', so assume option 0
					return;
				} else
				{
					if (result=='')
					{
						callback(button_set[1]); // just pressed 'ok', so assume option 1
						return;
					}
					for (var i=0;i<button_set.length;i++)
					{
						if (result.toLowerCase()==button_set[i].toLowerCase()) // match
						{
							callback(result);
							return;
						}
					}
				}

				// unknown
				callback(button_set[0]);
				return;
			},
			window_title
		);
	}
}

/* Find the main ocPortal window */
function get_main_ocp_window()
{
	if (opener) return opener;
	if (parent) return parent;
	return window;
}

function doc_onmouseout()
{
	if (typeof window.orig_helper_text!='undefined')
	{
		var help=document.getElementById('help');
		if (!help) return; // In zone editor, probably
		setInnerHTML(help,window.orig_helper_text);
		if (typeof window.nereidFade!='undefined')
		{
			setOpacity(help,0.0);
			nereidFade(help,100,30,4);
		}
		help.className='global_helper_panel_text';
	}
}

function doc_onmouseover(i)
{
	var doc=document.getElementById('doc_'+i);
	if ((doc) && (getInnerHTML(doc)!=''))
	{
		var help=document.getElementById('help');
		if (!help) return; // In zone editor, probably
		window.orig_helper_text=getInnerHTML(help);
		setInnerHTML(help,getInnerHTML(doc));
		if (typeof window.nereidFade!='undefined')
		{
			setOpacity(help,0.0);
			nereidFade(help,100,30,4);
		}
		help.className='global_helper_panel_text_over';
	}
}

function handleTextareaScrolling()
{
	var i;
	var elements=document.getElementsByTagName('textarea');
	for (i=0;i<elements.length;i++)
	{
		if (elements[i].className.indexOf('textarea_scroll')!=-1)
		{
			elements[i].setAttribute('wrap','off');
			elements[i].style.overflow='auto'; {$,This just forces a redraw, might not be needed for its own property}
		}
	}
}

function scriptPageRendered()
{
	{$,Move the help panel if needed}
	{+START,IF,{$NOT,{$CONFIG_OPTION,fixed_width}}}
		if (getWindowWidth()<990)
		{
			var panel_right=document.getElementById('panel_right');
			var global_div=document.getElementById('global_div');
			if (panel_right)
			{
				var divs=panel_right.getElementsByTagName('div');
				if ((divs[0]) && (divs[0].className.indexOf('global_helper_panel')!=-1))
				{
					var middle=get_elements_by_class_name(panel_right.parentNode,'global_middle')[0];
					if (middle)
					{
						middle.style.marginRight='0';
						var boxes=get_elements_by_class_name(panel_right,'standardbox_curved'),i;
						for (i=0;i<boxes.length;i++)
						{
							boxes[i].style.width='auto';
						}
						panel_right.className+=' horiz_help_panel';
						panel_right.parentNode.removeChild(panel_right);
						middle.parentNode.appendChild(panel_right);
						document.getElementById('helper_panel_toggle').style.display='none';
						get_elements_by_class_name(panel_right,'global_helper_panel')[0].style.minHeight='0';
					}
				}
			}
		}
	{+END}
}

function help_panel(show)
{
	var panel_right=document.getElementById('panel_right');
	var middles=get_elements_by_class_name(document,'global_middle');
	var global_message=document.getElementById('global_message');
	var helper_panel_contents=document.getElementById('helper_panel_contents');
	var helper_panel_toggle=document.getElementById('helper_panel_toggle');
	var i;
	if (show)
	{
		panel_right.style.width='275px';
		if (global_message) global_message.style.margin{$WCASE,{!en_right}}='275px';
		for (i=0;i<middles.length;i++)
		{
			middles[i].style.margin{$WCASE,{!en_right}}='275px';
		}
		helper_panel_contents.setAttribute('aria-expanded','true');
		helper_panel_contents.style.display='block';
		if (typeof window.nereidFade!='undefined')
		{
			setOpacity(helper_panel_contents,0.0);
			nereidFade(helper_panel_contents,100,30,4);
		}
		if (ReadCookie('hide_help_panel')=='1') SetCookie('hide_help_panel','0',100);
		helper_panel_toggle.onclick=function() { return help_panel(false); };
		helper_panel_toggle.childNodes[0].setAttribute('src','{$IMG;,help_panel_hide}'.replace(/^http:/,window.location.protocol));
	} else
	{
		if (ReadCookie('hide_help_panel')=='')
		{
			window.fauxmodal_confirm(
				'{!CLOSING_HELP_PANEL_CONFIRM^;}',
				function(answer)
				{
					if (answer)
						_hide_help_panel(middles,panel_right,global_message,helper_panel_contents,helper_panel_toggle);
				}
			);
			return false;
		}
		_hide_help_panel(middles,panel_right,global_message,helper_panel_contents,helper_panel_toggle);
	}
	return false;
}

function _hide_help_panel(middles,panel_right,global_message,helper_panel_contents,helper_panel_toggle)
{
	panel_right.style.width='26px';
	if (global_message) global_message.style.margin{$WCASE,{!en_right}}='16px';
	for (var i=0;i<middles.length;i++)
	{
		middles[i].style.margin{$WCASE,{!en_right}}='16px';
	}
	helper_panel_contents.setAttribute('aria-expanded','false');
	helper_panel_contents.style.display='none';
	SetCookie('hide_help_panel','1',100);
	helper_panel_toggle.onclick=function() { return help_panel(true); };
	helper_panel_toggle.childNodes[0].setAttribute('src','{$IMG;,help_panel_show}'.replace(/^http:/,window.location.protocol));
}

function sts(src)
{
	if (!src) return 0;
	if (src.indexOf('px')==-1) return 0;
	return window.parseInt(src.replace('px',''));
}

function captureClickKeyStates(event)
{
	window.capture_event=event;
}

function magicKeypress(event)
{
	{$,Cmd+Shift works on Mac - can not hold down control or alt in Mac firefox at least}
	if (typeof window.capture_event!='undefined') event=window.capture_event;
	var count=0;
	if (event.shiftKey) count++;
	if (event.ctrlKey) count++;
	if (event.metaKey) count++;
	if (event.altKey) count++;

	return (count>=2);
}

function window_r(expr)
{
	var win=window.open('','format','width=400,height=300,left=50,top=50,status,menubar,scrollbars,resizable');
	win.document.open();
	win.document.write('<pre>'+((window.format_r)?format_r(expr):expr)+'</pre>');
	win.document.close()
	try
	{
		win.focus();
	}
	catch (e) {};
}

function escape_html(value)
{
	if (!value) return '';
	return value.replace(/&/g,'&amp;').replace(/"/g,'&quot;').replace(new RegExp('<','g')/* For CDATA embedding else causes weird error */,'&lt;').replace(/>/g,'&gt;');
}

function escape_comcode(value)
{
	return value.replace(/\\/g,'\\\\').replace(/"/g,'\\"');
}

function create_rollover(rand,rollover)
{
	var img=document.getElementById(rand);
	if (!img) return;
	new Image().src=rollover; {$,precache}
	var activate=function()
	{
		img.old_src=img.getAttribute('src');
		if (typeof img.origsrc!='undefined') img.old_src=img.origsrc;
		img.setAttribute('src',rollover);
		refixImage(img);
	};
	var deactivate=function()
	{
		img.setAttribute('src',img.old_src);
		refixImage(img);
	};
	addEventListenerAbstract(img,"mouseover",activate);
	addEventListenerAbstract(img,"click",deactivate);
	addEventListenerAbstract(img,"mouseout",deactivate);
}

{$,Cookies}
function SetCookie(cookieName,cookieValue,nDays)
{
	var today=new Date();
	var expire=new Date();
	if (nDays==null || nDays==0) nDays=1;
	expire.setTime(today.getTime()+3600000*24*nDays);
	var extra="";
	if ("{$COOKIE_PATH}"!="") extra=extra+";path={$COOKIE_PATH}";
	if ("{$COOKIE_DOMAIN}"!="") extra=extra+";domain={$COOKIE_DOMAIN}";
	var to_set=cookieName+"="+encodeURIComponent(cookieValue)+";expires="+expire.toUTCString()+extra;
	document.cookie=to_set;
	var read=ReadCookie(cookieName);
	if ((read!=cookieValue) && (read))
	{
		{+START,IF,{$DEV_MODE}}
			if (!window.done_cookie_alert) window.fauxmodal_alert('{!COOKIE_CONFLICT_DELETE_COOKIES^;}'+'... '+document.cookie+' ('+to_set+')',null,'{!ERROR_OCCURRED^;}');
		{+END}
		window.done_cookie_alert=true;
	}
}
function ReadCookie(cookieName)
{
	var theCookie=""+document.cookie;
	var ind=theCookie.indexOf(' '+cookieName+'=');
	if ((ind==-1) && (theCookie.substr(0,cookieName.length+1)==cookieName+'=')) ind=0; else if (ind!=-1) ind++;
	if (ind==-1 || cookieName=="") return "";
	var ind1=theCookie.indexOf(';',ind);
	if (ind1==-1) ind1=theCookie.length;
	return window.decodeURIComponent(theCookie.substring(ind+cookieName.length+1,ind1));
}

{$,Filtering class names}
function firstClassName(className)
{
	var p=className.indexOf(' ');
	if (p!=-1)
	{
		return className.substr(0,p);
	}
	return className;
}

function get_elements_by_class_name(node,classname)
{
	if (node)
	{
		var a=[];
		var re=new RegExp('(^| )'+classname+'( |$)');
		var els=node.getElementsByTagName("*");

		for(var i=0,j=els.length; i<j; i++)
		{
			if (re.test(els[i].className)) a.push(els[i]);
		}

		return a;
	}
	else return []; {$,Error actually, but to avoid typing error, we will just return an empty list}
}

{$,Type checking}
function isInteger(val)
{
	if (val=="") return false;
	var c;
	for (var i=0;i<val.length;i++)
	{
		c=val.charAt(i);
		if ((c!="0") && (c!="1") && (c!="2") && (c!="3") && (c!="4") && (c!="5") && (c!="6") && (c!="7") && (c!="8") && (c!="9"))
			return false;
	}
	return true;
}

{$,Browser sniffing}
function is_opera()
{
	return browser_matches('opera');
}
function is_ie()
{
	return browser_matches('ie');
}
function browser_matches(code)
{
	var browser=navigator.userAgent.toLowerCase();
	var os=navigator.platform.toLowerCase()+' '+browser;

	var _is_opera=browser.indexOf('opera')!=-1;
	var is_konqueror=browser.indexOf('konqueror')!=-1;
	var is_safari=browser.indexOf('applewebkit')!=-1;
	var is_chrome=browser.indexOf('chrome/')!=-1;
	var is_gecko=(browser.indexOf('gecko')!=-1) && !_is_opera && !is_konqueror && !is_safari;
	var _is_ie=(browser.indexOf('msie')!=-1) && !_is_opera;
	var is_ie_old=((browser.indexOf('msie 6')!=-1) || (browser.indexOf('msie 5')!=-1)) && _is_ie;
	var is_ie_decent=(!is_ie_old) && (browser.indexOf('msie 7')==-1) && _is_ie;
	var is_ie5=(browser.indexOf('msie 5')!=-1) && _is_ie;
	var is_ie_new=(!is_ie_old) && _is_ie;
	var is_iceweasel=browser.indexOf('iceweasel')!=-1;

	switch (code)
	{
		case 'ios':
			return browser.indexOf('iphone')!=-1 || browser.indexOf('ipad')!=-1;
		case 'android':
			return browser.indexOf('android')!=-1;
		case 'no_alpha_ie':
			{$,By Erik Arvidsson}
			return ((/MSIE ((5\.5)|[6])/.test(navigator.userAgent)) && (navigator.platform=="Win32") && (!_is_opera));
		case 'no_alpha_ie_with_opacity':
			return ((/MSIE ((5\.5)|[678])/.test(navigator.userAgent)) && (navigator.platform=="Win32") && (!_is_opera));
		case 'wysiwyg':
			if ('{$CONFIG_OPTION,wysiwyg}'=='0') return false;
			return true;
		case 'windows':
			return os.indexOf('windows')!=-1 || os.indexOf('win32')!=-1;
		case 'mac':
			return os.indexOf('mac')!=-1;
		case 'linux':
			return os.indexOf('linux')!=-1;
		case 'opera':
			return _is_opera;
		case 'ie':
			return _is_ie;
		case 'ie5':
			return is_ie5;
		case 'ie6':
		case 'ie_old':
			return is_ie_old;
		case 'ie7+':
		case 'ie_new':
			return is_ie_new;
		case 'ie8+':
		case 'ie_decent':
			return is_ie_decent;
		case 'chrome':
			return is_chrome;
		case 'gecko':
			return is_gecko;
		case 'konqueror':
			return is_konqueror;
		case 'safari':
			return is_safari;
	}

	{$,Should never get here}
	return false;
}

{$,Safe way to get the base URL}
function get_base_url()
{
	return (window.location+'').replace(/(^.*:\/\/[^\/]*)\/.*/,'$1')+'{$BASE_URL_NOHTTP;}'.replace(/^.*:\/\/[^\/]*/,'');
}

{$,Enforcing a session using AJAX}
function confirm_session(callback)
{
	if (typeof window.do_ajax_request=='undefined') return;

	var url='{$FIND_SCRIPT_NOHTTP;,confirm_session}'+keep_stub(true);

	// First see if session already established
	var ret=null;
	require_javascript("javascript_ajax");
	if (typeof window.do_ajax_request!='undefined') ret=do_ajax_request(url+keep_stub(true),false);
	if (!ret) return;

	if (ret && ret.responseText==='') // Blank means success, no error - so we can call callback
	{
		callback(true);
		return;
	}

	// But non blank tells us the username, and there is an implication that no session is confirmed for this login

	if (ret.responseText=='{!GUEST;}') // Hmm, actually whole login was lost, so we need to ask for username too
	{
		window.fauxmodal_prompt(
			'{!USERNAME^;}',
			'',
			function(promptt)
			{
				_confirm_session(callback,promptt,url);
			},
			'{!_LOGIN;}'
		);
		return;
	}

	_confirm_session(callback,ret.responseText,url);
}

function _confirm_session(callback,username,url)
{
	window.fauxmodal_prompt(
		'{$?,{$NOT,{$CONFIG_OPTION,js_overlays}},{!ENTER_PASSWORD_JS^;},{!ENTER_PASSWORD_JS_2^;}}',
		'',
		function(promptt)
		{
			if (promptt!==null)
			{
				var ret=do_ajax_request(url,false,'login_username='+window.encodeURIComponent(username)+'&password='+window.encodeURIComponent(promptt));

				if (ret && ret.responseText==='') // Blank means success, no error - so we can call callback
					callback(true);
				else
					_confirm_session(callback,username,url); // Recurse
			} else callback(false);
		},
		'{!_LOGIN;}',
		'password'
	);
}

{$,Dynamic inclusion}
function load_snippet(code,post,callback)
{
	var title=getInnerHTML(document.getElementsByTagName('title')[0]);
	var metas=document.getElementsByTagName('link');
	var i;
	if (!window.location) return null; // In middle of page navigation away
	var url=window.location.href;
	for (i=0;i<metas.length;i++)
	{
		if (metas[i].getAttribute('rel')=='canonical') url=metas[i].getAttribute('href');
	}
	if (!url) url=window.location.href;
	var html;
	if (typeof window.do_ajax_request!='undefined')
	{
		var url2="{$FIND_SCRIPT_NOHTTP#,snippet}?snippet="+code+"&url="+window.encodeURIComponent(url)+'&title='+window.encodeURIComponent(title)+keep_stub();
		html=do_ajax_request(maintain_theme_in_link(url2),callback,post);
	}
	if (callback) return null;
	return html.responseText;
}
function require_css(sheet)
{
	if (document.getElementById('loading_css_'+sheet)) return;
	var link=document.createElement('link');
	link.setAttribute('id','loading_css_'+sheet);
	link.setAttribute('type',"text/css");
	link.setAttribute('rel',"stylesheet");
	link.setAttribute('href',"{$FIND_SCRIPT_NOHTTP#,sheet}?sheet="+sheet+keep_stub());
	document.getElementsByTagName('head')[0].appendChild(link);
}
function require_javascript(script,lang)
{
	if (document.getElementById('loading_js_'+script)) return;
	var link=document.createElement('script');
	link.setAttribute('id','loading_js_'+script);
	link.setAttribute('type',"text/javascript");
	var url="{$FIND_SCRIPT_NOHTTP#,javascript}?script="+script+keep_stub();
	if (lang) url=url+"&lang="+lang;
	link.setAttribute('src',url);
	document.getElementsByTagName('head')[0].appendChild(link);
}

{$,Tabs}
function select_tab(id,tab)
{
	if (document.getElementById('tab__'+tab.toLowerCase()))
		window.location.hash='#tab__'+tab.toLowerCase();

	var tabs=[];
	var i,element;
	element=document.getElementById('t_'+tab);
	for (i=0;i<element.parentNode.childNodes.length;i++)
	{
		if ((element.parentNode.childNodes[i].id) && (element.parentNode.childNodes[i].id.substr(0,2)=='t_'))
			tabs.push(element.parentNode.childNodes[i].id.substr(2));
	}

	for (i=0;i<tabs.length;i++)
	{
		element=document.getElementById(id+'_'+tabs[i]);
		if (element)
		{
			{+START,IF,{$ADDON_INSTALLED,plupload,1}}
				element.style.display=(tabs[i]==tab)?'block':'none';
			{+END}
			{+START,IF,{$NOT,{$ADDON_INSTALLED,plupload,1}}}
				if (tabs[i]==tab)
				{
					element.style.display='block';
					element.style.visibility='';
					element.style.width='';
					element.style.height='';
				} else
				{
					element.style.visibility='hidden'; // We are not using visibility:hidden due to https://code.google.com/p/swfupload/issues/detail?id=231
					element.style.width='0';
					element.style.height='0';
				}
			{+END}

			if ((typeof window.nereidFade!='undefined') && (tabs[i]==tab))
			{
				if (typeof window['load_tab__'+tab]=='undefined')
				{
					setOpacity(element,0.0);
					nereidFade(element,100,30,8);
				}
			}
		}

		element=document.getElementById('t_'+tabs[i]);
		if (element)
		{
			element.className=element.className.replace(' tab_active','');
			if (tabs[i]==tab)	element.className+=' tab_active';
		}
	}

	if (typeof window['load_tab__'+tab]!='undefined') window['load_tab__'+tab](); // Usually an AJAX loader

	return false;
}

function set_display_with_aria(element,mode)
{
	element.style.display=mode;
	element.setAttribute('aria-hidden',(mode=='none')?'true':'false');
}

{$,Draw functionality}
function hideTag(element,noAnimate)
{
	var pics=element.getElementsByTagName('img');
	var pic=pics[0];
	toggleSectionInline('','block',pic,get_elements_by_class_name(element,'hide_tag')[0],noAnimate);
}
function toggleSectionTable(id,noAnimate)
{
	toggleSectionInline(id,browser_matches('ie')?'block':'table',false,noAnimate);
}
function toggleSectionInline(id,type,pic,itm,noAnimate)
{
	{+START,IF,{$VALUE_OPTION,disable_animations}}
		noAnimate=true;
	{+END}

	if ((typeof itm=='undefined') || (!itm)) var itm=document.getElementById(id);
	if (!itm) return;
	if ((typeof pic=='undefined') || (!pic)) var pic=document.getElementById('e_'+id);
	if ((pic) && (pic.src=="{$IMG,exp_con}".replace(/^http:/,window.location.protocol))) return;

	itm.setAttribute('aria-expanded',(type=='none')?'false':'true');

	if (itm.style.display=='none')
	{
		itm.style.display=type;
		if ((type=='block') && (itm.nodeName.toLowerCase()=='div') && (!noAnimate) && ((!pic) || (pic.src.indexOf("themewizard.php")==-1)))
		{
			itm.style.visibility='hidden';
			itm.style.width=findWidth(itm,true,true,true)+'px';
			itm.style.position='absolute'; /* So things do not just around now it is visible */
			if (pic)
			{
				pic.src="{$IMG,exp_con}".replace(/^http:/,window.location.protocol);
				refixImage(pic);
			}
			window.setTimeout(function() { beginAnimation(itm,20,70,-1,pic); } ,20);
		} else
		{
			if (typeof window.nereidFade!='undefined')
			{
				setOpacity(itm,0.0);
				nereidFade(itm,100,30,4);
			}

			if (pic)
			{
				pic.src=((pic.src.indexOf("themewizard.php")!=-1)?pic.src.replace("expand","contract"):"{$IMG,contract}").replace(/^http:/,window.location.protocol);
				refixImage(pic);
			}
		}
	} else
	{
		if ((type=='block') && (itm.nodeName.toLowerCase()=='div') && (!noAnimate) && ((!pic) || (pic.src.indexOf("themewizard.php")==-1)))
		{
			if (pic)
			{
				pic.src="{$IMG,exp_con}".replace(/^http:/,window.location.protocol);
				refixImage(pic);
			}
			window.setTimeout(function() { beginAnimation(itm,-20,70,0,pic); } ,20);
		} else
		{
			if (pic)
			{
				pic.src=((pic.src.indexOf("themewizard.php")!=-1)?pic.src.replace("contract","expand"):"{$IMG,expand}").replace(/^http:/,window.location.protocol);
				pic.setAttribute('alt',pic.getAttribute('alt').replace('{!CONTRACT;}','{!EXPAND;}'));
				pic.setAttribute('title','{!EXPAND;}');
				refixImage(pic);
			}
			itm.style.display='none';
		}
	}

	trigger_resize(true);
}

function beginAnimation(itm,animateDif,animateTicks,finalHeight,pic)
{
	var fullHeight=findHeight(itm,true);
	if (finalHeight==-1) // We're animating to full height - not a fixed height
	{
		finalHeight=fullHeight;
		itm.style.height='0px';
		itm.style.visibility='visible';
		itm.style.position='static';
	}
	if (fullHeight>300) {$,Quick finish in the case of huge expand areas}
	{
		animateDif*=6;
	}
	if (itm.parentNode.parentNode.className!='standardbox_wrap_classic') itm.style.outline='1px dashed gray';

	if (typeof window.nereidFade!='undefined')
	{
		if (finalHeight==0)
		{
			setOpacity(itm,1.0);
			nereidFade(itm,0,30,4);
		} else
		{
			setOpacity(itm,0.0);
			nereidFade(itm,100,30,4);
		}
	}

	var origOverflow=itm.style.overflow;
	itm.style.overflow='hidden';
	if (browser_matches('firefox')) itm.parentNode.style.overflow='hidden'; // Stops weird issue on Firefox
	window.setTimeout(function () { animate(itm,finalHeight,animateDif,origOverflow,animateTicks,pic); } ,animateTicks);
}

function animate(itm,finalHeight,animateDif,origOverflow,animateTicks,pic)
{
	var currentHeight=((itm.style.height=='auto')||(itm.style.height==''))?(findHeight(itm)):sts(itm.style.height);
	/*if (Math.max(currentHeight-finalHeight,finalHeight-currentHeight)<70)
	{
		if (animateDif<0) animateDif=Math.min(animateDif*0.8,-3);
		else animateDif=Math.max(animateDif*0.85,3);
	}*/
	if (((currentHeight>finalHeight) && (animateDif<0)) || ((currentHeight<finalHeight) && (animateDif>0)))
	{
		var num=Math.max(currentHeight+animateDif,0);
		if (animateDif>0) num=Math.min(num,finalHeight);
		itm.style.height=num+'px';
		window.setTimeout(function () { animate(itm,finalHeight,animateDif,origOverflow,animateTicks,pic); } ,animateTicks);
	} else
	{
		itm.style.height='auto';
		if (animateDif<0)
		{
			itm.style.display='none';
		}
		itm.style.overflow=origOverflow;
		if (browser_matches('firefox')) itm.parentNode.style.overflow=''; // Stops weird issue on Firefox
		itm.style.outline='0';
		if (pic)
		{
			pic.src=((animateDif<0)?"{$IMG,expand}":"{$IMG,contract}").replace(/^http:/,window.location.protocol);
			pic.setAttribute('alt',pic.getAttribute('alt').replace((animateDif<0)?'{!CONTRACT;}':'{!EXPAND;}',(animateDif<0)?'{!EXPAND;}':'{!CONTRACT;}'));
			pic.setAttribute('title',(animateDif<0)?'{!EXPAND;}':'{!CONTRACT;}');
			refixImage(pic);
		}
		trigger_resize(true);
	}
}

function animateFrameLoad(pf,frame,leave_gap_top)
{
	if (!pf) return;
	if (typeof leave_gap_top=='undefined') var leave_gap_top=0;

	pf.style.height=window.top.getWindowHeight()+'px'; {$,Enough to stop jumping around}

	illustrateFrameLoad(pf,frame);

	var ifuob=window.top.document.getElementById('iframe_under');
	var extra=ifuob?((window!=window.top)?findPosY(ifuob):0):0;
	if (ifuob) ifuob.scrolling='no';

	if (window==window.top)
		window.top.smoothScroll(findPosY(pf)+extra-leave_gap_top);
}

function illustrateFrameLoad(pf,frame)
{
	{+START,IF,{$NOT,{$VALUE_OPTION,disable_animations}}}
		var head='<style type="text/css">',cssText='';
		if (!browser_matches('ie8'))
		{
			for (var i=0;i<document.styleSheets.length;i++)
			{
				try
				{
					if ((typeof document.styleSheets[i].href!='undefined') && (document.styleSheets[i].href) && (document.styleSheets[i].href.indexOf('/global')==-1)) continue;
					if (typeof document.styleSheets[i].cssText!='undefined')
					{
						cssText+=document.styleSheets[i].cssText;
					} else
					{
						var rules=[];
						try { rules=document.styleSheets[i].cssRules?document.styleSheets[i].cssRules:document.styleSheets[i].rules; }
						catch (e) {};
						if (rules)
						{
							for (var j=0;j<rules.length;j++)
							{
								if (rules[j].cssText)
									cssText+=rules[j].cssText+"\n\n";
								else
									cssText+=rules[j].selectorText+'{ '+rules[j].style.cssText+"}\n\n";
							}
						}
					}
				}
				catch (e){};
			}
		}
		head+=cssText+'<\/style>';

		if (!window.frames[frame]) return;
		if (!window.frames[frame].document) return;
		var doc=window.frames[frame].document;
		if (!doc) return;
		var de=doc.documentElement;
		if (!de) return;
		var body=de.getElementsByTagName('body');
		if (body.length==0)
		{
			setInnerHTML(de,'<head>'+head+'<\/head><body{$?,{$VALUE_OPTION,html5}, aria-busy="true"} class="re_body"><div class="spaced"><div class="ajax_tree_list_loading"><img id="loading_image" class="inline_image_2" src="'+'{$IMG*;,bottom/loading}'.replace(/^http:/,window.location.protocol)+'" alt="{!LOADING^;}" /> {!LOADING^;}<\/div><\/div><\/body>');
		} else
		{
			body[0].className='re_body';

			var head_element=de.getElementsByTagName('head')[0];
			if (!head_element)
			{
				head_element=document.createElement('head');
				de.appendChild(head_element);
			}

			if (de.getElementsByTagName('style').length==0) {$,The conditional is needed for Firefox - for some odd reason it is unable to parse any head tags twice}
				setInnerHTML(head_element,head);
			setInnerHTML(body[0],'<div{$?,{$VALUE_OPTION,html5}, aria-busy="true"} class="spaced"><div class="ajax_tree_list_loading"><img id="loading_image" class="inline_image_2" src="'+'{$IMG*;,bottom/loading}'.replace(/^http:/,window.location.protocol)+'" alt="{!LOADING^;}" /> {!LOADING^;}<\/div><\/div>');
		}
		var the_frame=window.frames[frame];
		window.setTimeout( // Stupid workaround for Google Chrome not loading an image on unload even if in cache
			function() {
				if (the_frame.document && the_frame.document.getElementById('loading_image'))
				{
					var i_new=document.createElement('img');
					i_new.src=the_frame.document.getElementById('loading_image').src;
					var i_default=the_frame.document.getElementById('loading_image');
					if (i_default)
					{
						i_new.className=i_default.className;
						i_new.alt=i_default.alt;
						i_new.id=i_default.id;
						i_default.parentNode.replaceChild(i_new,i_default);
					}
				}
			},
			0
		);
		var style=de.getElementsByTagName('style')[0];
		if ((style) && (style.styleSheet)) style.styleSheet.cssText=cssText; {$,For IE}
	{+END}
}

function smoothScroll(destY,expectedScrollY,dir,eventAfter)
{
	{+START,IF,{$VALUE_OPTION,disable_animations}}
		try
		{
			window.scrollTo(0,destY);
		}
		catch (e) {};
		return;
	{+END}

	var scrollY;
	if (typeof window.scrollY=='undefined') scrollY=document.documentElement.scrollTop; /*IE6*/ else scrollY=window.scrollY;
	if (typeof destY=='string') destY=findPosY(document.getElementById(destY));
	if (destY<0) destY=0;

	if ((typeof expectedScrollY!="undefined") && (expectedScrollY!=null) && (expectedScrollY!=scrollY)) return; {$,We must terminate, as the user has scrolled during our animation and we do not want to interfere with their action -- or because our last scroll failed, due to us being on the last scroll screen already}
	if (typeof dir=='undefined' || !null) var dir=((destY-scrollY)>0)?1:-1;
	var dist=dir*17;
	if (((dir==1) && (scrollY+dist>=destY)) || ((dir==-1) && (scrollY+dist<=destY)) || ((destY-scrollY)*dir>2000))
	{
		try
		{
			window.scrollTo(0,destY);
		}
		catch (e) {};
		if (eventAfter) eventAfter();
		return;
	}
	try
	{
		window.scrollBy(0,dist);
	}
	catch (e) {}; // May be stopped by popup blocker

	if (typeof window.scrollY=='undefined') scrollY=document.documentElement.scrollTop; /*IE6*/ else scrollY=window.scrollY;
	window.setTimeout(function() { smoothScroll(destY,scrollY,dir,eventAfter); } , 30);
}

function abstractGetComputedStyle(obj,property)
{
	if (obj.currentStyle)
	{
		var index=property.indexOf('-');
		if (index!=-1)
		{
			property=property.substring(0,index)+property.substring(index+1,index+2).toUpperCase()+property.substring(index+2,property.length);
		}
		return obj.currentStyle[property];
	}

	var ret=null;
	try {
		ret=document.defaultView.getComputedStyle(obj,null).getPropertyValue(property);
	}
	catch(e) {  }

	return ret;
}

{$,Helper to change class on checkbox check}
function changeClass(box,theId,to,from)
{
	var cell=document.getElementById(theId);
	if (!cell) cell=theId;
	cell.className=(box.checked)?to:from;
}

{$,Dimension functions}
function getMouseXY(e)
{
	window.mouseX=getMouseX(e);
	window.mouseY=getMouseY(e);
	window.ctrlPressed=e.ctrlKey;
	window.altPressed=e.altKey;
	window.metaPressed=e.metaKey;
	window.shiftPressed=e.shiftKey;
	return true
}
function getMouseX(event)
{
	try
	{
		if ((typeof event.pageX!='undefined') && (event.pageX))
		{
			return event.pageX;
		} else if ((typeof event.clientX!='undefined')&& (event.clientX))
		{
			return event.clientX+getWindowScrollX()
		}
	}
	catch (err) {}
	return 0;
}
function getMouseY(event)
{
	try
	{
		if ((typeof event.pageY!='undefined') && (event.pageY))
		{
			return event.pageY;
		} else if ((typeof event.clientY!='undefined') && (event.clientY))
		{
			return event.clientY+getWindowScrollY()
		}
	}
	catch (err) {}
	return 0;
}
function getWindowWidth()
{
	if (typeof window.innerWidth!='undefined') return window.innerWidth-18;
	if ((document.documentElement) && (document.documentElement.clientWidth)) return document.documentElement.clientWidth;
	if ((document.body) && (document.body.clientWidth)) return document.body.clientWidth;
	return 0;
}
function getWindowHeight()
{
	if (typeof window.innerHeight!='undefined') return window.innerHeight-18;
	if ((document.documentElement) && (document.documentElement.clientHeight)) return document.documentElement.clientHeight;
	if ((document.body) && (document.body.clientHeight)) return document.body.clientHeight;
	return 0;
}
function getWindowScrollWidth(win)
{
	if (typeof win=='undefined') var win=window;
	return win.document.body.scrollWidth;
}
function getWindowScrollHeight(win)
{
	if (typeof win=='undefined') var win=window;
	var best=win.document.body.parentNode.offsetHeight;
	if (((win.document.body.offsetHeight>best) && (win.document.body.offsetHeight!=150)) || (best==150)) best=win.document.body.offsetHeight;
	if (((win.document.body.parentNode.scrollHeight/*>best*/ /*on IE the offsetHeight is 4px too much*/) && (win.document.body.parentNode.scrollHeight!=150)) || (best==150)) best=win.document.body.parentNode.scrollHeight;
	if (((win.document.body.scrollHeight>best) && (best<150) && (win.document.body.scrollHeight!=150)) || (best==150)) best=win.document.body.scrollHeight;
	return best;
}
function getWindowScrollX()
{
  	if (typeof window.pageXOffset!='undefined') return window.pageXOffset;
  	if ((document.documentElement) && (document.documentElement.scrollLeft)) return document.documentElement.scrollLeft;
  	if ((document.body) && (document.body.scrollLeft)) return document.body.scrollLeft;
  	if (typeof window.scrollX!='undefined') return window.scrollX;
	return 0;
}
function getWindowScrollY()
{
  	if (typeof window.pageYOffset!='undefined') return window.pageYOffset;
  	if ((document.documentElement) && (document.documentElement.scrollTop)) return document.documentElement.scrollTop;
  	if ((document.body) && (document.body.scrollTop)) return document.body.scrollTop;
  	if (typeof window.scrollTop!='undefined') return window.scrollTop;
	return 0;
}
function findPosX(obj,notRelative) {$,Courtesy of quirksmode}	/* if notRelative is true it gets the position relative to the browser window, else it will be relative to the most recent position:absolute/relative going up the element tree */
{
	if (!obj && typeof window.console!='undefined') { console.log(findPosX.caller); return 0; }
	var call_obj=obj;

	var curleft=0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			if (((abstractGetComputedStyle(obj,'position')=='absolute') || (abstractGetComputedStyle(obj,'position')=='relative')) && (!notRelative))
			{
				if (obj==call_obj) curleft+=obj.offsetLeft;
				break;
			}
			curleft+=obj.offsetLeft;
			obj=obj.offsetParent;
		}
	}
	else if (typeof obj.x!='undefined') curleft+=obj.x;
	return curleft;
}
function findPosY(obj,notRelative) {$,Courtesy of quirksmode}	/* if notRelative is true it gets the position relative to the browser window, else it will be relative to the most recent position:absolute/relative going up the element tree */
{
	if (!obj && typeof window.console!='undefined') { console.log(findPosY.caller); return 0; }
	var call_obj=obj;

	var curtop=0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			if (((abstractGetComputedStyle(obj,'position')=='absolute') || (abstractGetComputedStyle(obj,'position')=='relative')) && (!notRelative))
			{
				if (obj==call_obj) curtop+=obj.offsetTop;
				break;
			}
			curtop+=obj.offsetTop;
			obj=obj.offsetParent;
		}
	}
	else if (typeof obj.y!='undefined') curtop+=obj.y;
	return curtop;
}
function findWidth(obj,takePadding,takeMargin,takeBorder)
{
	if (!obj) return 0;
	var ret=obj.offsetWidth;
	if (takePadding)
	{
		ret-=sts(abstractGetComputedStyle(obj,'padding-left'));
		ret-=sts(abstractGetComputedStyle(obj,'padding-right'));
	}
	if (takeMargin)
	{
		ret-=sts(abstractGetComputedStyle(obj,'margin-left'));
		ret-=sts(abstractGetComputedStyle(obj,'margin-right'));
	}
	if (takeBorder)
	{
		ret-=sts(abstractGetComputedStyle(obj,'border-left-width'));
		ret-=sts(abstractGetComputedStyle(obj,'border-right-width'));
	}
	return ret;
}
function findHeight(obj,takePadding,takeMargin,takeBorder)
{
	if (!obj) return 0;
	var ret=obj.offsetHeight;
	if (takePadding)
	{
		ret-=sts(abstractGetComputedStyle(obj,'padding-top'));
		ret-=sts(abstractGetComputedStyle(obj,'padding-bottom'));
	}
	if (takeMargin)
	{
		ret-=sts(abstractGetComputedStyle(obj,'margin-top'));
		ret-=sts(abstractGetComputedStyle(obj,'margin-bottom'));
	}
	if (takeBorder)
	{
		ret-=sts(abstractGetComputedStyle(obj,'border-top-width'));
		ret-=sts(abstractGetComputedStyle(obj,'border-bottom-width'));
	}
	return ret;
}

function enter_pressed(event,altChar)
{
	if (typeof event=='undefined') var event=window.event;
	if ((altChar) && (((event.which) && (event.which==altChar.charCodeAt(0))) || ((event.keyCode) && (event.keyCode==altChar.charCodeAt(0))))) return true;
	return (((event.which) && (event.which==13)) || ((event.keyCode) && (event.keyCode==13)));
}

{$,Takes literal or list of unicode key character codes or case insensitive letters as characters or numbers as characters or supported lower case symbols}
function key_pressed(event,key,no_error_if_bad)
{
	if (typeof event=='undefined') var event=window.event;

	if (typeof window.anykeyokay=='undefined') window.anykeyokay=false;

	if (key.constructor==Array)
	{
		for (var i=0;i<key.length;i++)
		{
			if (key[i]==null) {$,This specifies that control characters allowed (arrow keys, backspace, etc)}
			{
				if ((event.keyCode) && ((window.anykeyokay) || (event.keyCode<48) || (event.keyCode==86) || (event.keyCode==91) || (event.keyCode==224)) && (event.keyCode!=32))
				{
					window.anykeyokay=true;
					window.setTimeout( function() { window.anykeyokay=false; } , 5); // In case of double event for same keypress
					return true;
				}
			} else
			{
				if (key_pressed(event,key[i])) return true;
			}
		}

		var targ;
		if (typeof event.target!='undefined') targ=event.target;
		else targ=event.srcElement;
		if (!no_error_if_bad)
		{
			var current_bg=abstractGetComputedStyle(targ,'background');
			if ((typeof current_bg=='undefined') || (current_bg)) current_bg='white';
			if (current_bg!='#FF8888')
				window.setTimeout( function() { targ.style.background=current_bg; } , 400);
			targ.style.background='#FF8888';
		}
		return false;
	}

	{$,Special cases}
	if ((key=='-') && (event.keyCode==189)) key=189; {$,Safari}
	if ((key==190) && (event.keyCode==110)) key=110; {$,Keypad '.'}
	if (key=='-') key=109;
	if ((key=='_') && (event.keyCode==189)) key=189; {$,Safari}
	else if (key=='_') key=0; {$,This one is a real shame as the key code 0 is shared by lots of symbols}

	{$,Where we have an ASCII correspondance or can automap to one}
	if (key.constructor==String) {$,NB we are not case sensitive on letters. And we cannot otherwise pass in characters that need shift pressed.}
	{
		if ((event.shiftKey) && (key.toUpperCase()==key.toLowerCase())) return false; {$,We are not case sensitive on letters but otherwise we have no way to map the shift key. As we have to assume shift is not pressed for any ASCII based symbol conversion (keycode is same whether shift pressed or not) we cannot handle shifted ones.}

		key=key.toUpperCase().charCodeAt(0);

		if ((event.keyCode) && (event.keyCode>=96) && (event.keyCode<106) && (key>=48) && (key<58)) key+=48; {$,Numeric keypad special case}
	}

	return ((typeof event.keyCode!="undefined") && (event.keyCode==key));
}

{$,Tooltips that can work on any element with rich HTML support}
{$, ac is the object to have the tooltip}
{$, myevent is the event handler}
{$, tooltip is the text for the tooltip}
{$, width is in pixels (but you need 'px' on the end), can be null or auto but both of these will actually instead result in the default max-width of 360px}
{$, pic is the picture to show in the top-left corner of the tooltip; should be around 30px x 30px}
{$, height is the maximum height of the tooltip for situations where an internal but unusable scrollbar is wanted}
{$, bottom is set to true if the tooltip should definitely appear upwards; rarely use this}
{$, no_delay is set to true if the tooltip should appear instantly}
{$, lights_off is set to true if the image is to be dimmed}
{$, force_width is set to true if you want width to not be a max width}
function activateTooltip(ac,myevent,tooltip,width,pic,height,bottom,no_delay,lights_off,force_width)
{
	if (!pageLoaded) return;
	if ((typeof tooltip!='function') && (tooltip=='')) return;

	// Delete other tooltips, which due to browser bugs can get stuck
	var existing_tooltips=get_elements_by_class_name(document.body,'ocp_tooltip');
	for (var i=0;i<existing_tooltips.length;i++)
	{
		if (existing_tooltips[i].id!=ac.tooltipId) existing_tooltips[i].parentNode.removeChild(existing_tooltips[i]);
	}

	ac.is_over=true;
	ac.tooltip_on=false;
	ac.initial_width=width;

	var children=ac.getElementsByTagName('img');
	for (var i=0;i<children.length;i++) children[i].setAttribute('title','');

	var tooltipElement;
	if ((typeof ac.tooltipId!='undefined') && (document.getElementById(ac.tooltipId)))
	{
		tooltipElement=document.getElementById(ac.tooltipId);
		setInnerHTML(tooltipElement,'');
		repositionTooltip(ac,myevent,bottom,true,tooltipElement,force_width);
	} else
	{
		tooltipElement=document.createElement("div");
		tooltipElement.role='tooltip';
		tooltipElement.style.display='none';
		tooltipElement.className="ocp_tooltip";
		if (ac.className.substr(0,3)=='tt_') tooltipElement.className+=' '+ac.className;
		tooltipElement.style.width=width;
		if ((!browser_matches('ie_old')) && (height)) { if (height!='auto') tooltipElement.style.maxHeight=height; tooltipElement.style.overflow='auto'; }
		tooltipElement.style.position='absolute';
		tooltipElement.id=Math.floor(Math.random()*1000);
		ac.tooltipId=tooltipElement.id;
		repositionTooltip(ac,myevent,bottom,true,tooltipElement,force_width);
		document.body.appendChild(tooltipElement);
	}

	if (pic)
	{
		var img=document.createElement('img');
		img.src=pic;
		img.className='tooltip_img';
		if (lights_off) setOpacity(img,0.2);
		tooltipElement.appendChild(img);
		tooltipElement.style.paddingRight='30px';
	}

	var myevent_copy;
	try {
		myevent_copy={ {$,Needs to be copied as it will get erased on IE after this function ends}
			'pageX': myevent.pageX,
			'pageY': myevent.pageY,
			'clientX': myevent.clientX,
			'clientY': myevent.clientY,
			'type': myevent.type
		};
	}
	catch (e) { {$,Can happen if IE has lost the event}
		myevent_copy={
			'pageX': 0,
			'pageY': 0,
			'clientX': 0,
			'clientY': 0,
			'type': ''
		};
	}

	window.setTimeout(function() {
		if (!ac.is_over) return;

		if (typeof tooltip=='function') tooltip=tooltip();
		if (tooltip=='') return;

		if (!ac.tooltip_on) setInnerHTML(tooltipElement,tooltip,true);

		ac.tooltip_on=true;
		tooltipElement.style.display='block';

		repositionTooltip(ac,myevent_copy,bottom,true,tooltipElement,force_width);
	}, no_delay?10:666);
}
function repositionTooltip(ac,event,bottom,starting,tooltipElement,force_width)
{
	if ((!starting) || (browser_matches('opera'))) // Real JS mousemove event, so we assume not a screen reader and have to remove natural tooltip
	{
		if (ac.getAttribute('title')) ac.setAttribute('title','');
		if ((ac.parentNode.nodeName.toLowerCase()=='a') && (ac.parentNode.getAttribute('title')) && ((ac.nodeName.toLowerCase()=='abbr') || (ac.parentNode.getAttribute('title').indexOf('{!LINK_NEW_WINDOW^;}')!=-1)))
			ac.parentNode.setAttribute('title',''); {$,Do not want second tooltips that are not useful}
	}

	if (!pageLoaded) return;
	if (!ac.tooltipId) { if ((typeof ac.onmouseover!='undefined') && (ac.onmouseover)) ac.onmouseover(event); return; };  {$,Should not happen but written as a fail-safe}

	if ((typeof tooltipElement=='undefined') || (!tooltipElement)) var tooltipElement=document.getElementById(ac.tooltipId);
	if (tooltipElement)
	{
		var width=findWidth(tooltipElement);
		if ((tooltipElement.style.maxWidth) && (tooltipElement.style.maxWidth.indexOf('px')!=-1)) width=window.parseInt(tooltipElement.style.maxWidth.replace('px',''));
		if (tooltipElement.style.width.indexOf('px')!=-1) width=window.parseInt(tooltipElement.style.width.replace('px',''));
		if ((!width) || ((tooltipElement.style.width=='auto') && (width<200))) width=360;
		var height=findHeight(tooltipElement);

		var x=(getMouseX(event)+10);
		var y=(getMouseY(event)+10);
		try
		{
			if (typeof event.type!='undefined')
			{
				if (event.type!='focus') ac.done_none_focus=true;
				if ((event.type=='focus') && (ac.done_none_focus)) return;
				x=(event.type=='focus')?(getWindowScrollX()+getWindowWidth()/2):(getMouseX(event)+10);
				y=(event.type=='focus')?(getWindowScrollY()+getWindowHeight()/2-40):(getMouseY(event)+10);
			}
		}
		catch(ignore) {};

		if ((!browser_matches('ie_old')) && (!force_width))
		{
			tooltipElement.style.maxWidth=width+'px';
			tooltipElement.style.width='auto'; {$,Needed for Opera, else it uses maxWidth for width too}
		} else
		{
			tooltipElement.style.width=width+'px';
		}

		var _width=findWidth(tooltipElement);
		if ((_width==0) || (_width>width)) _width=width;
		var x_excess=x-getWindowWidth()-getWindowScrollX()+_width+20;
		if (x_excess>0) {$,Either we explicitly gave too much width, or the width auto-calculated exceeds what we THINK is the maximum width in which case we have to re-compensate with an extra contingency to stop CSS/JS vicious disagreement cycles}
		{
			x-=x_excess+20;
		}
		if (bottom)
		{
			tooltipElement.style.top=(y-height)+'px';
		} else
		{
			var y_excess=y-getWindowHeight()-getWindowScrollY()+height+10;
			if (y_excess>0) y-=y_excess;
			var scrollY=getWindowScrollY();
			if (y<scrollY) y=scrollY;
			tooltipElement.style.top=y+'px';
		}
		tooltipElement.style.left=x+'px';
	}
}
function deactivateTooltip(ac,event)
{
	ac.is_over=false;

	if ((!pageLoaded) || (!ac.tooltipId)) return;

	var tooltipElement=document.getElementById(ac.tooltipId);
	if (tooltipElement) tooltipElement.style.display='none';
}

function resizeFrame(name,minHeight)
{
	if (typeof minHeight=='undefined') var minHeight=0;
	var frame_element=document.getElementById(name);
	var frame_window;
	if (typeof window.frames[name]!='undefined') frame_window=window.frames[name]; else if (parent && parent.frames[name]) frame_window=parent.frames[name]; else return;
	if ((frame_element) && (frame_window) && (frame_window.document) && (frame_window.document.body))
	{
		var h=getWindowScrollHeight(frame_window);
		if ((h==0) && (frame_element.parentNode.style.display=='none'))
		{
			h=((typeof minHeight=='undefined') || (minHeight==0))?100:minHeight;
			if (frame_window.parent) window.setTimeout(function() { if (frame_window.parent) frame_window.parent.trigger_resize(); },0);
		}
		if (h+'px'!=frame_element.style.height)
		{
			if (frame_element.scrolling!='auto')
			{
				frame_element.style.height=((h>=minHeight)?h:minHeight)+'px';
				if (frame_window.parent) window.setTimeout(function() { if (frame_window.parent) frame_window.parent.trigger_resize(); },0);
				frame_element.scrolling='no';
				frame_window.onscroll=function(event) { if (typeof event=='undefined') var event=window.event; if (event==null) return false; try { frame_window.scrollTo(0,0); } catch (e) {}; return cancelBubbling(event); }; {$,Needed for Opera}
			}
		}
	}
}
function trigger_resize(and_subframes)
{
	if (typeof window.parent=='undefined') return;
	if (typeof window.parent.document=='undefined') return;
	var frames=window.parent.document.getElementsByTagName('iframe');
	var done=false;

	for (var i=0;i<frames.length;i++)
	{
		if ((frames[i].src==window.location.href) || (frames[i].contentWindow==window) || ((typeof window.parent.frames[frames[i].id]!="undefined") && (window.parent.frames[frames[i].id]==window)))
		{
			if (frames[i].style.height=='900px') frames[i].style.height='auto';
			window.parent.resizeFrame(frames[i].name);
		}
	}

	if (and_subframes)
	{
		frames=document.getElementsByTagName('iframe');
		for (var i=0;i<frames.length;i++)
			if ((frames[i].name!='') && ((frames[i].className.indexOf('expandable_iframe')!=-1) || (frames[i].className.indexOf('dynamic_iframe')!=-1))) resizeFrame(frames[i].name);
	}
}

{$,Marking things (to avoid illegally nested forms)}
function addFormMarkedPosts(work_on,prefix)
{
	var get=work_on.getAttribute('method').toLowerCase()=='get';
	var elements=document.getElementsByTagName('input');
	var i;
	var append='';
	if (get)
	{
		for (i=0;i<work_on.elements.length;i++)
		{
			if (work_on.elements[i].name.match(new RegExp('&'+prefix.replace('_','\_')+'\d+=1$','g')))
			{
				work_on.elements[i].parentNode.removeChild(work_on.elements[i]);
			}
		}
	} else
	{
		{$,Strip old marks out of the URL}
		work_on.action=work_on.action.replace('?','&');
		work_on.action=work_on.action.replace(new RegExp('&'+prefix.replace('_','\_')+'\d+=1$','g'),'');
		work_on.action=work_on.action.replace('&','?'); {$,will just do first due to how JS works}
	}
	for (i=0;i<elements.length;i++)
	{
		if ((elements[i].type=='checkbox') && (elements[i].name.substring(0,prefix.length)==prefix) && (elements[i].checked))
			append+=(((append=='') && (work_on.action.indexOf('?')==-1) && (work_on.action.indexOf('/pg/')==-1) && (!get))?'?':'&')+elements[i].name+'=1';
	}
	if (get)
	{
		var bits=append.split('&');
		for (i=0;i<bits.length;i++)
		{
			if (bits[i]!='')
			{
				var hidden=document.createElement('input');
				hidden.name=bits[i].substr(0,bits[i].indexOf('=1'));
				hidden.value='1';
				hidden.type='hidden';
				work_on.appendChild(hidden);
			}
		}
	} else
	{
		work_on.action+=append;
	}
	return append!='';
}
function markAllTopics(event)
{
	var e=document.getElementsByTagName('input');
	var i;
	for (i=0;i<e.length;i++)
	{
		if ((e[i].type=='checkbox') && (e[i].name.substr(0,5)=='mark_'))
		{
			e[i].checked=!e[i].checked;
			e[i].onclick(event);
		}
	}
}

function setOpacity(element,fraction)
{
	if ((typeof element.faderKey!='undefined') && (element.faderKey) && (typeof window.thumbFadeTimers!='undefined') && (thumbFadeTimers[element.faderKey]))
	{
		try // Cross-frame issues may cause error
		{
			window.clearTimeout(thumbFadeTimers[element.faderKey]);
		}
		catch (e) {};
		thumbFadeTimers[element.faderKey]=null;
	}

	if (typeof element.style.opacity!='undefined')
	{
		element.style.opacity=fraction;
		return;
	}
	if ((typeof element.filters!='undefined') && (typeof element.filters!='unknown') && (typeof element.filters['DXImageTransform.Microsoft.Alpha']!='undefined'))
	{
		element.filters['DXImageTransform.Microsoft.Alpha'].opacity=fraction*100;
		element.filters['DXImageTransform.Microsoft.Alpha'].enabled=1;
	} else
	{
		element.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity='"+parseInt(fraction*100)+"')";
	}
	if (element.src) fixImage(element,true);
}

{$,PNG hack, Loosely by PieNG (http://dynarch.com/mishoo/articles.epl?art_id=430)}
{$,Limitations: no CSS imgs}
function fixImages()
{
	for(var i=0;i<document.images.length;i++) fixImage(document.images[i]);
	//var inputs=document.getElementsByTagName('input');
	//for(var i=0;i<inputs.length;i++) fixImage(inputs[i]);

	addEventListenerAbstract(window,"beforeprint",function() { unfixImages(); } );
	addEventListenerAbstract(window,"afterprint",function() { fixImages(); } );
}
function unfixImages()
{
	for(var i=0;i<document.images.length;i++) unfixImage(document.images[i]);
	var inputs=document.getElementsByTagName('input');
	for(var i=0;i<inputs.length;i++) unfixImage(inputs[i]);
}
function unfixImage(img,keep_src)
{
	if (typeof img.origsrc!='undefined')
	{
		if (!keep_src) img.src=img.origsrc;
		img.filters.filter='';
		img.style.filter=null;
	}
}
function refixImage(img)
{
	unfixImage(img,true);
	fixImage(img);
}
function fixImage(img,force_ie8)
{
	if (force_ie8)
	{
		if (!browser_matches('no_alpha_ie_with_opacity')) return;
	} else
	{
		if (!browser_matches('no_alpha_ie')) return;
	}
	if (img.src) return;
	if (window.location.href.indexOf('keep_noiepng')!=-1) return;
	if (img.className.indexOf('no_alpha')!=-1) return;

	var imgName=img.src.toUpperCase();
	if ((imgName.substring(imgName.length-3,imgName.length)=="PNG"){+START,IF,{$NOT,{$CONFIG_OPTION,httpauth_is_enabled}}} || (imgName.indexOf(".PHP")!=-1){+END})  {$,The IE filters do not support http-auth, so pushing authenticated .php scripts through that would cause errors}
	{
		if ((!img.style.filter) || (img.style.filter=='null' /* Bizarre IE! */))
		{
			img.origsrc=img.src;
			img.width=img.width; img.height=img.height; {$,Yes I am not kidding - this is 'fixing' a property to its temporary virtual property}
			if ((img.currentStyle) && ((browser_matches('ie5')) || (!img.width) || (!img.height) || (((img.currentStyle['max-width']) || (img.currentStyle['max-height'])))))
			{
				if (!img.style.width)
				{
					var width=findWidth(img);
					var dif=-sts(abstractGetComputedStyle(img,'padding-left'))-sts(abstractGetComputedStyle(img,'padding-right'));
					if ((img.currentStyle['max-width']) && ((width==0) || (sts(img.currentStyle['max-width'])<width))) width=sts(img.currentStyle['max-width']);
					if ((img.currentStyle['width']) && ((width==0) || ((sts(img.currentStyle['width'])!=0) && (sts(img.currentStyle['width'])<width)))) width=sts(img.currentStyle['width']);
					if (width!=0) img.style.width=(width+dif)+'px';
				}
				if (!img.style.height)
				{
					var height=findHeight(img);
					var dif=-sts(abstractGetComputedStyle(img,'padding-top'))-sts(abstractGetComputedStyle(img,'padding-bottom'));
					if ((img.currentStyle['max-height']) && ((height==0) || (sts(img.currentStyle['max-height'])<height))) height=sts(img.currentStyle['max-height']);
					if ((img.currentStyle['height']) && ((height==0) || ((sts(img.currentStyle['height'])!=0) && (sts(img.currentStyle['height'])<height)))) height=sts(img.currentStyle['height']);
					if (height!=0) img.style.height=(height+dif)+'px';
				}
			}
			img.src="{$BASE_URL#,0}".replace(/^http:/,window.location.protocol)+"/themes/default/images/blank.gif";
			var new_filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+img.origsrc+"',sizingMethod='"+(((img.style.width) || (img.style.height))?'scale':'image')+"')";
			img.style.filter=new_filter;

			// Transfer padding to margins, as the filter makes it lost
			img.style.marginLeft=(sts(abstractGetComputedStyle(img,'padding-left'))+sts(abstractGetComputedStyle(img,'margin-left')))+'px';
			img.style.marginRight=(sts(abstractGetComputedStyle(img,'padding-right'))+sts(abstractGetComputedStyle(img,'margin-right')))+'px';
			img.style.marginTop=(sts(abstractGetComputedStyle(img,'padding-top'))+sts(abstractGetComputedStyle(img,'margin-top')))+'px';
			img.style.marginBottom=(sts(abstractGetComputedStyle(img,'padding-bottom'))+sts(abstractGetComputedStyle(img,'margin-bottom')))+'px';

			if ((img.title) && (img.title!=''))
			{
				var title=img.title;
				img.attachEvent("onmousemove",function() { repositionTooltip(img,event); });
				img.attachEvent("onmouseout",function() { deactivateTooltip(img,event); });
				img.attachEvent("onmouseover",function() { activateTooltip(img,event,title,'auto'); });
				img.title="";
			}
		}
	}
}

{$,Event listeners}
{$,Note that the 'this' object cannot be relied on, as it will not work in IE - pass it in implicitly bound into the scope of your defined func via a pre-called surrounder function}
function addEventListenerAbstract(element,the_event,func,capture)
{
	if(element)
	{
		if ((element==window) && ((the_event=='load') || (the_event=='real_load')) && (pageLoaded))
		{
			window.setTimeout(func,0);
			return true;
		}

		if (typeof element.simulated_events=='undefined') element.simulated_events=[];
		try
		{
			if (typeof element.simulated_events[the_event]=='undefined') element.simulated_events[the_event]=[];
			element.simulated_events[the_event].push(func);
		}
		catch (e) // If was created by closed popup window can make "callee is not available" error in IE
		{
			element.simulated_events=[];
			element.simulated_events[the_event]=[];
			element.simulated_events[the_event].push(func);
		}

		if(typeof element.addEventListener!='undefined')
		{
			{$,W3C}
			if (the_event=='load') // Try and be smarter
			{
				element.addEventListener('DOMContentLoaded',function() { window.ranD=true; window.setTimeout(func,0); },capture);
				return element.addEventListener(the_event,function() { if (!window.ranD) window.setTimeout(func,0); },capture);
			}
			if (the_event=='real_load') the_event='load';
			return element.addEventListener(the_event,func,capture);
		}
		else if(typeof element.attachEvent!='undefined')
		{
			{$,Microsoft - no capturing :(}
			if (the_event=='real_load') the_event='load';
			return element.attachEvent("on"+the_event,func);
		}
		else return false;
	}
	else return false;
}
function cancelBubbling(event,for_element)
{
	if ((typeof for_element=='undefined') || (!for_element)) var for_element='';

	if (typeof event=='undefined') var event=window.event;
	if (typeof event=='undefined' || !event) return false;

	var src=(typeof event.srcElement!='undefined' && event.srcElement)?event.srcElement:event.target;
	if (!src) return false;

	if ((src.nodeName) && (src.nodeName.toLowerCase()==for_element) || (for_element==''))
	{
		if (typeof event.stopPropagation!='undefined') event.stopPropagation();
		event.cancelBubble=true;
		return true;
	}
	return false;
}

function maintain_theme_in_link(url)
{
	if (url.indexOf('&utheme=')!=-1) return url;
	if (url.indexOf('?utheme=')!=-1) return url;
	if (url.indexOf('&keep_theme=')!=-1) return url;
	if (url.indexOf('?keep_theme=')!=-1) return url;

	if (typeof window.ocp_theme=='undefined') window.ocp_theme='{$THEME;}';
	if (typeof window.ocp_theme!='undefined')
	{
		if (url.indexOf('?')==-1) url+='?'; else url+='&';
		url+='utheme='+window.encodeURIComponent(window.ocp_theme);
	}
	return url;
}

function keep_stub(starting_query_string) {$,Skip param to make always start with &}
{
	var to_add='',i;
	var search=(window.location.search=='')?'?':window.location.search.substr(1);
	var bits=search.split('&');
	var done_session=false;
	var gap_symbol;
	for (i=0;i<bits.length;i++)
	{
		if (bits[i].substr(0,5)=='keep_')
		{
			gap_symbol=(((to_add=='') && (starting_query_string))?'?':'&');
			to_add=to_add+gap_symbol+bits[i];
			if (bits[i].substr(0,13)=='keep_session=') done_session=true;
		}
	}
	if (!done_session)
	{
		var session=ReadCookie('ocp_session');
		gap_symbol=(((to_add=='') && (starting_query_string))?'?':'&');
		if (session) to_add=to_add+gap_symbol+'keep_session='+window.encodeURIComponent(session);
	}
	return to_add;
}

{$,XHTML equivalents for HTML manipulation functions}

function getOuterHTML(element)
{
	return getInnerHTML(element,true);
}

function getInnerHTML(element,outerToo)
{
	// recursively copy the DOM into a string
	function Copy(srcDomNode, level) {
		var out='';

		if (typeof level == "undefined") level=1;
		if (level>1) {

			if (srcDomNode.nodeType==1) {

				// element node
				var thisNode=document.createElement(srcDomNode.nodeName);
				out+='<'+thisNode.nodeName;

				// attributes
				var cleaned_attributes=[];
				for (var a=0,attr=srcDomNode.attributes.length;a<attr;a++) {
					var aName=srcDomNode.attributes[a].name,aValue=srcDomNode.attributes[a].value;
					cleaned_attributes[aName]=aValue;
				}
				if (browser_matches('no_alpha_ie'))
				{
					if ((typeof cleaned_attributes['src']!='undefined') && (typeof cleaned_attributes['origsrc']!='undefined'))
					{
						cleaned_attributes['src']=cleaned_attributes['origsrc'];
						cleaned_attributes['width']=null;
						cleaned_attributes['height']=null;
						cleaned_attributes['origsrc']=null;
					}
				}
				for (var a=0,attr=srcDomNode.attributes.length;a<attr;a++) {
					var aName=srcDomNode.attributes[a].name,aValue=cleaned_attributes[aName];
					if (
						(aValue!==null) &&
						(aName!='complete') &&
						(aName!='simulated_events') && // ocp, expando
						(((aName.substr(0,2)!='on') && (aName!='cite') && (aName!='nofocusrect') && (aName!='width') && (aName!='height') && (aName!='cache') && (aName!='dataFld') && (aName!='dataFormatAs') && (aName!='dataSrc') && (aName!='implementation') && (aName!='style')) || (aValue!='null')) &&
						((aName!='start') || (aValue!='fileopen')) &&
						((aName!='loop') || (aValue!='1')) &&
						(((aName!='width') && (aName!='height') && (aName!='tabIndex') && (aName!='hspace') && (aName!='vspace')) || (aValue!='0')) &&
						(((aName!='noWrap') && (aName!='readOnly') && (aName!='indeterminate') && (aName!='hideFocus') && (aName!='disabled') && (aName!='isMap')) || (aValue!='false')) &&
						((aName!='contentEditable') || (aValue!='inherit')) &&
						(((aName.substr(0,6)!='border') && (aName!='dateTime') && (aName!='scope') && (aName!='clear') && (aName!='bgColor') && (aName!='vAlign') && (aName!='chOff') && (aName!='ch') && (aName!='height') && (aName!='width') && (aName!='axis') && (aName!='headers') && (aName!='background') && (aName!='accept') && (aName!='language') && (aName!='longDesc') && (aName!='border') && (aName!='dataFld') && (aName!='dataFormatAs') && (aName!='dataSrc') && (aName!='lang') && (aName!='id') && (aName!='name') && (aName!='dir') && (aName!='accessKey') && (aName!='dynsrc') && (aName!='vrml') && (aName!='align') && (aName!='useMap') && (aName!='lowsrc')) || (aValue!=''))
					)
						out+=' '+aName+'="'+escape_html(aValue)+'"';
				}

				if (srcDomNode.childNodes.length>0)
				{
					out+='>';

					// do child nodes
					for (var i=0,j=srcDomNode.childNodes.length;i<j;i++)
					{
						if ((srcDomNode.childNodes[i].id!='_firebugConsole') && (srcDomNode.childNodes[i].type!='application/x-googlegears'))
							out+=Copy(srcDomNode.childNodes[i],level+1);
					}

					out+='</'+thisNode.nodeName+'>';
				} else
				{
					out+=' />';
				}
			}
			else if (srcDomNode.nodeType==3) {
				// text node
				out+= (srcDomNode.nodeValue?srcDomNode.nodeValue:"");
			}
			else if (srcDomNode.nodeType == 4) {
				// text node
				out+=(srcDomNode.nodeValue?"<![CDATA["+srcDomNode.nodeValue+"]]":"");
			}
		} else
		{
			// do child nodes
			for (var i=0,j=srcDomNode.childNodes.length;i<j;i++)
			{
				if ((srcDomNode.childNodes[i].id!='_firebugConsole') && (srcDomNode.childNodes[i].type!='application/x-googlegears'))
					out+=Copy(srcDomNode.childNodes[i],level+1);
			}
		}

		return out;
	}

	return Copy(element,outerToo?2:1);
}

{$, Originally written by Optimal Works, http://www.optimalworks.net/ }
{$,Remove common XHTML entities so they can be placed into an XML parser that will not support non-recognised ones}
function EntitiesToUnicode(din)
{
	if ((!din.replace) || (din.indexOf('&')==-1)) return din;

	if (typeof window.entity_rep_reg=='undefined')
	{
		var reps={'amp':38,'gt':62,'lt':60,'quot':34,'hellip':8230,'middot':183,'ldquo':8220,'lsquo':8216,'rdquo':8221,'rsquo':8217,'mdash':8212,'ndash':8211,'nbsp':160,'times':215,
		'harr':8596,'lsaquo':8249,'rsaquo':8250,'euro':8364,'pound':163,'bull':8226,'copy':169,'trade':8482,'dagger':8224,'yen':165,'laquo':171,'raquo':187,'larr':8592,'rarr':8594,'uarr':8593,'darr':8595,
		'acute':180,'cedil':184,'circ':710,'macr':175,'tilde':732,'uml':168,'Aacute':193,'aacute':225,'Acirc':194,'acirc':226,'AElig':198,
		'aelig':230,'Agrave':192,'agrave':224,'Aring':197,'aring':229,'Atilde':195,'atilde':227,'Auml':196,
		'auml':228,'Ccedil':199,'ccedil':231,'Eacute':201,'eacute':233,'Ecirc':202,'ecirc':234,'Egrave':200,
		'egrave':232,'ETH':208,'eth':240,'Euml':203,'euml':235,'Iacute':205,'iacute':237,'Icirc':206,
		'icirc':238,'Igrave':204,'igrave':236,'Iuml':207,'iuml':239,'Ntilde':209,'ntilde':241,'Oacute':211,
		'oacute':243,'Ocirc':212,'ocirc':244,'OElig':338,'oelig':339,'Ograve':210,'ograve':242,'Oslash':216,
		'oslash':248,'Otilde':213,'otilde':245,'Ouml':214,'ouml':246,'Scaron':352,'scaron':353,'szlig':223,
		'THORN':222,'thorn':254,'Uacute':218,'uacute':250,'Ucirc':219,'ucirc':251,'Ugrave':217,'ugrave':249,
		'Uuml':220,'uuml':252,'Yacute':221,'yacute':253,'yuml':255,'Yuml':376,'cent':162,'curren':164,
		'brvbar':166,'Dagger':8225,
		'frasl':8260,'iexcl':161,'image':8465,'iquest':191,'lrm':8206,
		'not':172,'oline':8254,'ordf':170,'ordm':186,'para':182,'permil':8240,'prime':8242,'Prime':8243,
		'real':8476,'reg':174,'rlm':8207,'sect':167,'shy':173,'sup1':185,'weierp':8472,
		'bdquo':8222,
		'sbquo':8218,'emsp':8195,'ensp':8194,'thinsp':8201,'zwj':8205,'zwnj':8204,
		'deg':176,'divide':247,'frac12':189,'frac14':188,'frac34':190,'ge':8805,'le':8804,'minus':8722,
		'sup2':178,'sup3':179,'alefsym':8501,'and':8743,'ang':8736,'asymp':8776,'cap':8745,
		'cong':8773,'cup':8746,'empty':8709,'equiv':8801,'exist':8707,'fnof':402,'forall':8704,'infin':8734,
		'int':8747,'isin':8712,'lang':9001,'lceil':8968,'lfloor':8970,'lowast':8727,'micro':181,'nabla':8711,
		'ne':8800,'ni':8715,'notin':8713,'nsub':8836,'oplus':8853,'or':8744,'otimes':8855,'part':8706,
		'perp':8869,'plusmn':177,'prod':8719,'prop':8733,'radic':8730,'rang':9002,'rceil':8969,'rfloor':8971,
		'sdot':8901,'sim':8764,'sub':8834,'sube':8838,'sum':8721,'sup':8835,'supe':8839,'there4':8756,
		'Alpha':913,'alpha':945,'Beta':914,'beta':946,'Chi':935,'chi':967,'Delta':916,'delta':948,
		'Epsilon':917,'epsilon':949,'Eta':919,'eta':951,'Gamma':915,'gamma':947,'Iota':921,'iota':953,
		'Kappa':922,'kappa':954,'Lambda':923,'lambda':955,'Mu':924,'mu':956,'Nu':925,'nu':957,
		'Omega':937,'omega':969,'Omicron':927,'omicron':959,'Phi':934,'phi':966,'Pi':928,'pi':960,
		'piv':982,'Psi':936,'psi':968,'Rho':929,'rho':961,'Sigma':931,'sigma':963,'sigmaf':962,
		'Tau':932,'tau':964,'Theta':920,'theta':952,'thetasym':977,'upsih':978,'Upsilon':933,'upsilon':965,
		'Xi':926,'xi':958,'Zeta':918,'zeta':950,'crarr':8629,'dArr':8659,
		'hArr':8660,'lArr':8656,'rArr':8658,'uArr':8657,'clubs':9827,
		'diams':9830,'hearts':9829,'spades':9824,'loz':9674};

		window.entity_rep_reg={};
		for (var i in reps)
		{
			window.entity_rep_reg['&#'+reps[i]+';']=i;
		}
	}

	var i;
	for (var x in window.entity_rep_reg)
	{
		i=window.entity_rep_reg[x];
		if (typeof i=='string')
		{
			if ((i=='acute') && (!din.match(/&\w+;/))) break; // No need to go further usually
			i=new RegExp('&'+i+';','g');
			window.entity_rep_reg[x]=i;
		}
		din=din.replace(window.entity_rep_reg[x],x);
	}
	return din;
}
{$,load the HTML as XHTML}
function Load(xmlString) {
	var xml;
	if (typeof DOMParser!="undefined") xml=(new DOMParser()).parseFromString(xmlString,"text/xml");
	else {
		var ieDOM=["MSXML2.DOMDocument","MSXML.DOMDocument","Microsoft.XMLDOM"];
		for (var i=0;i<ieDOM.length && !xml;i++) {
			try { xml=new ActiveXObject(ieDOM[i]);xml.loadXML(xmlString); }
			catch(e) {}
		}
	}

	return xml;
}
{$,recursively copy the XML (from xmlDoc) into the DOM (under domNode)}
function Copy(domNode,xmlDoc,level,script_tag_dependencies) {
	if (typeof level=="undefined") level=1;
	if (level>1) {
		var node_upper=xmlDoc.nodeName.toUpperCase();

		if ((node_upper=='SCRIPT') && (!xmlDoc.getAttribute('src')))
		{
			var text=(xmlDoc.nodeValue?xmlDoc.nodeValue:(xmlDoc.textContent?xmlDoc.textContent:(xmlDoc.text?xmlDoc.text:"")));
			if (script_tag_dependencies['to_load']==0)
			{
				window.setTimeout(function() {
					if (typeof window.execScript!='undefined')
					{
						window.execScript(text);
					} else
					{
						eval.call(window,text);
					}
				},0);
			} else
			{
				script_tag_dependencies['to_run'].push(text); // Has to wait until all scripts are loaded
			}
			return;
		}

		if (xmlDoc.nodeType==1) {
			// element node
			var thisNode=domNode.ownerDocument.createElement(xmlDoc.nodeName);

			// attributes
			for (var a=0,attr=xmlDoc.attributes.length;a<attr;a++) {
				var aName=xmlDoc.attributes[a].name,aValue=xmlDoc.attributes[a].value,evt=(aName.substr(0,2)=="on");
				if (!evt) {
					switch (aName) {
						case "class": thisNode.className=aValue; break;
						case "for": thisNode.htmlFor=aValue; break;
						default: thisNode.setAttribute(aName,aValue);
					}
				} else thisNode[aName]=eval('var x=function(event) { '+aValue+' }; x;');
			}

			// append node
			if ((node_upper=='SCRIPT') || (node_upper=='LINK')/* || (node_upper=='STYLE') Causes weird IE bug*/)
			{
				if (node_upper=='SCRIPT')
				{
					script_tag_dependencies['to_load'].push(thisNode);
					thisNode.onload=thisNode.onreadystatechange=function() {
						if ((typeof thisNode.readyState=='undefined') || (thisNode.readyState=='complete') || (thisNode.readyState=='loaded'))
						{
							var found=0,i;

							for (i=0;i<script_tag_dependencies['to_load'].length;i++)
							{
								if (script_tag_dependencies['to_load'][i]===thisNode)
									delete script_tag_dependencies['to_load'][i];
								else if (typeof script_tag_dependencies['to_load'][i]!=='undefined') found++;
							}
							if (found==0)
							{
								for (i=0;i<script_tag_dependencies['to_run'].length;i++)
								{
									if (typeof window.execScript!='undefined')
									{
										window.execScript(script_tag_dependencies['to_run'][i]);
									} else
									{
										eval.call(window,script_tag_dependencies['to_run'][i]);
									}
								}
								script_tag_dependencies['to_run']=[]; // So won't run again, if both onreadystatechange and onload implemented in browser
							}
						}
					};
				}
				domNode=document.getElementsByTagName('head')[0].appendChild(thisNode);
			} else
			{
				domNode=domNode.appendChild(thisNode);
				var _new_html__initialise=function() {
					var found=0,i;

					for (i=0;i<script_tag_dependencies['to_load'].length;i++)
					{
						if (script_tag_dependencies['to_load'][i]===thisNode)
							delete script_tag_dependencies['to_load'][i];
						else if (typeof script_tag_dependencies['to_load'][i]!=='undefined') found++;
					}

					if (found==0)
						new_html__initialise(thisNode);
					else
						window.setTimeout(_new_html__initialise,0); // Can't do it yet
				};
				window.setTimeout(_new_html__initialise,0);
			}
		}
		else if (xmlDoc.nodeType==3) {
			// text node
			var text=(xmlDoc.nodeValue?xmlDoc.nodeValue:(xmlDoc.textContent?xmlDoc.textContent:(xmlDoc.text?xmlDoc.text:"")));
			var test=text.replace(/^\s*|\s*$/g,"");

			if (test.indexOf("<!--")!=0 && (test.length<=3 || test.indexOf("-->")!=(test.length-3)))
			{
				if ((domNode.nodeName=='STYLE') && (!domNode.ownerDocument.createCDATASection))
				{
					domNode.cssText=text; /* needed for IE */
				} else
				{
					domNode.appendChild(domNode.ownerDocument.createTextNode(text));
				}
				domNode=null;
			}
		}
		else if (xmlDoc.nodeType==4) {
			// CDATA node
			var text=(xmlDoc.nodeValue?xmlDoc.nodeValue:(xmlDoc.textContent?xmlDoc.textContent:(xmlDoc.text?xmlDoc.text:"")));
			if ((domNode.nodeName=='STYLE') && (!domNode.ownerDocument.createCDATASection))
			{
				domNode.cssText=text; /* needed for IE */
			} else
			{
				domNode.appendChild(domNode.ownerDocument./*createCDATASection*/createTextNode(text)); // use of createCDATASection causes weird bug in Firefox (sibling DOM nodes skipped)
			}
			domNode=null;
		}
	}

	{$,do child nodes}
	if (domNode)
	{
		for (var i=0,j=xmlDoc.childNodes.length;i<j;i++)
		{
			if ((xmlDoc.childNodes[i].id!='_firebugConsole') && (xmlDoc.childNodes[i].type!='application/x-googlegears'))
				Copy.call(window,domNode,xmlDoc.childNodes[i],level+1,script_tag_dependencies);
		}
	}
}

function setOuterHTML(element,tHTML)
{
	setInnerHTML(element,tHTML);
	var p=element.parentNode;
	var c=element.childNodes;
	for (var i=c.length-1;i>=0;i--)
	{
		if (element.nextSibling)
		{
			p.insertBefore(c[i],element.nextSibling);
		} else
		{
			p.appendChild(c[i]);
		}
	}
	p.removeChild(element);
}

{$,Note that embedded Javascript IS run unlike the normal .innerHTML - in fact we go to effort to guarantee it - even onload attached Javascript}
function setInnerHTML(element,tHTML,append)
{
	if (typeof tHTML=='number') tHTML=tHTML+'';

	{$,Parser hint: .innerHTML okay}
	if ((document.write) && (typeof element.innerHTML!="undefined") && (!document.xmlVersion) && (tHTML.toLowerCase().indexOf('<script type="text/javascript src="')==-1) && (tHTML.toLowerCase().indexOf('<link')==-1))
	{
		var clone=element.cloneNode(true);
		try
		{
			var scripts_jump=0,already_offset=0;
			if (append)
			{
				scripts_jump=element.getElementsByTagName('script').length;
				element.innerHTML+=tHTML;
				already_offset=element.getElementsByTagName('*').length
			} else
			{
				element.innerHTML=tHTML;
			}

			window.setTimeout(function() {
				var elements=element.getElementsByTagName('*');
				for (var i=already_offset;i<elements.length;i++)
				{
					new_html__initialise(elements[i]);
				}
			}, 0); // Delayed so we know DOM has loaded

			if (tHTML.toLowerCase().indexOf('<script')!=-1)
			{
				window['js_runs_test_'+r_id]=false;
				var r_id='js_'+Math.random();
				element.innerHTML+='<script id="'+r_id+'" type="text/javascript">window[\'js_runs_test_'+r_id+'\']=true;</script>';

				window.setTimeout(function() {
					if (!window['js_runs_test_'+r_id]) // If JS was not run by the above op
					{
						var scripts=element.getElementsByTagName('script');
						for (var i=scripts_jump;i<scripts.length;i++)
						{
							if (!scripts[i].src) // i.e. if it is inline JS
							{
								var text=(scripts[i].nodeValue?scripts[i].nodeValue:(scripts[i].textContent?scripts[i].textContent:(scripts[i].text?scripts[i].text.replace(/^<script[^>]*>/,''):"")));
								if (typeof window.execScript!='undefined')
								{
									window.execScript(text);
								} else
								{
									eval.call(window,text);
								}
							}
						}
						window['js_runs_test_'+r_id]=true;
					} else
					{
						var r=document.getElementById(r_id);
						r.parentNode.removeChild(r);
					}
				}, 0); // Delayed so we know DOM has loaded
			}

			window.setTimeout( function() { fixImagesIn(element); } , 500); // Delayed so that the image dimensions can load up

			return;
		}
		catch(ignore) {};
	}

	tHTML=EntitiesToUnicode(tHTML);

	{$,load the XML and copies to DOM}
	tHTML="<root>"+tHTML.replace(/^\s*\<\!DOCTYPE[^<>]*\>/,'')+"</root>";
	var xmlDoc=Load(tHTML);
	if (element && xmlDoc) {
		if (!append) while (element.lastChild) element.removeChild(element.lastChild);
		var script_tag_dependencies={
			'to_run': [],
			'to_load': []
		};
		Copy.call(window,element,xmlDoc.documentElement,1,script_tag_dependencies);

		window.setTimeout( function() { fixImagesIn(element); } , 500); // Delayed so that the image dimensions can load up
	}
}

function fixImagesIn(element)
{
	if (typeof element.getElementsByTagName=='undefined') return;
	if (typeof element.getElementsByTagName=='unknown') return;
	var imgs=element.getElementsByTagName('img');
	for(var i=0;i<imgs.length;i++) fixImage(imgs[i]);
	if (element.nodeName.toLowerCase()=='img') fixImage(element);
}

function carefulImportNode(node)
{
	var imported;
	try {	imported=(document.importNode)?document.importNode(node,true):null; } catch (e) {};
	if (!imported) imported=node;
	return imported;
}

function apply_rating_highlight_and_ajax_code(likes,initial_rating,content_type,id,type,rating,content_url,content_title,initialisation_phase)
{
	var i,bit;
	for (i=1;i<=10;i++)
	{
		bit=document.getElementById('rating_bar_'+i+'__'+content_type+'__'+type+'__'+id);
		if (!bit) continue;

		if (likes)
		{
			setOpacity(bit,(rating==i)?1.0:0.2);
		} else
		{
			setOpacity(bit,(rating>=i)?1.0:0.2);
		}

		if (initialisation_phase)
		{
			bit.onmouseover=function(i) { return function()
			{
				apply_rating_highlight_and_ajax_code(likes,initial_rating,content_type,id,type,i,content_url,content_title,false);
			} }(i);
			bit.onmouseout=function(i) { return function()
			{
				apply_rating_highlight_and_ajax_code(likes,initial_rating,content_type,id,type,initial_rating,content_url,content_title,false);
			} }(i);

			bit.onclick=function(i) {
				return function()	{
					var template='';
					var replace_spot=bit;
					while (replace_spot)
					{
						replace_spot=replace_spot.parentNode;
						if (replace_spot.className.match(/^RATING_BOX( |$)/))
						{
							template='RATING_BOX';
							break;
						}
						if (replace_spot.className.match(/^RATING_INLINE_STATIC( |$)/))
						{
							template='RATING_INLINE_STATIC';
							break;
						}
						if (replace_spot.className.match(/^RATING_INLINE_DYNAMIC( |$)/))
						{
							template='RATING_INLINE_DYNAMIC';
							break;
						}
					}
					var snippet_request='rating&type='+window.encodeURIComponent(type)+'&id='+window.encodeURIComponent(id)+'&content_type='+window.encodeURIComponent(content_type)+'&template='+window.encodeURIComponent(template)+'&content_url='+window.encodeURIComponent(content_url)+'&content_title='+window.encodeURIComponent(content_title);
					var message=load_snippet(snippet_request,'rating='+window.encodeURIComponent(i),function(ajax_result) {
						var message=ajax_result.responseText;
						setInnerHTML((template=='')?bit.parentNode.parentNode.parentNode.parentNode:replace_spot,(template=='')?('<strong>'+message+'</strong>'):message.replace(/^\s*<[^<>]+>/,'').replace(/<\/[^<>]+>\s*$/,''));
					});
				}
			}(i);
		}
	}
}

function click_link(link)
{
	var cancelled=false;

	var backup=link.onclick;

	link.onclick=function(e) { if (typeof e=='undefined') var e=window.event; cancelBubbling(e); };

	if ((typeof document.createEvent!='undefined') && (document.createEvent))
	{
		var event=document.createEvent('MouseEvents');
		event.initMouseEvent('click',true,true,window,
			0,0,0,0,0,
			false,false,false,false,
			0,null
		);
		cancelled=!link.dispatchEvent(event);
	}
	else if (typeof link.fireEvent!='undefined')
	{
		cancelled=!link.fireEvent('onclick');
	}
	link.onclick=backup;

	if ((!cancelled) && (link.href))
	{
		if (link.getAttribute('target')) window.open(link.href,link.getAttribute('target'));
		window.location=link.href;
	}
}

function handle_comments_posting_form_submit(button,event)
{
	var form;
	if (typeof button.form=='undefined')
	{
		form=window.form_submitting;
	} else
	{
		form=button.form;
	}

	form.setAttribute('target','_top');
	if (typeof form.old_action!='undefined') form.setAttribute('action',form.old_action);
	if (form.onsubmit.call(form,event))
	{
		disable_button_just_clicked(document.getElementById('submit_button'));
		form.submit();
	}
}

function move_to_full_editor(button,more_url)
{
	var form;
	if (typeof button.form=='undefined')
	{
		form=window.form_submitting;
	} else
	{
		form=button.form;
	}

	// Tell next screen what the stub to trim is
	if (typeof form.elements['post'].default_substring_to_strip!='undefined')
	{
		if (typeof form.elements['stub']!='undefined')
		{
			form.elements['stub'].value=form.elements['post'].default_substring_to_strip;
		} else
		{
			if (more_url.indexOf('?')==-1)
			{
				more_url+='?';
			} else
			{
				more_url+='&';
			}
			more_url+='stub='+window.encodeURIComponent(form.elements['post'].default_substring_to_strip);
		}
	}

	// Reset form target
	form.setAttribute('target','_top');
	if (typeof form.old_action!='undefined') form.old_action=form.getAttribute('action');
	form.setAttribute('action',more_url);

	// Handle threaded strip-on-focus
	if ((typeof form.elements['post'].strip_on_focus!='undefined') && (form.elements['post'].value==form.elements['post'].strip_on_focus))
		form.elements['post'].value='';

	form.submit();
}

function replace_comments_form_with_ajax(options,hash)
{
	var comments_form=document.getElementById('comments_form');
	if (comments_form)
	{
		comments_form.old_onsubmit=comments_form.onsubmit;

		comments_form.onsubmit=function(event) {

			// Cancel the event from running
			if (typeof event=='undefined') var event=window.event;
			event.returnValue=false;
			if (typeof event.preventDefault!='undefined') event.preventDefault();

			if (!comments_form.old_onsubmit(event)) return false;

			var comments_wrapper=document.getElementById('comments_wrapper');
			if (!comments_wrapper) // No AJAX, as stuff missing from template
			{
				comments_form.submit();
				return true;
			}

			disable_button_just_clicked(document.getElementById('submit_button'));

			// Note what posts are shown now
			var known_posts=get_elements_by_class_name(comments_wrapper,'post');
			var known_times=[];
			for (var i=0;i<known_posts.length;i++)
			{
				known_times.push(known_posts[i].className.replace(/^post /,''));
			}

			// Fire off AJAX request
			var post='options='+window.encodeURIComponent(options)+'&hash='+window.encodeURIComponent(hash);
			var post_element=comments_form.elements['post'];
			var post_value=post_element.value;
			if (typeof post_element.default_substring_to_strip!='undefined') // Strip off prefix if unchanged
			{
				if (post_value.substring(0,post_element.default_substring_to_strip.length)==post_element.default_substring_to_strip)
					post_value=post_value.substring(post_element.default_substring_to_strip.length,post_value.length);
			}
			for (var i=0;i<comments_form.elements.length;i++)
			{
				if ((comments_form.elements[i].name) && (comments_form.elements[i].name!='post'))
					post+='&'+comments_form.elements[i].name+'='+window.encodeURIComponent(cleverFindValue(comments_form,comments_form.elements[i]));
			}
			post+='&post='+window.encodeURIComponent(post_value);
			do_ajax_request('{$FIND_SCRIPT;,post_comment}'+keep_stub(true),function(ajax_result) {
				if ((ajax_result.responseText!='') && (ajax_result.status!=500))
				{
					// Display
					setInnerHTML(comments_wrapper,ajax_result.responseText);

					// Collapse, so user can see what happening
					toggleSectionInline('comments_posting_form_outer','block');

					// Set fade for posts not shown before
					var known_posts=get_elements_by_class_name(comments_wrapper,'post');
					for (var i=0;i<known_posts.length;i++)
					{
						if (!known_times.inArray(known_posts[i].className.replace(/^post /,'')))
						{
							setOpacity(known_posts[i],0.0);
							nereidFade(known_posts[i],100,20,5);
						}
					}

					// And re-attach this code (got killed by setInnerHTML)
					replace_comments_form_with_ajax(options,hash);
				} else // Error: do a normal post so error can be seen
				{
					comments_form.submit();
				}
			},post);

			return false;
		};
	}
}

function topic_reply(is_threaded,ob,id,replying_to_username,replying_to_post,replying_to_post_plain)
{
	var form=document.getElementById('comments_form');

	var parent_id_field;
	if (typeof form.elements['parent_id']=='undefined')
	{
		parent_id_field=document.createElement('input');
		parent_id_field.type='hidden';
		parent_id_field.name='parent_id';
		form.appendChild(parent_id_field);
	} else
	{
		parent_id_field=form.elements['parent_id'];
		if (typeof window.last_reply_to!='undefined') setOpacity(window.last_reply_to,1.0);
	}
	window.last_reply_to=ob;
	parent_id_field.value=id;

	setOpacity(ob,0.4);

	var post=form.elements['post'];

	smoothScroll(findPosY(form));

	if (document.getElementById('comments_posting_form_outer').style.display=='none')
		toggleSectionInline('comments_posting_form_outer','block');

	if (is_threaded)
	{
		post.value='{!QUOTED_REPLY_MESSAGE^;}'.replace(/\\{1\\}/g,replying_to_username).replace(/\\{2\\}/g,replying_to_post_plain);
		post.strip_on_focus=post.value;
		post.style.color='';
	} else
	{
		if (typeof post.strip_on_focus!='undefined' && post.value==post.strip_on_focus)
			post.value='';
		else if (post.value!='') post.value+='\n\n';

		post.focus();
		post.value+='[quote="'+replying_to_username+'"]\n'+replying_to_post+'\n[/quote]\n\n';
		post.default_substring_to_strip=post.value;
	}

	return false;
}

function threaded_load_more(ob,ids,id)
{
	load_snippet('comments&id='+window.encodeURIComponent(id)+'&ids='+window.encodeURIComponent(ids)+'&serialized_options='+window.encodeURIComponent(window.comments_serialized_options)+'&hash='+window.encodeURIComponent(window.comments_hash),null,function(ajax_result) {
		var wrapper;
		if (id!='')
		{
			wrapper=document.getElementById('post_children_'+id);
		} else
		{
			wrapper=ob.parentNode;
		}
		ob.parentNode.removeChild(ob);

		setInnerHTML(wrapper,ajax_result.responseText,true);

		window.setTimeout(function() {
			if (typeof window.nereidFade!='undefined')
			{
				var _ids=ids.split(',');
				for (var i=0;i<_ids.length;i++)
				{
					var element=document.getElementById('post_'+_ids[i]);
					if (element)
					{
						setOpacity(element,0);
						nereidFade(element,100,30,10);
					}
				}
			}
		},0);
	});

	return false;
}

{+START,INCLUDE,JAVASCRIPT_MODALWINDOW}{+END}

{$,Put your extra custom code in an overrided version of the template below + it will take function precedence also}
{+START,INCLUDE,JAVASCRIPT_CUSTOM_GLOBALS}{+END}
