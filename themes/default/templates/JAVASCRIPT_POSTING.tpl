"use strict";

/* Form editing code (mostly stuff only used on posting forms) */

// ===========
// ATTACHMENTS
// ===========

function add_attachment(start_num,posting_field_name)
{
	if (typeof window.num_attachments=='undefined') return;
	if (typeof window.max_attachments=='undefined') return;

	var add_to=document.getElementById('attachment_store');

	window.num_attachments++;

	var new_div=document.createElement('div');
	set_inner_html(new_div,window.attachment_template.replace(/\_\_num_attachments\_\_/g,window.num_attachments));
	add_to.appendChild(new_div);
	document.getElementById('file'+window.num_attachments).setAttribute('unselectable','on');

	if (window.num_attachments==window.max_attachments)
	{
		var btn=document.getElementById('add_another_button');
		if (btn) btn.disabled=true;
	}

	if (typeof window.trigger_resize!='undefined') trigger_resize();
}

function attachment_present(post_value,number)
{
	return !(post_value.indexOf('[attachment]new_'+number+'[/attachment]')==-1) && (post_value.indexOf('[attachment_safe]new_'+number+'[/attachment_safe]')==-1) && (post_value.indexOf('[attachment thumb="1"]new_'+number+'[/attachment]')==-1) && (post_value.indexOf('[attachment_safe thumb="1"]new_'+number+'[/attachment_safe]')==-1) && (post_value.indexOf('[attachment thumb="0"]new_'+number+'[/attachment]')==-1) && (post_value.indexOf('[attachment_safe thumb="0"]new_'+number+'[/attachment_safe]')==-1);
}

function set_attachment(field_name,number,filename)
{
	if (typeof window.is_comcode_xml=='undefined') return;
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.num_attachments=='undefined') return;
	if (typeof window.max_attachments=='undefined') return;

	var post=document.getElementById(field_name);
	post=ensure_true_id(post,field_name);

	var tmp_form=post.form;
	if ((tmp_form) && (tmp_form.preview))
	{
		tmp_form.preview.checked=false;
		tmp_form.preview.disabled=true;
	}

	var post_value=get_textbox(post);
	var done=attachment_present(post.value,number) || attachment_present(post_value,number) || (tmp_form.getAttribute('itemtype')=='http://schema.org/ContactPage');
	if (!done)
	{
		var filepath=filename;
		if ((!filename) && (document.getElementById('file'+number)))
		{
			filepath=document.getElementById('file'+number).value;
		}

		var is_archive=true,is_image=true;
		if (filepath!='')
		{
			var ext=filepath.substr(filepath.length-4,4).toLowerCase();

			is_archive=(ext=='.tar') || (ext=='.zip');
			is_image=(ext=='.png') || (ext=='.jpg') || (ext=='jpeg') || (ext=='.gif');
		} else return; // Upload error

		var wysiwyg=is_wysiwyg_field(document.getElementById(field_name));

		if ((typeof window.event!='undefined') && (window.event)) window.event.returnValue=false;
		var url='{$FIND_SCRIPT;,comcode_helper}';
		url+='?field_name='+field_name;
		url+='&type=step2';
		url+='&tag='+(is_image?'attachment_safe':'attachment');
		url+='&default=new_'+number;
		url+='&default_thumb=1';
		url+='&default_type='+(is_archive?'download':(is_image?'inline':'island'));
		url+='&is_archive='+(is_archive?'1':'0');
		url+='&is_image='+(is_image?'1':'0');
		url+='&caption='+window.encodeURIComponent(filepath); // Default caption to local file path
		if (wysiwyg) url+='&in_wysiwyg=1';
		url+=keep_stub();
		window.setTimeout(function() {
			window.faux_showModalDialog(
				maintain_theme_in_link(url),
				'',
				'width=750,height=530,status=no,resizable=yes,scrollbars=yes,unadorned=yes',
				function(ret)
				{
					if (ret)
					{
						// Add field for next one
						var add_another_field=(number==window.num_attachments) && (window.num_attachments<window.max_attachments); // Needs running late, in case something happened inbetween
						if (add_another_field)
						{
							add_attachment(window.num_attachments+1,field_name);
						}
					} else // Cancelled
					{
						var clear_button=document.getElementById('fsClear_file'+number);
						if (clear_button)
						{
							clear_button.onclick();
						}
					}
				}
			);
		},800 ); // In a timeout to disassociate possible 'enter' keypress which could have led to this function being called [enter on the file selection dialogue] and could propagate through (on Google Chrome anyways, maybe a browser bug)
	} else
	{
		// Add field for next one
		var add_another_field=(number==window.num_attachments) && (window.num_attachments<window.max_attachments);
		if (add_another_field)
			add_attachment(window.num_attachments+1,field_name);
	}
}

