"use strict";

window.AJAX_REQUESTS=[];
window.AJAX_METHODS=[];

window.block_data_cache={};

function call_block(url,new_params,target_div,append,callback)
{
	if (typeof block_data_cache[url]=='undefined') block_data_cache[url]=get_inner_html(target_div); // Cache start position. For this to be useful we must be smart enough to pass blank new_params if returning to fresh state

	var ajax_url=url+'&block_map_sup='+window.encodeURIComponent(new_params);
	if (typeof block_data_cache[ajax_url]!='undefined')
	{
		show_block_html(block_data_cache[ajax_url],target_div,append);
		if (callback) callback();
		return null;
	}

	// Show loading image

	if (!append)
	{
		target_div.orig_position=target_div.style.position;
		target_div.style.position='relative';
		var loading_image=document.createElement('img');
		loading_image.src='{$IMG;,loading}';
		loading_image.style.position='absolute';
		loading_image.style.left=(find_width(target_div)/2-10)+'px';
		loading_image.style.top=(find_height(target_div)/2-20)+'px';
		target_div.appendChild(loading_image);
	}

	// Make AJAX call
	do_ajax_request(ajax_url,function(raw_ajax_result) { _call_block(raw_ajax_result,ajax_url,target_div,append,callback); });

	return false;
}

function _call_block(raw_ajax_result,ajax_url,target_div,append,callback)
{
	target_div.style.position=target_div.orig_position;
	var new_html=raw_ajax_result.responseText;
	block_data_cache[ajax_url]=new_html;
	show_block_html(new_html,target_div,append);
	if (callback) callback();
}

function show_block_html(new_html,target_div,append)
{
	set_inner_html(target_div,new_html,append);
}

function internalise_ajax_block_wrapper_links(url_stem,block,look_for,extra_params)
{
	var _links=get_elements_by_class_name(block,'ajax_block_wrapper_links');
	var links=[];
	for (var i=0;i<_links.length;i++)
	{
		var more_links=_links[i].getElementsByTagName('a');
		for (var j=0;j<more_links.length;j++)
		{
			links.push(more_links[j]);
		}
	}
	for (var i=0;i<links.length;i++)
	{
		links[i].href;
		links[i].onclick=function()
		{
			var url_stub='';
			for (var j=0;j<look_for.length;j++)
			{
				var matches=this.href.match(new RegExp('[&\?]'+look_for[j]+'=([^&]*)'));
				if (matches)
				{
					url_stub+=(url_stem.indexOf('?')==-1)?'?':'&';
					url_stub+=look_for[j]+='='+matches[1];
				}
			}
			for (var j in extra_params)
			{
				url_stub+=(url_stem.indexOf('?')==-1)?'?':'&';
				url_stub+=j+'='+window.encodeURIComponent(extra_params[j]);
			}
			return call_block(url_stem+url_stub,'',block,false);
		}
	}
}

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

function ajax_form_submit(event,form,block_name,map)
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
			var result_tags=request.responseXML.documentElement.getElementsByTagName('result');
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

function do_ajax_request(url,callback__method,post) // Note: 'post' is not an array, it's a string (a=b)
{
	var synchronous=!callback__method;

	if ((url.indexOf('://')==-1) && (url.substr(0,1)=='/'))
	{
		url=window.location.protocol+'//'+window.location.host+url;
	}

	if ((typeof window.AJAX_REQUESTS=='undefined') || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone

	var index=window.AJAX_REQUESTS.length;
	window.AJAX_METHODS[index]=callback__method;

	window.AJAX_REQUESTS[index]=new XMLHttpRequest();
	if (!synchronous) window.AJAX_REQUESTS[index].onreadystatechange=process_request_changes;
	if (post)
	{
		window.AJAX_REQUESTS[index].open('POST',url,!synchronous);
		window.AJAX_REQUESTS[index].setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		window.AJAX_REQUESTS[index].send(post);
	} else
	{
		window.AJAX_REQUESTS[index].open('GET',url,!synchronous);
		window.AJAX_REQUESTS[index].send(null);
	}

	if ((typeof window.AJAX_REQUESTS=='undefined') || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone
	var result=window.AJAX_REQUESTS[index];
	if (synchronous)
	{
		window.AJAX_REQUESTS[index]=null;
	}
	return result;
}

function process_request_changes()
{
	if ((typeof window.AJAX_REQUESTS=='undefined') || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone

	// If any AJAX_REQUESTS are 'complete'
	var i,result;
	for (i=0;i<window.AJAX_REQUESTS.length;i++)
	{
		result=window.AJAX_REQUESTS[i];
		if ((result!=null) && (result.readyState) && (result.readyState==4))
		{
			window.AJAX_REQUESTS[i]=null;

			// If status is 'OK'
			if ((result.status) && ((result.status==200) || (result.status==500) || (result.status==400) || (result.status==401)))
			{
				//Process the result
				if ((window.AJAX_METHODS[i]) && (!result.responseXML/*Not payload handler and not stack trace*/ || result.responseXML.childNodes.length==0))
				{
					return window.AJAX_METHODS[i](result);
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
							if (result.status==12029) window.fauxmodal_alert('{!NETWORK_DOWN;^}');
							window.network_down=true;
						}
					} else
					{
						if (typeof console.log!='undefined') console.log('{!PROBLEM_RETRIEVING_XML;^}\n'+result.status+': '+result.statusText+'.');
					}
				}
				catch (e)
				{
					if (typeof console.log!='undefined') console.log('{!PROBLEM_RETRIEVING_XML;^}');		// This is probably clicking back
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
		if (typeof DOMParser!='undefined')
		{
			try { xml=(new DOMParser()).parseFromString(result.responseText,'application/xml'); }
			catch(e) {}
		} else
		{
			var ieDOM=['MSXML2.DOMDocument','MSXML.DOMDocument','Microsoft.XMLDOM'];
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
	if ((typeof window.AJAX_REQUESTS=='undefined') || (!window.AJAX_REQUESTS)) return null; // Probably the page is in process of being navigated away so window object is gone

	if (ajax_result_frame.getElementsByTagName('message')[0])
	{
		//Either an error or a message was returned. :(
		var message=ajax_result_frame.getElementsByTagName('message')[0].firstChild.data;

		if (ajax_result_frame.getElementsByTagName('error')[0])
		{
			//It's an error :|
			window.fauxmodal_alert('An error ('+ajax_result_frame.getElementsByTagName('error')[0].firstChild.data+') message was returned by the server: '+message);
			return null;
		}

		window.fauxmodal_alert('An informational message was returned by the server: '+message);
		return null;
	}

	var ajax_result=ajax_result_frame.getElementsByTagName('result')[0];
	if (!ajax_result) return null;

	if ((ajax_result_frame.getElementsByTagName('method')[0]) || (window.AJAX_METHODS[i]))
	{
		var method=(ajax_result_frame.getElementsByTagName('method')[0])?eval('return '+merge_text_nodes(ajax_result_frame.getElementsByTagName('method')[0])):window.AJAX_METHODS[i];
		if (typeof method.response!='undefined') method.response(ajax_result_frame,ajax_result);
		else method(ajax_result_frame,ajax_result);

	}// else window.fauxmodal_alert('Method required: as it is non-blocking');

	return null;
}

function create_xml_doc()
{
	var xml_doc;

	if (typeof window.ActiveXObject!='undefined')
	{
		xml_doc=new ActiveXObject('Microsoft.XMLDOM');
	}
	else if (document.implementation && document.implementation.createDocument)
	{
	  xml_doc=document.implementation.createDocument('','',null);
	}
	return xml_doc;
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


