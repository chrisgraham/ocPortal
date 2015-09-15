"use strict";

var last_message_id=0;
var last_timestamp=0;
var last_event_id=0;
var message_checking=false;
var no_im_html;
var picker,picker_node,text_colour;
var opened_popups={};
var topZIndex=800;
var load_from_room_id;

window.hasFocus=true;
add_event_listener_abstract(window,'blur',function() { window.hasFocus=false; });
add_event_listener_abstract(window,'focus',function() { window.hasFocus=true; });

function play_sound_url(url) // Used for testing different sounds
{
	if (typeof window.soundManager=='undefined') return;

	var base_url=((url.indexOf('data_custom')==-1)&&(url.indexOf('uploads/')==-1))?'{$BASE_URL_NOHTTP;}':'{$CUSTOM_BASE_URL_NOHTTP;}';
	soundManager.destroySound('temp');
	soundManager.createSound('temp',base_url+'/'+url);
	soundManager.play('temp');
}

function play_chat_sound(sID,for_member)
{
	if (typeof window.soundManager=='undefined') return;

	var play_sound=window.document.getElementById('play_sound');

	if ((play_sound) && (!play_sound.checked)) return;

	if (for_member)
	{
		var override=top_window.soundManager.getSoundById(sID+'_'+for_member,true);
		if (override)
		{
			sID=sID+'_'+for_member;
		}
	}

	top_window.soundManager.play(sID);
}

function chat_load(room_id)
{
	window.top_window=window;

	try
	{
		document.getElementById("post").focus();
	}
	catch (e) {};

	if (window.location.href.indexOf('keep_chattest')==-1) begin_chatting(room_id);

	text_colour=document.getElementById('text_colour');
	if (text_colour) text_colour.style.color=text_colour.value;

	var event=YAHOO.util.Event;

	event.onDOMReady(load_colour_picker);

	manage_scroll_height(document.getElementById('post'));
}

function begin_chatting(room_id)
{
	window.load_from_room_id=room_id;

	if ((window.chat_check) && (window.do_ajax_request)) chat_check(true,0); else window.setTimeout(begin_chatting,500);

	if (typeof window.play_chat_sound!='undefined') play_chat_sound('you_connect');
}