// ====================
// COMCODE UI FUNCTIONS
// ====================

function do_input_html(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;

	var post=document.getElementById(field_name);
	post=ensure_true_id(post,field_name);
	insert_textbox_wrapping(post,'semihtml','');
}

function do_input_code(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;

	var post=document.getElementById(field_name);
	post=ensure_true_id(post,field_name);
	insert_textbox_wrapping(post,'codebox','');
}

function do_input_quote(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;

	var post=document.getElementById(field_name);
	post=ensure_true_id(post,field_name);
	window.fauxmodal_prompt(
		'{!ENTER_QUOTE_BY;^}',
		'',
		function(va)
		{
			if (va!==null) insert_textbox_wrapping(post,'[quote=\"'+va+'\"]','[/quote]');
		},
		'{!comcode:INPUT_COMCODE_quote;^}'
	);
}

function do_input_box(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;

	var post=document.getElementById(field_name);
	post=ensure_true_id(post,field_name);
	window.fauxmodal_prompt(
		'{!ENTER_BOX_TITLE;^}',
		'',
		function(va)
		{
			if (va!==null) insert_textbox_wrapping(post,'[box=\"'+va+'\"]','[/box]');
		},
		'{!comcode:INPUT_COMCODE_box;^}'
	);
}

function do_input_menu(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	window.fauxmodal_prompt(
		'{!ENTER_MENU_NAME;^,'+(document.getElementById(field_name).form.menu_items.value)+'}',
		'',
		function(va)
		{
			if (va)
			{
				window.fauxmodal_prompt(
					'{!ENTER_MENU_CAPTION;^}',
					'',
					function(vb)
					{
						if (!vb) vb='';

						var add;
						var element=document.getElementById(field_name);
						element=ensure_true_id(element,field_name);
						if (is_comcode_xml(element))
						{
							add='<block><blockParam key=\"type\" val=\"tree\" /><blockParam key=\"caption\" val=\""+escape_html(vb)+"\" /><blockParam key=\"param\" val=\""+escape_html(va)+"\" />side_stored_menu</block>';
						} else
						{
							add='[block=\""+escape_comcode(va)+"\" caption=\""+escape_comcode(vb)+"\" type=\"tree\"]side_stored_menu[/block]';
						}
						insert_textbox(element,add);
					},
					'{!comcode:INPUT_COMCODE_menu;^}'
				);
			}
		},
		'{!comcode:INPUT_COMCODE_menu;^}'
	);
}

function do_input_block(field_name)
{
	if ((typeof window.event!='undefined') && (window.event)) window.event.returnValue=false;
	var url='{$FIND_SCRIPT;,block_helper}?field_name='+field_name+keep_stub();
	url=url+'&block_type='+(((field_name.indexOf('edit_panel_')==-1) && (window.location.href.indexOf(':panel_')==-1))?'main':'side');
	window.faux_open(maintain_theme_in_link(url),'','width=750,height=520,status=no,resizable=yes,scrollbars=yes',null,'{!INPUTSYSTEM_CANCEL;}');
}

