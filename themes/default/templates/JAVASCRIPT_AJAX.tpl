"use strict";

var AJAX_REQUESTS=[];
var AJAX_METHODS=[];
var AJAX_TIMEOUTS=[];

/*
	Faux frames and faux scrolling
*/

var block_data_cache={};

var infinite_scroll_blocked=false;
function infinite_scrolling_block(event)
{
	if (event.keyCode==35) // 'End' key pressed, so stop the expand happening for a few seconds while the browser scrolls down
	{
		infinite_scroll_blocked=true;
		window.setTimeout(function() {
			infinite_scroll_blocked=false;
		}, 3000);
	}
}
var infinite_scroll_mouse_held=false;
function infinite_scrolling_block_hold()
{
	if (!infinite_scroll_blocked)
	{
		infinite_scroll_blocked=true;
		infinite_scroll_mouse_held=true;
	}
}
function infinite_scrolling_block_unhold(infinite_scrolling)
{
	if (infinite_scroll_mouse_held)
	{
		infinite_scroll_blocked=false;
		infinite_scroll_mouse_held=false;
		infinite_scrolling();
	}
}
function internalise_infinite_scrolling(url_stem,wrapper)
{
	var _pagination=get_elements_by_class_name(wrapper,'pagination');
	if (typeof _pagination[0]=='undefined') return false;
	var pagination=_pagination[0];

	if (pagination.style.display!='none')
	{
		pagination.style.display='none';

		var load_more_link=document.createElement('div');
		load_more_link.className='pagination_load_more';
		var load_more_link_a=document.createElement('a');
		set_inner_html(load_more_link_a,'{!LOAD_MORE;}');
		load_more_link_a.href='#';
		load_more_link_a.onclick=function() { internalise_infinite_scrolling_go(url_stem,wrapper,pagination); return false; };
		load_more_link.appendChild(load_more_link_a);
		pagination.parentNode.insertBefore(load_more_link,pagination.nextSibling);
	}

	if (infinite_scroll_blocked) return false;

	var wrapper_pos_y=find_pos_y(wrapper);
	var wrapper_height=find_height(wrapper);
	var wrapper_bottom=wrapper_pos_y+wrapper_height;
	var window_height=get_window_height();
	var page_height=get_window_scroll_height();
	var scroll_y=get_window_scroll_y();

	if ((scroll_y+window_height>wrapper_bottom-window_height/2) && (scroll_y+window_height<page_height-30)) // If within window_height/2 pixels of load area and not within 30 pixels of window bottom (so you can press End key)
	{
		return internalise_infinite_scrolling_go(url_stem,wrapper,pagination);
	}

	return false;
}
function internalise_infinite_scrolling_go(url_stem,wrapper,pagination)
{
	var more_links=pagination.getElementsByTagName('a');

	pagination.parentNode.removeChild(pagination.nextSibling);
	pagination.parentNode.removeChild(pagination);

	for (var i=0;i<more_links.length;i++)
	{
		if (more_links[i].getAttribute('rel')=='next')
		{
			var next_link=more_links[i];

			var url_stub='';
			var matches=next_link.href.match(new RegExp('[&\?]([^_]*_start)=([^&]*)'));
			if (matches)
			{
				url_stub+=(url_stem.indexOf('?')==-1)?'?':'&';
				url_stub+=matches[1]+'='+matches[2];
				url_stub+='&raw=1';
				return call_block(url_stem+url_stub,'',wrapper,true);
			}
		}
	}
	return false;
}