function check_chat_options(ob)
{
	if (!ob.elements['text_colour'].value.match(/^#[0-9A-F][0-9A-F][0-9A-F]([0-9A-F][0-9A-F][0-9A-F])?$/))
	{
		window.fauxmodal_alert('{!BAD_HTML_COLOUR;^}');
		return false;
	}

	return check_form(ob);
}

function dec_to_hex(number)
{
	var hexbase="0123456789ABCDEF";
	return hexbase.charAt((number>>4)&0xf)+hexbase.charAt(number&0xf);
}

function hexToDec(number)
{
	return parseInt(number,16);
}

function update_picker_colour()
{
	picker.setValue([hexToDec(text_colour.value.substr(1,2)),hexToDec(text_colour.value.substr(3,2)),hexToDec(text_colour.value.substr(5,2))],false);
	picker_node.style.left=find_pos_x(text_colour)+'px';
	picker_node.style.top=(find_pos_y(text_colour)+25)+'px';
}

function onRgbChange(o)
{
	var value='#'+dec_to_hex(o.newValue[0])+dec_to_hex(o.newValue[1])+dec_to_hex(o.newValue[2]);
	text_colour.value=value;
	text_colour.style.color=value;
	document.getElementById('colour').value=value;
	//document.getElementById('post').style.color=value;
}

function onFontChange(o)
{
	var value=o.options[o.selectedIndex].value;
	document.getElementById('font').value=value;
	document.getElementById('post').style.fontFamily=value;
	manage_scroll_height(document.getElementById('post'));
}

function load_colour_picker()
{
	picker_node=document.createElement('div');
	picker_node.style.width='305px';
	picker_node.style.height='192px';
	picker_node.style.visibility='hidden';
	picker_node.style.border='1px solid black';
	picker_node.style.backgroundColor='white';
	picker_node.style.position='absolute';
	picker_node.id='colour_picker';
	text_colour.form.appendChild(picker_node);
	picker=new YAHOO.widget.ColorPicker("colour_picker", {
		showhexsummary: false,
		showrgbcontrols: false,
		showwebsafe: false,
		images: {
	       PICKER_THUMB: "{$IMG#,colour_picker/picker_thumb}",
	       HUE_THUMB: "{$IMG#,colour_picker/hue_thumb}"
	   }
	});
	update_picker_colour();
	picker.on("rgbChange",onRgbChange);
	picker_node.ondblclick=function() { picker_node.style.visibility='hidden'; };
}

function get_ticked_people(form)
{
	var people='';

	for (var i=0;i<form.elements.length;i++)
	{
		if ((form.elements[i].type=='checkbox') && (form.elements[i].checked))
			people+=((people!='')?',':'')+form.elements[i].name.substr(7);
	}

	if (people=='')
	{
		window.fauxmodal_alert('{!NOONE_SELECTED_YET;^}');
		return false;
	}

	return people;
}

function do_input_private_message(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	window.fauxmodal_prompt(
		'{!ENTER_RECIPIENT;^}',
		'',
		function(va)
		{
			if (va!=null)
			{
				var vb=window.fauxmodal_prompt(
					'{!MESSAGE;^}',
					'',
					function(vb)
					{
						if (vb!=null) insert_textbox(document.getElementById(field_name),"[private=\""+va+"\"]"+vb+"[/private]");
					},
					'{!chat:INPUT_CHATCODE_private_message;^}'
				);
			}
		},
		'{!chat:INPUT_CHATCODE_private_message;^}'
	);
}

function do_input_invite(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	window.fauxmodal_prompt(
		'{!ENTER_RECIPIENT;^}',
		'',
		function(va)
		{
			if (va!=null)
			{
				var vb=window.fauxmodal_prompt(
					'{!ENTER_ROOM;^}',
					'',
					function(vb)
					{
						if (vb!=null) insert_textbox(document.getElementById(field_name),"[invite=\""+va+"\"]"+vb+"[/invite]");
					},
					'{!chat:INPUT_CHATCODE_invite;^}'
				);
			}
		},
		'{!chat:INPUT_CHATCODE_invite;^}'
	);
}

function do_input_new_room(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	window.fauxmodal_prompt(
		'{!ENTER_ROOM;^}',
		'',
		function(va)
		{
			if (va!=null)
			{
				var vb=window.prompt(
					'{!ENTER_ALLOW;^}',
					'',
					function(vb)
					{
						if (vb!=null) insert_textbox(document.getElementById(field_name),"[newroom=\""+va+"\"]"+vb+"[/newroom]");
					},
					'{!chat:INPUT_CHATCODE_new_room;^}'
				);
			}
		},
		'{!chat:INPUT_CHATCODE_new_room;^}'
	);
}

// Post a chat message
function chat_post(event,current_room_id,field_name,font_name,font_colour)
{
	// Catch the data being submitted by the form, and send it through XMLHttpRequest if possible. Stop the form submission if this is achieved.
	if ((window.do_ajax_request) && (typeof window.do_ajax_request!='undefined'))
	{
		var element=document.getElementById(field_name);
		cancel_bubbling(event,element);
		var message_text=element.value;

		if (message_text!='')
		{
			if (top_window.cc_timer) {	top_window.clearTimeout(top_window.cc_timer); top_window.cc_timer=null; }

			// Send it through XMLHttpRequest, and append the results.
			var url="{$FIND_SCRIPT,messages}?action=post";
			element.disabled=true;
			top_window.currently_sending_message=true;
			var result=do_ajax_request(maintain_theme_in_link(url)+top_window.keep_stub(false),null,"room_id="+window.encodeURIComponent(current_room_id)+"&message="+window.encodeURIComponent(message_text)+"&font="+window.encodeURIComponent(font_name)+"&colour="+window.encodeURIComponent(font_colour)+"&message_id="+window.encodeURIComponent(top_window.last_message_id)+"&event_id="+window.encodeURIComponent(top_window.last_event_id)+keep_stub(false));
			top_window.currently_sending_message=false;
			element.disabled=false;

			var responses=result.responseXML.getElementsByTagName('result');
			if (responses[0])
			{
				_handle_signals(false,true,responses[0]);

				window.setTimeout(function() { element.value=""; },20);
				element.style.height='auto';

				if (typeof window.play_chat_sound!='undefined') play_chat_sound('message_sent');
			} else
			{
				window.fauxmodal_alert('{!MESSAGE_POSTING_ERROR;^}');
			}

			// Reschedule the next check
			top_window.cc_timer=top_window.setTimeout("chat_check(false,"+top_window.last_message_id+","+top_window.last_event_id+");",10000);

			try
			{
				element.focus();
			}
			catch (e) {};
		}

		return false;
	}
	else
	{
		// Let the form be submitted the old-fashioned way.
		return true;
	}

	return null;
}

// Check for new messages
function chat_check(backlog,message_id,event_id)
{
	if (window.currently_sending_message) // We'll reschedule once our currently-in-progress message is sent
	{
		return null;
	}

	if ((typeof event_id=='undefined') || (!event_id)) var event_id=-1; // Means, we don't want to look at events, but the server will give us a null event

	// Check for new messages on the server the new or old way
	if ((typeof window.do_ajax_request!='undefined') && (window.do_ajax_request))
	{
		// AJAX!
		window.setTimeout("chat_check_timeout("+backlog+","+message_id+","+event_id+");",11000);
		var the_date=new Date();
		if ((!window.message_checking) || (parseInt(window.message_checking)+10000<=the_date.getTime())) // If not currently in process, or process stalled
		{
			window.message_checking=the_date.getTime();
			var url;
			if (backlog)
			{
				url="{$FIND_SCRIPT*,messages}?action=all&room_id="+window.encodeURIComponent(load_from_room_id);
			} else
			{
				url="{$FIND_SCRIPT*,messages}?action=new&room_id="+window.encodeURIComponent(load_from_room_id)+"&message_id="+window.encodeURIComponent(message_id)+"&event_id="+window.encodeURIComponent(event_id);
			}
			if (window.location.href.indexOf('no_reenter_message=1')!=-1) url=url+'&no_reenter_message=1';
			do_ajax_request(maintain_theme_in_link(url+keep_stub(false)),chat_check_response,false);
			return false;
		}
		return null;
	} else
	{
		// Resort to reloading the page
		window.location.reload(true);
		return true;
	}

	return null;
}

// Check to see if there's been a packet loss
function chat_check_timeout(backlog,message_id,event_id)
{
	var the_date=new Date();
	if ((window.message_checking) && (parseInt(window.message_checking)<=the_date.getTime()-10500) && (!window.currently_sending_message)) // If we are awaiting a response (message_checking is not false, and that response was made more than 10.5 seconds ago
	{
		// Our response is tardy
		chat_check(backlog,message_id,event_id);
	}
}

// Deal with the new messages response
function chat_check_response(ajax_result_frame,ajax_result)
{
	var temp=_handle_signals(true,false,ajax_result);
	if (temp==-2) return false;
	//if (!window.current_room_id) window.current_room_id=temp;

	// Schedule the next check
	if (window.cc_timer) {	window.clearTimeout(window.cc_timer); window.cc_timer=null; }
	window.cc_timer=window.setTimeout("chat_check(false,"+window.last_message_id+","+window.last_event_id+");",10000);

	window.message_checking=false; // All must be ok so say we are happy we got a response and scheduled the next check

	return true;
}

function handle_signals(ajax_result_frame,ajax_result)
{
	_handle_signals(false,false,ajax_result);
}

function _handle_signals(not_ajax_direct,skip_incoming_sound,ajax_result)
{
	if (!ajax_result) return; // Some kind of error happened

	var messages=ajax_result.childNodes;
	var message_container=document.getElementById("messages_window");
	var message_container_global=(message_container!=null);
	var _cloned_message,cloned_message;
	var current_room_id=-1;
	var tabElement;
	var flashable_alert=false;
	var username,room_name,room_id,event_type,member_id,tmp_element,rooms,avatar_url,participants;
	var id,timestamp;
	var first_set=false;
	var play_chat_sound;
	var newest_id_here=null,newest_timestamp_here=null;

	// Look through our messages
	for(var i=0;i<messages.length;i++)
	{
		if (messages[i].nodeName=='chat_null')
		{
			current_room_id=merge_text_nodes(messages[i].childNodes);
		} else
		if (messages[i].nodeName=='div')
		{
			// Find out about our message
			id=messages[i].getAttribute("id");
			timestamp=messages[i].getAttribute("timestamp");
			if (!id) id=messages[i].id; // Weird fix for Opera
			if (((top_window.last_message_id) && (parseInt(id)<=top_window.last_message_id)) && ((top_window.last_timestamp) && (parseInt(timestamp)<=top_window.last_timestamp))) continue;
			newest_id_here=parseInt(id);
			if ((newest_timestamp_here=null) || (newest_timestamp_here<parseInt(timestamp))) newest_timestamp_here=parseInt(timestamp);

			// Find container to place message
			play_chat_sound=window.play_chat_sound;
			if (!message_container_global)
			{
				room_id=messages[i].getAttribute("room_id");
				current_room_id=room_id;
			} else
			{
				current_room_id=messages[i].getAttribute("room_id");
			}
			if (document.getElementById("messages_window_"+current_room_id))
			{
				message_container=document.getElementById("messages_window_"+current_room_id);
				tabElement=document.getElementById('tab_'+current_room_id);
				if ((tabElement) && (tabElement.className.indexOf('chat_lobby_convos_current_tab')==-1))
				{
					tabElement.className=((tabElement.className.indexOf('chat_lobby_convos_tab_first')!=-1)?'chat_lobby_convos_tab_first ':'')+'chat_lobby_convos_tab_new_messages';
				}
			} else if ((opened_popups['room_'+current_room_id]) && (opened_popups['room_'+current_room_id].document)) // Popup
			{
				message_container=opened_popups['room_'+current_room_id].document.getElementById("messages_window_"+current_room_id);
				play_chat_sound=opened_popups['room_'+current_room_id].play_chat_sound;
			} else if (!message_container_global) continue; // Still no luck

			var doc=document;
			if (opened_popups['room_'+current_room_id])
			{
				if (!opened_popups['room_'+current_room_id].document) continue;
				doc=opened_popups['room_'+current_room_id].document;
			}

			if (!message_container_global)
			{
				current_room_id=-1;
			}

			// Clone the node so that we may insert it
			_cloned_message=careful_import_node(messages[i].childNodes[0]);
			if (typeof _cloned_message.xml!='undefined')
			{
				cloned_message=doc.createElement('div');
				set_inner_html(cloned_message,_cloned_message.xml); // Fixes IE bug
			} else cloned_message=_cloned_message.cloneNode(true);
			if ((browser_matches('safari')) || (!_cloned_message.className))
			{
				cloned_message=doc.createElement('div');
				set_inner_html(cloned_message,get_outer_html(_cloned_message)); // Fixes Chrome bug
				cloned_message=cloned_message.childNodes[0];
			}
			cloned_message.setAttribute("id","chat_message_id"+id);

			// Non-first message
			if ((message_container.childNodes.length>0) && (get_inner_html(message_container).length>6))
			{
				message_container.insertBefore(cloned_message,message_container.childNodes[0]);

				if (!first_set) // Only if no other message sound already for this event update
				{
					if (!skip_incoming_sound) if (typeof window.play_chat_sound!='undefined') play_chat_sound(window.hasFocus?'message_received':'message_background',messages[i].getAttribute('sender_id'));
					flashable_alert=true;
				}
			} else // First message
			{
				set_inner_html(message_container,'');
				message_container.appendChild(cloned_message);
				first_set=true; // Let the code know the first set of messages has started, squashing any extra sounds for this event update
				if (!skip_incoming_sound) if (typeof window.play_chat_sound!='undefined') play_chat_sound('message_initial');
			}
		}
		else if (messages[i].nodeName=='chat_members_update')
		{
			var members_element=document.getElementById('chat_members_update');
			if (members_element) set_inner_html(members_element,merge_text_nodes(messages[i].childNodes));
		}
		else if ((messages[i].nodeName=='chat_event') && (window.im_participant_template))
		{
			event_type=messages[i].getAttribute('event_type');
			room_id=messages[i].getAttribute('room_id');
			member_id=messages[i].getAttribute('member_id');
			username=messages[i].getAttribute('username');
			avatar_url=messages[i].getAttribute('avatar_url');

			id=merge_text_nodes(messages[i].childNodes);
			if (id!='') top_window.last_event_id=id;

			switch (event_type)
			{
				case 'BECOME_ACTIVE':
					flashable_alert=true;
					tmp_element=document.getElementById('online_'+member_id);
					if (tmp_element)
					{
						set_inner_html(tmp_element,'{!ACTIVE;^}');
						document.getElementById('friend_img_'+member_id).className='friend_active';
						var alert_box_wrap=document.getElementById('alert_box_wrap');
						alert_box_wrap.style.display='block';
						var alert_box=document.getElementById('alert_box');
						set_inner_html(alert_box,'{!NOW_ONLINE;^}'.replace('{'+'1}',username));
						window.setTimeout(function () { if (get_inner_html(alert_box)==get_inner_html(document.getElementById('alert_box'))) alert_box_wrap.style.display='none'; } , 7000);
					} else if (!document.getElementById('chat_lobby_convos_tabs'))
					{
						create_overlay_event(member_id,'{!NOW_ONLINE;^}'.replace('{'+'1}',username),function() { start_im(member_id); return false; } ,avatar_url);
					}
					rooms=find_im_convo_room_ids();
					for (var r in rooms)
					{
						room_id=rooms[r];
						var doc=document;
						if (opened_popups['room_'+room_id])
						{
							if (!opened_popups['room_'+room_id].document) continue;
							doc=opened_popups['room_'+room_id].document;
						}
						tmp_element=doc.getElementById('participant_online__'+room_id+'__'+member_id);
						if (tmp_element)
						{
							set_inner_html(tmp_element,'{!ACTIVE;^}');
						}
					}
					play_chat_sound=window.play_chat_sound;
					if (typeof window.play_chat_sound!='undefined') play_chat_sound('contact_on',member_id);
					break;
				case 'BECOME_INACTIVE':
					tmp_element=document.getElementById('online_'+member_id);
					if (tmp_element)
					{
						set_inner_html(tmp_element,'{!INACTIVE;^}');
						document.getElementById('friend_img_'+member_id).className='friend_inactive';
					}
					rooms=find_im_convo_room_ids();
					for (var r in rooms)
					{
						room_id=rooms[r];
						var doc=document;
						if (opened_popups['room_'+room_id])
						{
							if (!opened_popups['room_'+room_id].document) continue;
							doc=opened_popups['room_'+room_id].document;
						}
						tmp_element=doc.getElementById('participant_online__'+room_id+'__'+member_id);
						if (tmp_element) set_inner_html(tmp_element,'{!INACTIVE;^}');
					}
					play_chat_sound=window.play_chat_sound;
					if (typeof window.play_chat_sound!='undefined') play_chat_sound('contact_off',member_id);
					break;
				case 'JOIN_IM':
					play_chat_sound=window.play_chat_sound;
					if (opened_popups['room_'+room_id]) play_chat_sound=opened_popups['room_'+room_id].play_chat_sound;
					add_im_member(room_id,member_id,username,messages[i].getAttribute('away')=='1',avatar_url);
					if (typeof window.play_chat_sound!='undefined') play_chat_sound('contact_on',member_id);
					break;
				case 'PREINVITED_TO_IM':
					play_chat_sound=window.play_chat_sound;
					if (opened_popups['room_'+room_id]) play_chat_sound=opened_popups['room_'+room_id].play_chat_sound;
					add_im_member(room_id,member_id,username,messages[i].getAttribute('away')=='1',avatar_url);
					break;
				case 'DEINVOLVE_IM':
					play_chat_sound=window.play_chat_sound;
					if (opened_popups['room_'+room_id]) play_chat_sound=opened_popups['room_'+room_id].play_chat_sound;
					tmp_element=document.getElementById('participant__'+room_id+'__'+member_id);
					if ((tmp_element) && (tmp_element.parentNode))
					{
						var parent=tmp_element.parentNode;
						parent.removeChild(tmp_element);
						if (parent.childNodes.length==0)
						{
							set_inner_html(parent,'<em class="none">{!NONE;^}</em>');
						}
						if (typeof window.play_chat_sound!='undefined') play_chat_sound('contact_off',member_id);
					}
					break;
			}

		} else
		if ((messages[i].nodeName=='chat_invite') && (window.im_participant_template))
		{
			room_id=merge_text_nodes(messages[i].childNodes);
			if ((!document.getElementById('room_'+room_id)) && (!opened_popups['room_'+room_id]))
			{
				play_chat_sound=window.play_chat_sound;
				if (opened_popups['room_'+room_id]) play_chat_sound=opened_popups['room_'+room_id].play_chat_sound;

				room_name=messages[i].getAttribute('room_name');
				avatar_url=messages[i].getAttribute('avatar_url');
				participants=messages[i].getAttribute('participants');
				var is_new=(messages[i].getAttribute('num_posts')=='0');
				var by_you=messages[i].getAttribute('inviter')!=messages[i].getAttribute('you');
				if (((is_new) || (by_you)) && (!window.instant_go) && (!document.getElementById('chat_lobby_convos_tabs')))
				{
					opened_popups['room_'+room_id]='pending';
					create_overlay_event(messages[i].getAttribute('inviter'),'{!IM_INFO_CHAT_WITH;^}'.replace('{'+'1}',room_name),function() { detected_conversation(room_id,room_name,participants); return false; } ,avatar_url,room_id);
				} else
				{
					detected_conversation(room_id,room_name,participants);
				}
				flashable_alert=true;

				if ((!skip_incoming_sound) && (by_you))
				{
					if (typeof window.play_chat_sound!='undefined') play_chat_sound('invited',messages[i].getAttribute('inviter'));
				}
			}
		}
	}

	// Get attention, as something happening
	if (flashable_alert)
	{
		if ((room_id) && (opened_popups['room_'+room_id]))
		{
			if (typeof opened_popups['room_'+room_id].getAttention!='undefined') opened_popups['room_'+room_id].getAttention();
			if (typeof opened_popups['room_'+room_id].focus!='undefined')
			{
				try
				{
					opened_popups['room_'+room_id].focus();
				}
				catch (e) {};
			}
			if (opened_popups['room_'+room_id].document)
			{
				var post=opened_popups['room_'+room_id].document.getElementById('post');
				if (post)
				{
					try
					{
						post.focus();
					}
					catch (e) {};
				}
			}
		} else
		{
			if (typeof window.getAttention!='undefined') window.getAttention();
			if (typeof window.focus!='undefined')
			{
				try
				{
					window.focus();
				}
				catch (e) {};
			}
			var post=document.getElementById('post');
			if (post)
			{
				try
				{
					post.focus();
				}
				catch (e) {};
			}
		}
	}

	if ((top_window.last_message_id==null) || (top_window.last_message_id<newest_id_here))
	{
		top_window.last_message_id=newest_id_here;
	}
	if (top_window.last_timestamp<newest_timestamp_here)
		top_window.last_timestamp=newest_timestamp_here;

	return current_room_id;
}

function create_overlay_event(member_id,message,click_event,avatar_url,room_id)
{
	if (window!=top_window) return;

	var close_popup=function() {
		if (div)
		{
			if (room_id)
			{
				generate_question_ui(
					'{!HOW_REMOVE_CHAT_NOTIFICATION;^}',
					{/*cancel: '{!INPUTSYSTEM_CANCEL;^}',*/close: '{!CLOSE;^}',ignore: '{!HIDE;^}'},
					'{!REMOVE_CHAT_NOTIFICATION;^}',
					null,
					function(answer)
					{
						/*if (answer.toLowerCase()=='{!INPUTSYSTEM_CANCEL;^}'.toLowerCase()) return;*/
						if (answer.toLowerCase()=='{!CLOSE;^}'.toLowerCase())
						{
							deinvolve_im(room_id,false,true);
						}
						document.body.removeChild(div);
						div=null;
					}
				);
			} else
			{
				document.body.removeChild(div);
				div=null;
			}
		}
	};

	var div=document.createElement('div');
	div.className='im_event';
	div.style.zIndex=topZIndex++;
	var imgclose=document.createElement('img');
	imgclose.setAttribute('src','{$IMG;,tableitem/delete}'.replace(/^https?:/,window.location.protocol));
	imgclose.className='im_popup_close_button blend';
	imgclose.onclick=close_popup;
	div.appendChild(imgclose);
	if (avatar_url)
	{
		var img1=document.createElement('img');
		img1.setAttribute('src',avatar_url);
		img1.className='im_popup_avatar';
		div.appendChild(img1);
	}
	var div2=document.createElement('div');
	set_inner_html(div2,message);
	div.appendChild(div2);
	var a3=document.createElement('a');
	a3.onclick=function() { click_event(); document.body.removeChild(div); div=null; return false; };
	a3.href='#';
	set_inner_html(a3,'{!OPEN_IM_POPUP;^}');
	a3.className='im_popup_link';
	var opened_popups_cnt=0;
	for (var i=0;i<opened_popups.length;i++)
	{
		if (opened_popups[i]) opened_popups_cnt++;
	}
	if (opened_popups_cnt==0) div.appendChild(a3);
	var a4=document.createElement('a');
	a4.href=window.lobby_link.replace('%21%21',member_id);
	a4.onclick=close_popup;
	set_inner_html(a4,'{!GOTO_CHAT_LOBBY;^}');
	a4.className='im_event_lobby_link';
	div.appendChild(a4);
	div.style.left=(get_window_width()/2-140)+'px';
	div.style.top=(get_window_height()+get_window_scroll_y()-(topZIndex-800)*100)+'px';

	document.body.appendChild(div);
}

function start_im(people)
{
	var message=(people.indexOf(',')==-1)?'{!ALREADY_HAVE_THIS_SINGLE;^}':'{!ALREADY_HAVE_THIS;^}';
	if (all_conversations[people])
	{
		window.fauxmodal_confirm(
			message,
			function(answer) {
				if (answer) _start_im(people);
			}
		);

		return;
	}

	_start_im(people);
}

function _start_im(people)
{
	all_conversations[people]=1;

	var div=document.createElement('div');
	div.className='loading_overlay';
	set_inner_html(div,'{!LOADING;^}');
	document.body.appendChild(div);
	var result=do_ajax_request(maintain_theme_in_link('{$FIND_SCRIPT;,messages}?action=start_im&people='+people+'&message_id='+window.encodeURIComponent(top_window.last_message_id)+'&event_id='+window.encodeURIComponent(top_window.last_event_id)+keep_stub(false)));
	var responses=result.responseXML.getElementsByTagName('result');
	if (responses[0])
	{
		window.instant_go=true;
		_handle_signals(false,true,responses[0]);
		window.instant_go=false;
	}
	document.body.removeChild(div);
}

function invite_im(people)
{
	var room_id=find_current_im_room();
	if (!room_id)
	{
		window.fauxmodal_alert('{!NO_IM_ACTIVE;^}');
	} else
	{
		do_ajax_request('{$FIND_SCRIPT;,messages}?action=invite_im&room_id='+window.encodeURIComponent(room_id)+'&people='+people+keep_stub(false));
	}
}

function count_im_convos()
{
	var chat_lobby_convos_tabs=document.getElementById('chat_lobby_convos_tabs');
	var count=0,i;
	for (i=0;i<chat_lobby_convos_tabs.childNodes.length;i++)
	{
		if (chat_lobby_convos_tabs.childNodes[i].nodeName=='#text') continue;
		if (chat_lobby_convos_tabs.childNodes[i].id.substr(0,4)=='tab_') count++;
	}
	return count;
}

function find_im_convo_room_ids()
{
	var chat_lobby_convos_tabs=document.getElementById('chat_lobby_convos_tabs');
	var rooms=[],i;
	if (!chat_lobby_convos_tabs)
	{
		for (i in opened_popups)
		{
			if (i.substr(0,5)=='room_')
			{
				rooms.push(window.parseInt(i.substr(5)));
			}
		}
		return rooms;
	}
	for (i=0;i<chat_lobby_convos_tabs.childNodes.length;i++)
	{
		if (chat_lobby_convos_tabs.childNodes[i].nodeName=='#text') continue;
		if (chat_lobby_convos_tabs.childNodes[i].id.substr(0,4)=='tab_') rooms.push(window.parseInt(chat_lobby_convos_tabs.childNodes[i].id.substr(4)));
	}
	return rooms;
}

function close_chat_conversation(ob,room_id)
{
	generate_question_ui(
		'{!WANT_TO_DOWNLOAD_LOGS*;^}',
		{cancel: '{!INPUTSYSTEM_CANCEL*;^}',ok: '{!YES*;^}',no: '{!NO*;^}'},
		'{!CHAT_DOWNLOAD_LOGS*;^}',
		null,
		function(logs)
		{
			if (logs.toLowerCase()!='{!INPUTSYSTEM_CANCEL*;^}'.toLowerCase())
			{
				if (logs.toLowerCase()=='{!YES*;^}'.toLowerCase())
				{
					window.open('{$FIND_SCRIPT*;,dllogs}?room='+room_id+'{$KEEP*;^}');
				}
				deinvolve_im(room_id,logs=='{!YES*;^}',true);
				window.setTimeout(function() { if (document.body.className.indexOf('sitewide_im_popup_body')!=-1) window.close(); } ,1000);
			}
		}
	);
}

function deinvolve_im(room,logs,is_not_window)
{
	if (!is_not_window)
	{
		var body=document.getElementsByTagName('body');
		if (typeof body[0]!='undefined')
		{
			body[0].className+=' site_unloading';
			set_inner_html(body[0],'<div class="spaced"><div aria-busy="true" class="ajax_tree_list_loading vertical_alignment"><img src="'+'{$IMG*;,loading}'.replace(/^https?:/,window.location.protocol)+'" alt="{!LOADING;^}" /> <span>{!LOADING;^}<\/span><\/div><\/div>');
		}
	}

	var element;
	var tabs=document.getElementById('chat_lobby_convos_tabs');
	if (tabs)
	{
		element=document.getElementById('room_'+room);
		if (!element) return; // Probably already been clicked once, lag

		var tab_element=document.getElementById('tab_'+room);
		element.style.display='none';
		tab_element.style.display='none';
	}

	window.setTimeout(function() // Give time for any logs to download
	{
		do_ajax_request('{$FIND_SCRIPT;,messages}?action=deinvolve_im&room_id='+window.encodeURIComponent(room)+top_window.keep_stub(false));

		if (tabs)
		{
			if ((element) && (element.parentNode)) element.parentNode.removeChild(element);
			if (!tab_element.parentNode) return;

			all_conversations[tab_element.participants]=false;
			tab_element.parentNode.removeChild(tab_element);

			// All gone?
			var count=count_im_convos();
			if (count==0)
			{
				set_inner_html(tabs,'&nbsp;');
				document.getElementById('chat_lobby_convos_tabs').style.display='none';
				set_inner_html(document.getElementById('chat_lobby_convos_areas'),no_im_html);
				if (document.getElementById('invite_ongoing_im_button')) document.getElementById('invite_ongoing_im_button').disabled=true;
			} else
			{
				chat_select_tab(document.getElementById('tab_'+find_im_convo_room_ids().pop()));
			}
		} else if (!is_not_window)
		{
			window.onbeforeunload=null;
			window.close();
		}
	}, logs?10000:100);
}

function detected_conversation(room_id,room_name,participants) // Assumes conversation is new: something must check that before calling here
{
	var areas=document.getElementById('chat_lobby_convos_areas');
	var tabs=document.getElementById('chat_lobby_convos_tabs');
	var lobby;
	if (tabs) // Chat lobby
	{
		tabs.style.display='block';
		if (document.getElementById('invite_ongoing_im_button')) document.getElementById('invite_ongoing_im_button').disabled=false;
		var count=count_im_convos();
		// First one?
		if (count==0)
		{
			no_im_html=get_inner_html(areas);
			set_inner_html(areas,'');
			set_inner_html(tabs,'');
		}

		lobby=true;
	} else // Not chat lobby (sitewide IM)
	{
		lobby=false;
	}

	all_conversations[participants]=1;

	var url='{$FIND_SCRIPT_NOHTTP;,messages}?action=join_im&room_id='+window.encodeURIComponent(room_id)+'&event_id='+top_window.last_event_id+top_window.keep_stub(false);

	// Add in
	var new_one=im_area_template.replace(/\_\_room_id\_\_/g,room_id).replace(/\_\_room\_name\_\_/g,room_name);
	if (lobby)
	{
		var new_div;
		new_div=document.createElement('div');
		set_inner_html(new_div,new_one);
		areas.appendChild(new_div);

		// Add tab
		new_div=document.createElement('div');
		new_div.className='chat_lobby_convos_tab_uptodate'+((count==0)?' chat_lobby_convos_tab_first':'');
		set_inner_html(new_div,escape_html(room_name));
		new_div.setAttribute('id','tab_'+room_id);
		new_div.participants=participants;
		new_div.onclick=function() { chat_select_tab(new_div); } ;
		tabs.appendChild(new_div);
		chat_select_tab(new_div);

		// Tell server we've joined
		do_ajax_request(url,handle_signals,false);
	} else
	{
		// Open popup
		var new_window=window.open('{$BASE_URL;,0}'.replace(/^https?:/,window.location.protocol)+'/data/empty.html','room_'+room_id,'width=370,height=415,menubar=no,toolbar=no,location=no,resizable=no,scrollbars=yes,top='+((screen.height-520)/2)+',left='+((screen.width-440)/2));
		window.setTimeout(function() // Needed for Safari to set the right domain
		{
			opened_popups['room_'+room_id]=new_window;

			if ((new_window) && (typeof new_window.document!='undefined'))
			{
				new_window.document.open();
				new_window.document.write(new_one);
				new_window.document.close()
				new_window.top_window=window;
				new_window.room_id=room_id;

				window.setTimeout(function() // Give time for XHTML to render
				{
					if (!new_window.document) return;

					new_window.document.title=get_inner_html(new_window.document.getElementsByTagName('title')[0]); // For Safari

					/*new_window.onbeforeunload=function() {
						deinvolve_im(room_id,false);
					};*/

					try
					{
						new_window.focus();
					}
					catch (e) {};

					// Tell server we've joined
					do_ajax_request(url,handle_signals,false);
				},0);
			}
		},1000);
	}
}

function add_im_member(room_id,member_id,username,away,avatar_url)
{
	window.setTimeout(function() {
		var doc=document;
		if (opened_popups['room_'+room_id])
		{
			if (!opened_popups['room_'+room_id].document) return;
			doc=opened_popups['room_'+room_id].document;
		}
		if (away)
		{
			var tmp_element=doc.getElementById('online_'+member_id);
			if ((tmp_element) && (get_inner_html(tmp_element)=='{!ACTIVE;^}')) away=false;
		}
		if (doc.getElementById('participant__'+room_id+'__'+member_id)) return; // They're already put in it
		var new_participant=doc.createElement('div');
		var new_participant_inner=im_participant_template.replace(/\_\_username\_\_/g,username);
		new_participant_inner=new_participant_inner.replace(/\_\_id\_\_/g,member_id);
		new_participant_inner=new_participant_inner.replace(/\_\_room\_id\_\_/g,room_id);
		new_participant_inner=new_participant_inner.replace(/\_\_avatar\_url\_\_/g,avatar_url);
		if (avatar_url=='') new_participant_inner=new_participant_inner.replace('style="display: block" id="avatar__','style="display: none" id="avatar__');
		new_participant_inner=new_participant_inner.replace(/\_\_online\_\_/g,away?'{!INACTIVE;^}':'{!ACTIVE;^}');
		set_inner_html(new_participant,new_participant_inner);
		new_participant.setAttribute('id','participant__'+room_id+'__'+member_id);
		var element=doc.getElementById('participants__'+room_id);
		if (element) // If we've actually got the HTML for the room setup
		{
			var p_list=get_inner_html(element).toLowerCase();

			if ((p_list.indexOf('<em class="none">')!=-1) || (p_list.indexOf('<em class="loading">')!=-1))
				set_inner_html(element,'');
			element.appendChild(new_participant);
			if (doc.getElementById('friend_img_'+member_id)) doc.getElementById('friend__'+member_id).style.display='none';
		}
	}, 2000);
}

function find_current_im_room()
{
	var i;
	var chat_lobby_convos_tabs=document.getElementById('chat_lobby_convos_tabs');
	for (i=0;i<chat_lobby_convos_tabs.childNodes.length;i++)
	{
		if ((chat_lobby_convos_tabs.childNodes[i].nodeName.toLowerCase()=='div') && (chat_lobby_convos_tabs.childNodes[i].className.indexOf('chat_lobby_convos_current_tab')!=-1))
		{
			return window.parseInt(chat_lobby_convos_tabs.childNodes[i].id.substr(4));
		}
	}
	return null;
}

function chat_select_tab(element)
{
	var i;
	var chat_lobby_convos_tabs=document.getElementById('chat_lobby_convos_tabs');
	for (i=0;i<chat_lobby_convos_tabs.childNodes.length;i++)
	{
		if (chat_lobby_convos_tabs.childNodes[i].className.indexOf('chat_lobby_convos_current_tab')!=-1)
		{
			chat_lobby_convos_tabs.childNodes[i].className=((chat_lobby_convos_tabs.childNodes[i].className.indexOf('chat_lobby_convos_tab_first')!=-1)?'chat_lobby_convos_tab_first ':'')+'chat_lobby_convos_tab_uptodate';
			document.getElementById('room_'+chat_lobby_convos_tabs.childNodes[i].id.substr(4)).style.display='none';
			break;
		}
	}

	document.getElementById('room_'+element.id.substr(4)).style.display='block';
	try
	{
		document.getElementById('post_'+element.id.substr(4)).focus();
	}
	catch (e) {};
	element.className=((element.className.indexOf('chat_lobby_convos_tab_first')!=-1)?'chat_lobby_convos_tab_first ':'')+'chat_lobby_convos_tab_uptodate chat_lobby_convos_current_tab';
}