function do_input_comcode(field_name,tag)
{
	if ((typeof window.event!='undefined') && (window.event)) window.event.returnValue=false;
	var url='{$FIND_SCRIPT;,comcode_helper}?field_name='+field_name;
	if (tag) url+='&type=step2&tag='+tag;
	if (is_wysiwyg_field(document.getElementById(field_name))) url+='&in_wysiwyg=1';
	url+=keep_stub();
	window.faux_open(maintain_theme_in_link(url),'','width=750,height=520,status=no,resizable=yes,scrollbars=yes',null,'{!INPUTSYSTEM_CANCEL;}');
}

function do_input_list(field_name,add)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	if (typeof add=='undefined') var add=[];

	var post=document.getElementById(field_name);
	post=ensure_true_id(post,field_name);
	insert_textbox(post,'\n');
	window.fauxmodal_prompt(
		'{!ENTER_LIST_ENTRY;^}',
		'',
		function(va)
		{
			if ((va!=null) && (va!=''))
			{
				add.push(va);
				return do_input_list(field_name,add)
			}
			if (add.length==0) return;
			var i;
			if (is_comcode_xml(post))
			{
				insert_textbox(post,'<list>\n')
				for (i=0;i<add.length;i++)
				{
					insert_textbox(post,'<list_element>'+add[i]+'</list_element>\n')
				}
				insert_textbox(post,'</list>\n')
			} else
			{
				if (post.value.indexOf('[semihtml')!=-1)
					insert_textbox(post,'[list]\n')
				for (i=0;i<add.length;i++)
				{
					if (post.value.indexOf('[semihtml')!=-1)
					{
						insert_textbox(post,'[*]'+add[i]+'\n')
					} else
					{
						insert_textbox(post,' - '+add[i]+'\n')
					}
				}
				if (post.value.indexOf('[semihtml')!=-1)
					insert_textbox(post,'[/list]\n')
			}
		},
		'{!comcode:INPUT_COMCODE_list;^}'
	);
}

function do_input_hide(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	window.fauxmodal_prompt(
		'{!ENTER_WARNING;^}',
		'',
		function(va)
		{
			if (va)
			{
				window.fauxmodal_prompt(
					'{!ENTER_HIDDEN_TEXT;^}',
					'',
					function(vb)
					{
						var element=document.getElementById(field_name);
						element=ensure_true_id(element,field_name);
						if (vb)
						{
							if (is_comcode_xml(element))
							{
								insert_textbox(element,'<hide><hideTitle>'+va+'</hideTitle>'+escape_html(vb)+'</hide>');
							} else
							{
								insert_textbox(element,'[hide=\"'+escape_comcode(va)+'\"]'+escape_comcode(vb)+'[/hide]');
							}
						}
					},
					'{!comcode:INPUT_COMCODE_hide;^}'
				);
			}
		},
		'{!comcode:INPUT_COMCODE_hide;^}'
	);
}

function do_input_thumb(field_name,va)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	window.fauxmodal_prompt(
		'{!ENTER_URL;^}',
		va,
		function(va)
		{
			if ((va!=null) && (va.indexOf('://')==-1))
			{
				window.fauxmodal_alert('{!NOT_A_URL;^}',function() {
					do_input_url(field_name,va);
				});
				return;
			}

			if (va)
			{
				generate_question_ui(
					'{!THUMB_OR_IMG_2;^}',
					{thumbnail: '{!THUMBNAIL;^}',fullsize: '{!IMAGE;^}'},
					'{!comcode:INPUT_COMCODE_img;^}',
					null,
					function(vb)
					{
						window.fauxmodal_prompt(
							'{!ENTER_IMAGE_CAPTION;^}',
							'',
							function(vc)
							{
								if (!vc) vc='';

								var element=document.getElementById(field_name);
								element=ensure_true_id(element,field_name);
								if (vb.toLowerCase()=='{!IMAGE;^}'.toLowerCase())
								{
									if (is_comcode_xml(element))
									{
										insert_textbox(element,'<img url=\"'+escape_html(va)+'\" />'+escape_html(vc)+'</img>');
									} else
									{
										insert_textbox(element,'[img=\"'+escape_comcode(vc)+'\"]'+escape_comcode(va)+'[/img]');
									}
								} else
								{
									if (is_comcode_xml(element))
									{
										insert_textbox(element,'<thumb caption=\"'+escape_html(vc)+'\">'+escape_html(va)+'</thumb>');
									} else
									{
										insert_textbox(element,'[thumb caption=\"'+escape_comcode(vc)+'\"]'+escape_comcode(va)+'[/thumb]');
									}
								}
							},
							'{!comcode:INPUT_COMCODE_img;^}'
						);
					}
				);
			}
		},
		'{!comcode:INPUT_COMCODE_img;^}'
	);
}