function internalise_ajax_block_wrapper_links(url_stem,block,look_for,extra_params,append,forms_too)
{
	if (typeof look_for=='undefined') var look_for=[];
	if (typeof extra_params=='undefined') var extra_params=[];
	if (typeof append=='undefined') var append=false;
	if (typeof forms_too=='undefined') var forms_too=false;

	var _link_wrappers=get_elements_by_class_name(block,'ajax_block_wrapper_links');
	if (_link_wrappers.length==0) _link_wrappers=[block];
	var links=[];
	for (var i=0;i<_link_wrappers.length;i++)
	{
		var _links=_link_wrappers[i].getElementsByTagName('a');
		for (var j=0;j<_links.length;j++)
			links.push(_links[j]);
		if (forms_too)
		{
			_links=_link_wrappers[i].getElementsByTagName('form');
			for (var j=0;j<_links.length;j++)
				links.push(_links[j]);
		}
	}
	for (var i=0;i<links.length;i++)
	{
		if ((links[i].target) && (links[i].target=='_self'))
		{
			var submit_func=function()
			{
				var url_stub='';

				var href=(this.nodeName.toLowerCase()=='a')?this.href:this.action;

				// Any parameters matching a pattern must be sent in the URL to the AJAX block call
				for (var j=0;j<look_for.length;j++)
				{
					var matches=href.match(new RegExp('[&\?]('+look_for[j]+')=([^&]*)'));
					if (matches)
					{
						url_stub+=(url_stem.indexOf('?')==-1)?'?':'&';
						url_stub+=matches[1]+'='+matches[2];
					}
				}
				for (var j in extra_params)
				{
					url_stub+=(url_stem.indexOf('?')==-1)?'?':'&';
					url_stub+=j+'='+window.encodeURIComponent(extra_params[j]);
				}

				// Any POST parameters?
				var post_params=null;
				if (this.nodeName.toLowerCase()=='form')
				{
					post_params='';
					for (var j=0;j<this.elements.length;j++)
					{
						if (this.elements[j].name)
						{
							if (post_params!='') post_params+='&';
							post_params+=this.elements[j].name+'='+window.encodeURIComponent(clever_find_value(this,this.elements[j]));
						}
					}
				}

				// Make AJAX block call
				return call_block(url_stem+url_stub,'',block,append,null,false,post_params);
			}
			if (links[i].nodeName.toLowerCase()=='a')
			{
				links[i].onclick=submit_func;
			} else
			{
				links[i].onsubmit=submit_func;
			}
		}
	}
}

function guarded_form_submit(form)
{
	if ((!form.onsubmit) || (form.onsubmit())) form.submit();
}

// This function will load a block, with options for parameter changes, and render the results in specified way - with optional callback support
function call_block(url,new_block_params,target_div,append,callback,scroll_to_top_of_wrapper,post_params)
{
	if (typeof scroll_to_top_of_wrapper=='undefined') var scroll_to_top_of_wrapper=false;
	if (typeof post_params=='undefined') var post_params=null;
	if ((typeof block_data_cache[url]=='undefined') && (new_block_params!=''))
		block_data_cache[url]=get_inner_html(target_div); // Cache start position. For this to be useful we must be smart enough to pass blank new_block_params if returning to fresh state

	var ajax_url=url;
	if (new_block_params!='') '&block_map_sup='+window.encodeURIComponent(new_block_params);
	if (typeof block_data_cache[ajax_url]!='undefined')
	{
		// Show results from cache
		show_block_html(block_data_cache[ajax_url],target_div,append);
		if (callback) callback();
		return false;
	}

	// Show loading animation
	var loading_wrapper=target_div;
	var raw_ajax_grow_spot=get_elements_by_class_name(target_div,'raw_ajax_grow_spot');
	if (typeof raw_ajax_grow_spot[0]!='undefined') loading_wrapper=raw_ajax_grow_spot[0]; // If we actually are embedding new results a bit deeper
	var loading_wrapper_inner=document.createElement('div');
	loading_wrapper_inner.style.position='relative';
	var loading_image=document.createElement('img');
	loading_image.className='ajax_loading ajax_loading_block';
	loading_image.src='{$IMG;,loading}';
	loading_image.style.position='absolute';
	loading_image.style.left=(find_width(target_div)/2-10)+'px';
	if (!append)
	{
		loading_image.style.top=(-find_height(target_div)/2-20)+'px';
	} else
	{
		loading_image.style.top=0;
		loading_wrapper_inner.style.height='30px';
	}
	loading_wrapper_inner.appendChild(loading_image);
	loading_wrapper.appendChild(loading_wrapper_inner);

	// Make AJAX call
	do_ajax_request(
		ajax_url,
		function(raw_ajax_result) { // Show results when available
			_call_block_render(raw_ajax_result,ajax_url,target_div,append,callback,scroll_to_top_of_wrapper);
		},
		post_params
	);

	return false;
}

function _call_block_render(raw_ajax_result,ajax_url,target_div,append,callback,scroll_to_top_of_wrapper)
{
	var new_html=raw_ajax_result.responseText;
	block_data_cache[ajax_url]=new_html;

	// Remove loading animation if there is one
	var ajax_loading=get_elements_by_class_name(target_div,'ajax_loading');
	if (typeof ajax_loading[0]!='undefined')
	{
		ajax_loading[0].parentNode.removeChild(ajax_loading[0]);
	}

	// Put in HTML
	show_block_html(new_html,target_div,append);

	// Scroll up if required
	if (scroll_to_top_of_wrapper)
	{
		try
		{
			window.scrollTo(0,find_pos_y(target_div));
		}
		catch (e) {};
	}

	// Defined callback
	if (callback) callback();
}