function do_input_attachment(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	window.fauxmodal_prompt(
		'{!ENTER_ATTACHMENT;^}',
		'',
		function(va)
		{
			if (!is_integer(va))
			{
				window.fauxmodal_alert('{!NOT_VALID_ATTACHMENT;^}');
			} else
			{
				var element=document.getElementById(field_name);
				element=ensure_true_id(element,field_name);
				if (is_comcode_xml(element))
				{
					insert_textbox(element,'<attachment>new_'+va+'</attachment>');
				} else
				{
					insert_textbox(element,'[attachment]new_'+va+'[/attachment]');
				}
			}
		},
		'{!comcode:INPUT_COMCODE_attachment;^}'
	);
}

function do_input_url(field_name,va)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	window.fauxmodal_prompt(
		'{!ENTER_URL;^}',
		va,
		function(va)
		{
			if ((va!=null) && (va.indexOf('://')==-1))
			{
				window.fauxmodal_alert('{!NOT_A_URL;^}',function() {
					do_input_url(field_name,va);
				});
				return;
			}

			if (va!==null)
			{
				window.fauxmodal_prompt(
					'{!ENTER_LINK_NAME;^}',
					'',
					function(vb)
					{
						var element=document.getElementById(field_name);
						element=ensure_true_id(element,field_name);
						if (is_comcode_xml(element))
						{
							if (vb!=null) insert_textbox(element,'<url param=\"'+escape_html(va)+'\">'+escape_html(vb)+'</url>');
						} else
						{
							if (vb!=null) insert_textbox(element,'[url=\"'+escape_comcode(vb)+'\"]'+escape_comcode(va)+'[/url]');
						}
					},
					'{!comcode:INPUT_COMCODE_url;^}'
				);
			}
		},
		'{!comcode:INPUT_COMCODE_url;^}'
	);
}

function do_input_page(field_name)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	var result;

	if (typeof window.showModalDialog!='undefined'{+START,IF,{$CONFIG_OPTION,js_overlays}} || true{+END})
	{
		window.faux_showModalDialog(
			maintain_theme_in_link('{$FIND_SCRIPT;,page_link_chooser}'+keep_stub(true)),
			null,
			'dialogWidth=600;dialogHeight=400;status=no;unadorned=yes',
			function(result)
			{
				if ((typeof result=='undefined') || (result===null)) return;

				window.fauxmodal_prompt(
					'{!ENTER_CAPTION;^}',
					'',
					function(vc)
					{
						_do_input_page(field_name,result,vc);
					},
					'{!comcode:INPUT_COMCODE_page;^}'
				);
			}
		);
	} else
	{
		window.fauxmodal_prompt(
			'{!ENTER_ZONE;^}',
			'',
			function(va)
			{
				if (va!==null)
				{
					window.fauxmodal_prompt(
						'{!ENTER_PAGE;^}',
						'',
						function(vb)
						{
							if (vb!==null)
							{
								result=va+':'+vb;

								window.fauxmodal_prompt(
									'{!ENTER_CAPTION;^}',
									'',
									function(vc)
									{
										_do_input_page(field_name,result,vc);
									},
									'{!comcode:INPUT_COMCODE_page;^}'
								);
							}
						}
					);
				}
			},
			'{!comcode:INPUT_COMCODE_page;^}'
		);
	}
}

function _do_input_page(field_name,result,vc)
{
	var element=document.getElementById(field_name);
	element=ensure_true_id(element,field_name);
	if (is_comcode_xml(element))
	{
		insert_textbox(element,'<page pageLink=\"'+escape_html(result)+'\">'+escape_html(vc)+'</page>');
	} else
	{
		insert_textbox(element,'[page=\"'+escape_comcode(result)+'\"]'+escape_comcode(vc)+'[/page]');
	}
}

function do_input_email(field_name,va)
{
	if (typeof window.insert_textbox=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	window.fauxmodal_prompt(
		'{!ENTER_ADDRESS;^}',
		va,
		function(va)
		{
			if ((va!=null) && (va.indexOf('@')==-1))
			{
				window.fauxmodal_alert('{!NOT_A_EMAIL;^}',function() {
					do_input_url(field_name,va);
				});
				return;
			}

			if (va!==null)
			{
				window.fauxmodal_prompt(
					'{!ENTER_CAPTION;^}',
					'',
					function(vb)
					{
						var element=document.getElementById(field_name);
						element=ensure_true_id(element,field_name);
						if (is_comcode_xml(element))
						{
							if (vb!==null) insert_textbox(element,'<email address=\"'+escape_html(va)+'\">'+escape_html(vb)+'</email>');
						} else
						{
							if (vb!==null) insert_textbox(element,'[email=\"'+escape_comcode(vb)+'\"]'+escape_comcode(va)+'[/email]');
						}
					},
					'{!comcode:INPUT_COMCODE_email;^}'
				);
			}
		},
		'{!comcode:INPUT_COMCODE_email;^}'
	);
}

function do_input_b(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;

	var element=document.getElementById(field_name);
	element=ensure_true_id(element,field_name);
	insert_textbox_wrapping(element,'b','');
}

function do_input_i(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;

	var element=document.getElementById(field_name);
	element=ensure_true_id(element,field_name);
	insert_textbox_wrapping(element,'i','');
}

function do_input_font(field_name)
{
	if (typeof window.insert_textbox_wrapping=='undefined') return;
	if (typeof window.is_comcode_xml=='undefined') return;

	var element=document.getElementById(field_name);
	element=ensure_true_id(element,field_name);
	var form=element.form;
	var face=form.elements['f_face'];
	var size=form.elements['f_size'];
	var colour=form.elements['f_colour'];
	if ((face.value=='') && (size.value=='') && (colour.value==''))
	{
		window.fauxmodal_alert('{!NO_FONT_SELECTED;^}');
		return;
	}
	if (is_comcode_xml(element))
	{
		insert_textbox_wrapping(document.getElementById(field_name),'<font param=\"'+escape_html(face.value)+'\" color=\"'+escape_html(colour.value)+'\" size=\"'+escape_html(size.value)+'\">','</font>');
	} else
	{
		insert_textbox_wrapping(document.getElementById(field_name),'[font=\"'+escape_comcode(face.value)+'\" color=\"'+escape_comcode(colour.value)+'\" size=\"'+escape_comcode(size.value)+'\"]','[/font]');
	}
}

function set_font_sizes(list)
{
	var i=0;
	for (i=1;i<list.options.length;i++)
	{
		list.options[i].style.fontSize=list.options[i].value+'em';
	}
}

function deset_font_sizes(list)
{
	var i=0;
	for (i=1;i<list.options.length;i++)
	{
		list.options[i].style.fontSize='';
	}
}

// =====
// OTHER
// =====

function init_form_saving(form_id)
{
	var posting_form=document.getElementById(form_id);
	var i,name,fields_to_do=[],cookie_name,fields_to_do_counter=0,biggest_length_data='',cookie_value,result,type;
	for (i=0;i<posting_form.elements.length;i++)
	{
		name=posting_form.elements[i].name;
		type=posting_form.elements[i].getAttribute('type');
		if ((name!='') && ((posting_form.elements[i].nodeName.toLowerCase()=='textarea') || (type=='text') || (type=='color') || (type=='email') || (type=='number') || (type=='range') || (type=='search') || (type=='tel') || (type=='url')))
		{
			cookie_name='ocp_autosave_'+window.location.pathname+window.location.search.replace(/[\?&]redirect=.*/,'')+':'+name;
			cookie_name=cookie_name.replace(/[\.=,; \t\r\n\013\014\/?]/g,'');
			cookie_value=read_cookie(encodeURIComponent(cookie_name));

			if ((cookie_value!='') && (cookie_value!='0'))
			{
				result=do_ajax_request('{$FIND_SCRIPT;,autosave}?type=retrieve'+keep_stub(),false,'key='+window.encodeURIComponent(cookie_name));
				if ((result) && (result.responseText) && (posting_form.elements[i].value.length<result.responseText.length))
				{
					fields_to_do[name]=result.responseText;
					fields_to_do_counter++;
					if (result.responseText.length>biggest_length_data.length)
					{
						biggest_length_data=result.responseText.replace(/\u0000/g,''); // https://code.google.com/p/chromium/issues/detail?id=274983
					}
				}
			}
			window.last_autosave=new Date();
			add_event_listener_abstract(posting_form.elements[i],'keypress',handle_form_saving);
			posting_form.elements[i].externalonKeyPress=handle_form_saving;
		}
	}
	if ((fields_to_do_counter!=0) && (biggest_length_data!=''))
	{
		var key;
		if (biggest_length_data.length>100) biggest_length_data=biggest_length_data.substr(0,100)+'...';
		window.fauxmodal_confirm(
			'{!RESTORE_SAVED_FORM_DATA;^}\n\n'+biggest_length_data.replace(/<[^>]*>/g,''),
			function(result)
			{
				if (result)
				{
					for (key in fields_to_do)
					{
						if (typeof fields_to_do[key]!='string') continue;

						if ((posting_form.elements[key]) && (posting_form.elements[key].style))
						{
							set_textbox(posting_form.elements[key],fields_to_do[key],fields_to_do[key]);
						}
					}
				} else
				{
					for (key in fields_to_do)
					{
						if (typeof fields_to_do[key]!='string') continue;

						cookie_name='ocp_autosave_'+window.location.pathname+window.location.search.replace(/[\?&]redirect=.*/,'')+':'+key;
						cookie_name=cookie_name.replace(/[\.=,; \t\r\n\013\014\/?]/g,'');
						set_cookie(encodeURIComponent(cookie_name),'0',0.1);
					}
				}
			}
		);
	}
}

function handle_form_saving(event,target,force)
{
	var this_date=new Date();
	if (!force)
	{
		if ((this_date.getTime()-window.last_autosave.getTime())<20000) return; // Only save every 20 seconds
	}

	if (typeof event=='undefined') var event=window.event;
	if (!target)
	{
		target=(event.target)?event.target:event.srcElement;
	}

	var cookie_name='ocp_autosave_'+window.location.pathname+window.location.search.replace(/[\?&]redirect=.*/,'')+':'+target.name;
	cookie_name=cookie_name.replace(/[\.=,; \t\r\n\013\014\/?]/g,'');
	var value=get_textbox(target)+String.fromCharCode(event.keyCode?event.keyCode:event.charCode);
	set_cookie(encodeURIComponent(cookie_name),'1',1);
	require_javascript('javascript_ajax');
	do_ajax_request('{$FIND_SCRIPT_NOHTTP;,autosave}?type=store'+keep_stub(),function() { },'key='+window.encodeURIComponent(cookie_name)+'&value='+window.encodeURIComponent(value));

	window.last_autosave=this_date;
}