function show_block_html(new_html,target_div,append)
{
	var raw_ajax_grow_spot=get_elements_by_class_name(target_div,'raw_ajax_grow_spot');
	if (typeof raw_ajax_grow_spot[0]!='undefined') target_div=raw_ajax_grow_spot[0]; // If we actually are embedding new results a bit deeper

	set_inner_html(target_div,new_html,append);
}

function ajax_form_submit__admin__headless(event,form,block_name,map)
{
	if (typeof window.clever_find_value=='undefined') return true;

	cancel_bubbling(event);

	var comcode='[block'+map+']'+block_name+'[/block]';
	var post='data='+window.encodeURIComponent(comcode);
	for (var i=0;i<form.elements.length;i++)
	{
		post+='&'+form.elements[i].name+'='+window.encodeURIComponent(clever_find_value(form,form.elements[i]));
	}
	var request=do_ajax_request(maintain_theme_in_link('{$FIND_SCRIPT_NOHTTP;,comcode_convert}'+keep_stub(true)),null,post);

	if ((request.responseText!='') && (request.responseText!=''))
	{
		if (request.responseText!='false')
		{
			var result_tags=request.responseXML.documentElement.getElementsByTagName("result");
			if ((result_tags) && (result_tags.length!=0))
			{
				var result=result_tags[0];
				var xhtml=merge_text_nodes(result.childNodes);

				var element_replace=form;
				while (element_replace.className!='form_ajax_target')
				{
					element_replace=element_replace.parentNode;
					if (!element_replace) return true; // Oh dear, target not found
				}

				set_inner_html(element_replace,xhtml);

				window.fauxmodal_alert('{!SUCCESS;}');

				return false; // We've handled it internally
			}
		}
	}

	return true;
}

/*
	Validation
*/

/* Calls up a URL to check something, giving any 'feedback' as an error (or if just 'false' then returning false with no message) */
function do_ajax_field_test(url,post)
{
	if (typeof window.keep_stub!='undefined') url=url+keep_stub();
	var xmlhttp=do_ajax_request(url,null,post);
	if ((xmlhttp.responseText!='') && (xmlhttp.responseText.replace(/[ \t\n\r]/g,'')!='0'/*some cache layers may change blank to zero*/))
	{
		if (xmlhttp.responseText!='false')
		{
			if (xmlhttp.responseText.length>1000)
			{
				var error_window=window.open();
				if (error_window)
				{
					error_window.document.write(xmlhttp.responseText);
					error_window.document.close();
				}
			} else
			{
				window.fauxmodal_alert(xmlhttp.responseText);
			}
		}
		return false;
	}
	return true;
}

/*
	Request backend
*/

function do_ajax_request(url,callback__method,post) // Note: 'post' is not an array, it's a string (a=b)
{
	var synchronous=!callback__method;

	if ((url.indexOf('://')==-1) && (url.substr(0,1)=='/'))
	{
		url=window.location.protocol+'//'+window.location.host+url;
	}

	if ((typeof window.AJAX_REQUESTS=="undefined") || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone

	var index=AJAX_REQUESTS.length;
	AJAX_METHODS[index]=callback__method;

	AJAX_REQUESTS[index]=new XMLHttpRequest();
	if (!synchronous) AJAX_REQUESTS[index].onreadystatechange=process_request_changes;
	if (post)
	{
		AJAX_REQUESTS[index].open('POST',url,!synchronous);
		AJAX_REQUESTS[index].setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		AJAX_REQUESTS[index].send(post);
	} else
	{
		AJAX_REQUESTS[index].open("GET",url,!synchronous);
		AJAX_REQUESTS[index].send(null);
	}

	if ((typeof window.AJAX_REQUESTS=="undefined") || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone
	var result=AJAX_REQUESTS[index];
	if (synchronous)
	{
		AJAX_REQUESTS[index]=null;
	}
	return result;
}

function process_request_changes()
{
	if ((typeof window.AJAX_REQUESTS=="undefined") || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone

	// If any AJAX_REQUESTS are 'complete'
	var i,result;
	for (i=0;i<AJAX_REQUESTS.length;i++)
	{
		result=AJAX_REQUESTS[i];
		if ((result!=null) && (result.readyState) && (result.readyState==4))
		{
			AJAX_REQUESTS[i]=null;

			// If status is 'OK'
			if ((result.status) && (result.status==200) || (result.status==500) || (result.status==400) || (result.status==401))
			{
				//Process the result
				if ((AJAX_METHODS[i]) && (!result.responseXML/*Not payload handler and not stack trace*/ || result.responseXML.childNodes.length==0))
				{
					return AJAX_METHODS[i](result);
				}
				var xml=handle_errors_in_result(result);
				if (xml)
				{
					xml.validateOnParse=false;
					var ajax_result_frame=xml.documentElement;
					if (!ajax_result_frame) ajax_result_frame=xml;
					process_request_change(ajax_result_frame,i);
				}
			}
			else
			{
				try
				{
					if ((result.status==0) || (result.status==12029)) // 0 implies site down, or network down
					{
						if ((!window.network_down) && (!window.unloaded))
						{
							if (result.status==12029) window.fauxmodal_alert("{!NETWORK_DOWN^#}");
							window.network_down=true;
						}
					} else
					{
						if (typeof console.log!='undefined') console.log("{!PROBLEM_RETRIEVING_XML^#}\n"+result.status+": "+result.statusText+".");
					}
				}
				catch (e)
				{
					if (typeof console.log!='undefined') console.log("{!PROBLEM_RETRIEVING_XML^#}");		// This is probably clicking back
				}
			}
		}
	}
}

function handle_errors_in_result(result)
{
	if ((result.responseXML==null) || (result.responseXML.childNodes.length==0))
	{
		// Try and parse again. Firefox can be weird.
		var xml;
		if (typeof DOMParser!="undefined")
		{
			try { xml=(new DOMParser()).parseFromString(result.responseText,"application/xml"); }
			catch(e) {}
		} else
		{
			var ieDOM=["MSXML2.DOMDocument","MSXML.DOMDocument","Microsoft.XMLDOM"];
			for (var i=0;i<ieDOM.length && !xml;i++) {
				try { xml=new ActiveXObject(ieDOM[i]);xml.loadXML(result.responseText); }
				catch(e) {}
			}
		}
		if (xml) return xml;

		if ((result.responseText) && (result.responseText!='') && (result.responseText.indexOf('<html')!=-1))
		{
			if (typeof console.debug!='undefined') console.debug(result);

			var error_window=window.open();
			if (error_window)
			{
				error_window.document.write(result.responseText);
				error_window.document.close();
			}
		}
		return false;
	}
	return result.responseXML;
}

function process_request_change(ajax_result_frame,i)
{
	if (!ajax_result_frame) return null; // Needed for Opera
	if ((typeof window.AJAX_REQUESTS=="undefined") || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone

	if (ajax_result_frame.getElementsByTagName("message")[0])
	{
		//Either an error or a message was returned. :(
		var message=ajax_result_frame.getElementsByTagName("message")[0].firstChild.data;

		if (ajax_result_frame.getElementsByTagName("error")[0])
		{
			//It's an error :|
			window.fauxmodal_alert("An error ("+ajax_result_frame.getElementsByTagName("error")[0].firstChild.data+") message was returned by the server: "+message);
			return null;
		}

		window.fauxmodal_alert("An informational message was returned by the server: "+message);
		return null;
	}

	var ajax_result=ajax_result_frame.getElementsByTagName("result")[0];
	if (!ajax_result) return null;

	if ((ajax_result_frame.getElementsByTagName("method")[0]) || (AJAX_METHODS[i]))
	{
		var method=(ajax_result_frame.getElementsByTagName("method")[0])?eval('return '+merge_text_nodes(ajax_result_frame.getElementsByTagName("method")[0])):AJAX_METHODS[i];
		if (typeof method.response!='undefined') method.response(ajax_result_frame,ajax_result);
		else method(ajax_result_frame,ajax_result);

	}// else window.fauxmodal_alert("Method required: as it is non-blocking");

	return null;
}

function merge_text_nodes(childNodes)
{
	var i,text='';
	for (i=0;i<childNodes.length;i++)
	{
		if (childNodes[i].nodeName=='#text')
		{
			text+=childNodes[i].data;
		}
	}
	return text;
}


