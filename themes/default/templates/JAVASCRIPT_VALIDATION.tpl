/* Validation code and other general code relating to forms */

"use strict";

new Image().src='{$IMG;,loading}'.replace(/^http:/,window.location.protocol);

function password_strength(ob)
{
	if (ob.name.indexOf('2')!=-1) return;
	if (ob.name.indexOf('confirm')!=-1) return;

	var _ind=document.getElementById('password_strength_'+ob.id);
	if (!_ind) return;
	var ind=_ind.getElementsByTagName('div')[0];
	var strength=load_snippet('password_strength','password='+window.encodeURIComponent(ob.value));
	strength*=2; if (strength>10) strength=10; // Normally too harsh!
	ind.style.width=(strength*10)+'px';
	if (strength>=6)
		ind.style.backgroundColor='green';
	else if (strength<4)
		ind.style.backgroundColor='red';
	else
		ind.style.backgroundColor='orange';
	ind.parentNode.style.display=(ob.value.length==0)?'none':'block';
}

function fix_form_enter_key(form)
{
	var submit=document.getElementById('submit_button');
	var inputs=form.getElementsByTagName('input');
	var type;
	for (var i=0;i<inputs.length;i++)
	{
		type=inputs[i].type;
		if (((type=='text') || (type=='password') || (type=='color') || (type=='email') || (type=='number') || (type=='range') || (type=='search') || (type=='tel') || (type=='url'))
		 && (typeof submit.onclick!='undefined') && (submit.onclick)
		 && ((typeof inputs[i].onkeypress=='undefined') || (!inputs[i].onkeypress)))
			inputs[i].onkeypress=function(event) { if (typeof event=='undefined') var event=window.event; if (enter_pressed(event)) submit.onclick(event); };
	}
}

function radio_value(radios)
{
	for (var i=0;i<radios.length;i++)
	{
		if (radios[i].checked) return radios[i].value;
	}
	return '';
}

function set_field_error(the_element,error_msg)
{
	var error_element=null;
	if (typeof the_element.name!='undefined')
	{
		var id=the_element.name;
		error_element=document.getElementById('error_'+id);
		if (!error_element)
		{
			if ((error_msg=='') && (id.indexOf('_hour')!=-1) || (id.indexOf('_minute')!=-1)) return; // Do not blank out as day/month/year (which comes first) would have already done it
			error_element=document.getElementById('error_'+id.replace(/\_day$/,'').replace(/\_month$/,'').replace(/\_year$/,'').replace(/\_hour$/,'').replace(/\_minute$/,''));
		}
		if (error_element)
		{
			// Make error message visible, if there's an error
			error_element.style.display=(error_msg=='')?'none':'block';

			// Changed error message
			if (get_inner_html(error_element)!=escape_html(error_msg))
			{
				set_inner_html(error_element,'');
				if (error_msg!='') // If there actually an error
				{
					the_element.setAttribute('aria-invalid','true');

					// Need to switch tab?
					var p=error_element;
					while (p!==null)
					{
						p=p.parentNode;
						if ((error_msg.substr(0,5)!='{!DISABLED_FORM_FIELD;}'.substr(0,5)) && (p) && (typeof p.getAttribute!='undefined') && (p.getAttribute('id')) && (p.getAttribute('id').substr(0,2)=='g_') && (p.style.display=='none'))
						{
							select_tab('g',p.getAttribute('id').substr(2,p.id.length-2));
							break;
						}
					}

					// Set error message
					var msg_node=document.createTextNode(error_msg);
					error_element.appendChild(msg_node);
					error_element.setAttribute('role','alert');

					// Fade in
					if (typeof window.fade_transition!='undefined')
					{
						set_opacity(error_element,0.0);
						fade_transition(error_element,100,30,4);
					}
				} else
				{
					the_element.setAttribute('aria-invalid','false');
					error_element.setAttribute('role','');
				}
			}
		}
	}
	if ((typeof window.is_wysiwyg_field!='undefined') && (is_wysiwyg_field(the_element))) the_element=the_element.parentNode;
	if (error_msg!='')
	{
		the_element.className=the_element.className+' input_erroneous';
	} else
	{
		the_element.className=the_element.className.replace(/( input_erroneous($| ))+/g,' ');
	}
}

function try_to_simplify_iframe_form()
{
	var form_cat_selector=document.getElementById('main_form'),i,element,count=0,found,foundButton;
	if (!form_cat_selector) return;
	var inputs=form_cat_selector.getElementsByTagName('input');
	var buttons=form_cat_selector.getElementsByTagName('button');
	var selects=form_cat_selector.getElementsByTagName('select');
	var textareas=form_cat_selector.getElementsByTagName('select');
	var elements=[];
	for (i=0;i<inputs.length;i++) elements.push(inputs[i]);
	for (i=0;i<buttons.length;i++) elements.push(buttons[i]);
	for (i=0;i<selects.length;i++) elements.push(selects[i]);
	for (i=0;i<textareas.length;i++) elements.push(textareas[i]);
	for (i=0;i<elements.length;i++)
	{
		element=elements[i];
		if (((element.nodeName.toLowerCase()=='input') && (element.getAttribute('type')!='hidden') && (element.getAttribute('type')!='button') && (element.getAttribute('type')!='image') && (element.getAttribute('type')!='submit')) || (element.nodeName.toLowerCase()=='select') || (element.nodeName.toLowerCase()=='textarea'))
		{
			found=element;
			count++;
		}
		if (((element.nodeName.toLowerCase()=='input') && ((element.getAttribute('type')=='button') || (element.getAttribute('type')=='image') || (element.getAttribute('type')=='submit'))) || (element.nodeName.toLowerCase()=='button'))
		{
			foundButton=element;
		}
	}

	if ((count==1) && (found.nodeName.toLowerCase()=='select'))
	{
		var iframe=document.getElementById('iframe_under');
		found.onchange=function() {
			if (iframe)
			{
				if ((iframe.contentDocument) && (iframe.contentDocument.getElementsByTagName('form').length!=0))
				{
					window.fauxmodal_confirm(
						'{!Q_SURE_LOSE;^}',
						function(result)
						{
							if (result)
							{
								_simplified_form_continue_submit(iframe,form_cat_selector);
							}
						}
					);

					return null;
				}
			}

			_simplified_form_continue_submit(iframe,form_cat_selector);

			return null;
		}
		if ((found.getAttribute('size')>1) || (found.multiple)) found.onclick=found.onchange;
		if (iframe)
		{
			foundButton.style.display='none';
		}
	}
}

function _simplified_form_continue_submit(iframe,form_cat_selector)
{
	if (check_form(form_cat_selector))
	{
		if (iframe) animate_frame_load(iframe,'iframe_under');
		form_cat_selector.submit();
	}
}

function do_form_submit(form,event)
{
	if (!check_form(form,false)) return false;

	if ((typeof form.old_action!='undefined') && (form.old_action)) form.setAttribute('action',form.old_action);
	if ((typeof form.old_target!='undefined') && (form.old_target)) form.setAttribute('target',form.old_target);
	if (!form.getAttribute('target')) form.setAttribute('target','_top');

	/* Remove any stuff that is only in the form for previews if doing a GET request */
	if (form.method.toLowerCase()=='get')
	{
		var i=0,name,elements=[];
		for (i=0;i<form.elements.length;i++)
		{
			elements.push(form.elements[i]);
		}
		for (i=0;i<elements.length;i++)
		{
			name=elements[i].name;
			if (name && ((name.substr(0,11)=='label_for__') || (name.substr(0,14)=='tick_on_form__') || (name.substr(0,9)=='comcode__') || (name.substr(0,9)=='require__')))
			{
				elements[i].parentNode.removeChild(elements[i]);
			}
		}
	}
	if (form.onsubmit)
	{
		var ret=form.onsubmit.call(form,event);
		if (!ret) return false;
	}
	if ((typeof window.just_checking_requirements=='undefined') || (!window.just_checking_requirements)) form.submit();

	disable_buttons_just_clicked(document.getElementsByTagName('input'));
	disable_buttons_just_clicked(document.getElementsByTagName('button'));

	if (typeof window.detect_interval!='undefined')
	{
		window.clearInterval(window.detect_interval);
		window.detect_interval=null;
	}

	return true;
}

function disable_buttons_just_clicked(inputs)
{
	for (var i=0;i<inputs.length;i++)
	{
		if ((inputs[i].nodeName.toLowerCase()=='button') || (inputs[i].type=='image') || (inputs[i].type=='submit') || (inputs[i].type=='button'))
		{
			if (inputs[i].getAttribute('accesskey')=='u') /* Identifies submit button */
			{
				if ((!inputs[i].disabled) && (!inputs[i].under_timer)) /* We do not want to interfere with other code potentially operating */
				{
					disable_button_just_clicked(inputs[i]);
				}
			}
		}
	}
}

function do_form_preview(form,preview_url,has_separate_preview)
{
	if ((window.check_form) && (!check_form(form,true))) return false;

	preview_url+=((typeof window.mobile_version_for_preview=='undefined')?'':('&keep_mobile='+(window.mobile_version_for_preview?'1':'0')));

	var old_action=form.getAttribute('action');

	if ((has_separate_preview) || (window.has_separate_preview))
	{
		form.setAttribute('action',old_action+((old_action.indexOf('?')==-1)?'?':'&')+'preview=1');
		return true;
	}

	if (!form.old_action) form.old_action=old_action;
	form.setAttribute('action',/*maintain_theme_in_link - no, we want correct theme images to work*/(preview_url)+((form.old_action.indexOf('&uploading=1')!=-1)?'&uploading=1':''));
	var old_target=form.getAttribute('target');
	if (!old_target) old_target='_top'; /* not _self due to edit screen being a frame itself */
	if (!form.old_target) form.old_target=old_target;
	form.setAttribute('target','preview_iframe');
	document.getElementById('submit_button').style.display='inline';
	//window.setInterval(function() { resize_frame('preview_iframe',window.top.scrollY+window.top.get_window_height()); },1500);
	var pf=document.getElementById('preview_iframe');

	/* Do our loading-animation */
	window.setInterval(window.trigger_resize,500);  /* In case its running in an iframe itself */
	animate_frame_load(pf,'preview_iframe',50);

	/* input.value not readable on most modern web browsers, and this code is not maintained
	var inputs=form.elements,input;
	for (var i=0;i<inputs.length-1;i++)
	{
		input=inputs[i];
		if ((input.type=='file') && (!input.name.match(/file\d*$/)) && (input.className.indexOf('previews')==-1) && (!input.disabled) && (input.value!=''))
		{
			input.disabled=true;
			window.setTimeout(function() { document.getElementById(input.id).disabled=false; },500);
		}
	}*/

	return true;
}

function clever_find_value(the_form,the_element)
{
	var my_value=(typeof window.get_textbox=='undefined')?the_element.value:get_textbox(the_element);
	if (the_element.getAttribute('type')=='radio')
	{
		my_value='';
		for (var i=0;i<the_form.elements.length;i++)
		{
			if ((the_form.elements[i].checked) && (the_form.elements[i].name==the_element.name))
				my_value=the_form.elements[i].value;
		}
	}
	if ((the_element.nodeName.toLowerCase()=='select') && (the_element.selectedIndex>=0))
	{
		my_value=the_element.options[the_element.selectedIndex].value;
		if ((my_value=='') && (the_element.getAttribute('size')>1)) my_value='-1'; // Fudge, as we have selected something explicitly that is blank
	}
	if (my_value===null) my_value='';
	return my_value;
}

function check_field(the_element,the_form,for_preview)
{
	var i,the_class,required,my_value,erroneous=false,error_msg='',regexp,total_file_size=0,alerted=false,error_element=null;

	if (((the_element.type=='hidden') || ((the_element.style.display=='none') && ((typeof window.is_wysiwyg_field=='undefined') || (!is_wysiwyg_field(the_element))))) && ((!the_element.className) || (element_has_class(the_element,'hidden_but_needed'))==-1))
	{
		return null;
	}
	if (the_element.disabled) return null;

	// Test file sizes
	if ((the_element.type=='file') && (the_element.files) && (the_element.files.item) && (the_element.files.item(0)) && (the_element.files.item(0).fileSize))
		total_file_size+=the_element.files.item(0).fileSize;

	// Test file types
	if ((the_element.type=='file') && (the_element.value) && (the_element.name!='file_novalidate'))
	{
		var valid_types='{$VALID_FILE_TYPES;}'.split(/,/);
		var type_ok=false;
		var theFileType=the_element.value.indexOf('.')?the_element.value.substr(the_element.value.lastIndexOf('.')+1):'{!NONE;^}';
		for (var k=0;k<valid_types.length;k++)
		{
			if (valid_types[k].toLowerCase()==theFileType.toLowerCase()) type_ok=true;
		}
		if (!type_ok)
		{
			error_msg='{!INVALID_FILE_TYPE;^,xx1xx,{$VALID_FILE_TYPES}}'.replace(/xx1xx/g,theFileType).replace(/<[^>]*>/g,'').replace(/&[lr][sd]quo;/g,'\'').replace(/,/g,', ');
			if (!alerted) window.fauxmodal_alert(error_msg);
			alerted=true;
		}
	}

	// Fix up bad characters
	if ((browser_matches('ie')) && (the_element.value) && (the_element.nodeName.toLowerCase()!='select'))
	{
		var bad_word_chars=[8216,8217,8220,8221];
		var fixed_word_chars=['\'','\'','"','"'];
		for (i=0;i<bad_word_chars.length;i++)
		{
			regexp=new RegExp(String.fromCharCode(bad_word_chars[i]),'gm');
			the_element.value=the_element.value.replace(regexp,fixed_word_chars[i]);
		}
	}

	the_class=first_class_name(the_element.className);

	if ((!for_preview) && (the_element.name=='delete') && (((the_class=='input_radio') && (the_element.value!='0')) || (the_class=='input_tick')) && (the_element.checked))
	{
		return [false,the_element,0,true]; // Because we're deleting, errors do not matter
	}

	// Find whether field is required and value of it
	if (the_element.type=='radio')
	{
		required=(typeof the_form.elements['require__'+the_element.name]!='undefined') && (the_form.elements['require__'+the_element.name].value=='1');
	} else
	{
		required=the_element.className.indexOf('_required')!=-1;
	}
	my_value=clever_find_value(the_form,the_element);

	if ((required) && ((my_value.replace(/&nbsp;/g,' ').replace(/<br\s*\/?>/g,' ').replace(/\s/g,'')=='') || (my_value=='****')))
	{
		error_msg='{!REQUIRED_NOT_FILLED_IN;^}';
	} else
	{
		if ((the_element.className.indexOf('date')!=-1) && (the_element.name.match(/\_(day|month|year)$/)) && (my_value!=''))
		{
			var day=the_form.elements[the_element.name.replace(/\_(day|month|year)$/,'_day')].options[the_form.elements[the_element.name.replace(/\_(day|month|year)$/,'_day')].selectedIndex].value;
			var month=the_form.elements[the_element.name.replace(/\_(day|month|year)$/,'_month')].options[the_form.elements[the_element.name.replace(/\_(day|month|year)$/,'_month')].selectedIndex].value;
			var year=the_form.elements[the_element.name.replace(/\_(day|month|year)$/,'_year')].options[the_form.elements[the_element.name.replace(/\_(day|month|year)$/,'_year')].selectedIndex].value;
			var source_date=new Date(year,month-1,day);
			if (year!=source_date.getFullYear()) error_msg='{!NOT_A_DATE;^}';
			if (month!=source_date.getMonth()+1) error_msg='{!NOT_A_DATE;^}';
			if (day!=source_date.getDate()) error_msg='{!NOT_A_DATE;^}';
		}
		if (((the_class=='input_email') || (the_class=='input_email_required')) && (my_value!='') && (my_value!='****') && (!my_value.match(/^[a-zA-Z0-9\._\-\+]+@[a-zA-Z0-9\._\-]+$/)))
		{
			error_msg='{!NOT_A_EMAIL;^}'.replace('xxx',my_value);
		}
		if (((the_class=='input_username') || (the_class=='input_username_required')) && (my_value!='') && (my_value!='****') && (window.do_ajax_field_test) && (!do_ajax_field_test('{$FIND_SCRIPT_NOHTTP;,username_exists}?username='+encodeURIComponent(my_value))))
		{
			error_msg='{!NOT_USERNAME;^}'.replace('xxx',my_value);
		}
		if (((the_class=='input_codename') || (the_class=='input_codename_required')) && (my_value!='') && (my_value!='****') && (!my_value.match(/^[a-zA-Z0-9\-\.\_]*$/)))
		{
			error_msg='{!NOT_CODENAME;^}'.replace('xxx',my_value);
		}
		if (((the_class=='input_integer') || (the_class=='input_integer_required')) && (my_value!='') && (my_value!='****') && (parseInt(my_value,10)!=my_value-0))
		{
			error_msg='{!NOT_INTEGER;^}'.replace('xxx',my_value);
		}
		if (((the_class=='input_float') || (the_class=='input_float_required')) && (my_value!='') && (my_value!='****') && (parseFloat(my_value)!=my_value-0))
		{
			error_msg='{!NOT_FLOAT;^}'.replace('xxx',my_value);
		}
	}

	set_field_error(the_element,error_msg);
	if ((error_msg!='') && (!erroneous))
	{
		erroneous=true;
		error_element=the_element;
	}

	return [erroneous,error_element,total_file_size,alerted];
}

function check_form(the_form,for_preview)
{
	var j,the_element,erroneous=false,total_file_size=0,alerted=false,error_element=null,check_result;
	for (j=0;j<the_form.elements.length;j++)
	{
		if (!the_form.elements[j]) continue;

		if (the_form.elements[j].nodeName.toLowerCase()=='object') continue; // IE9 being weird!

		the_element=the_form.elements[j];

		check_result=check_field(the_element,the_form,for_preview);
		if (check_result!=null)
		{
			erroneous=check_result[0] || erroneous;
			if (!error_element) error_element=check_result[1];
			total_file_size+=check_result[2];
			alerted=check_result[3] || alerted;

			if (check_result[0])
			{
				var auto_reset_error=function(the_element) { return function(event,no_recurse) {
					var check_result=check_field(the_element,the_form,for_preview);
					if ((check_result!=null) && (!check_result[0]))
					{
						set_field_error(the_element,'');
					}

					if ((!no_recurse) && (the_element.className.indexOf('date')!=-1) && (the_element.name.match(/\_(day|month|year)$/)))
					{
						var e=document.getElementById(the_element.id.replace(/\_(day|month|year)$/,'_day'));
						if (e!=the_element) e.onblur(event,true);
						var e=document.getElementById(the_element.id.replace(/\_(day|month|year)$/,'_month'));
						if (e!=the_element) e.onblur(event,true);
						var e=document.getElementById(the_element.id.replace(/\_(day|month|year)$/,'_year'));
						if (e!=the_element) e.onblur(event,true);
					}
				}; };

				if (the_element.getAttribute('type')=='radio')
				{
					for (var i=0;i<the_form.elements.length;i++)
					{
						the_form.elements[i].onchange=auto_reset_error(the_form.elements[i]);
					}
				} else
				{
					the_element.onblur=auto_reset_error(the_element);
				}
			}
		}
	}

	if ((total_file_size>0) && (the_form.elements['MAX_FILE_SIZE']))
	{
		if (total_file_size>the_form.elements['MAX_FILE_SIZE'].value)
		{
			if (!erroneous)
			{
				error_element=the_element;
				erroneous=true;
			}
			if (!alerted)
			{
				window.fauxmodal_alert('{!TOO_MUCH_FILE_DATA;^}'.replace(new RegExp('\\\\{'+'1'+'\\\\}','g'),Math.round(total_file_size/1024)).replace(new RegExp('\\\\{'+'2'+'\\\\}','g'),Math.round(the_form.elements['MAX_FILE_SIZE'].value/1024)));
			}
			alerted=true;
		}
	}

	if (erroneous)
	{
		if (!alerted) window.fauxmodal_alert('{!IMPROPERLY_FILLED_IN;^}');
		var posy=find_pos_y(error_element,true);
		if (posy==0)
		{
			posy=find_pos_y(error_element.parentNode,true);
		}
		if (posy!=0)
			smooth_scroll(posy-50,null,null,function() { try { error_element.focus(); } catch(e) {}; /* Can have exception giving focus on IE for invisible fields */ } );
	}

	return !erroneous;
}

function standard_alternate_fields_within(set_name,something_required)
{
	var form=document.getElementById('set_wrapper_'+set_name);
	while (form.nodeName.toLowerCase()!='form')
	{
		form=form.parentNode;
	}
	var fields=form.elements[set_name];
	var field_names=[];
	for (var i=0;i<fields.length;i++)
	{
		if (typeof fields[i][0]=='undefined')
		{
			if (fields[i].id.match(/^choose\_/))
				field_names.push(fields[i].id.replace(/^choose\_/,''));
		} else
		{
			if (fields[i][0].id.match(/^choose\_/))
				field_names.push(fields[i][0].id.replace(/^choose\_/,''));
		}
	}
	standard_alternate_fields(field_names,something_required);
}

// Do dynamic set_locked/set_required such that one of these must be set, but only one may be
function standard_alternate_fields(field_names,something_required,second_run)
{
	if (typeof second_run=='undefined') var second_run=false;

	// Look up field objects
	var fields=[];

	for (var i=0;i<field_names.length;i++)
	{
		var field=_standard_alternate_fields_get_object(field_names[i]);
		fields.push(field);
	}

	// Set up listeners...
	for (var i=0;i<field_names.length;i++)
	{
		var field=fields[i];
		if ((field) && (typeof field.alternating=='undefined')) // ... but only if not already set
		{
			var self_function=function (e) { standard_alternate_fields(field_names,something_required,true); } ; // We'll re-call ourself on change
			_standard_alternate_field_create_listeners(field,self_function);
		}
	}

	// Update things
	for (var i=0;i<field_names.length;i++)
	{
		var field=fields[i];
		if ((field) && (_standard_alternate_field_is_filled_in(field,second_run,false)))
			return _standard_alternate_field_update_editability(field,fields,something_required);
	}

	// Hmm, force first one chosen then
	for (var i=0;i<field_names.length;i++)
	{
		var field=fields[i];
		if ((field) && (_standard_alternate_field_is_filled_in(field,second_run,true)))
			return _standard_alternate_field_update_editability(field,fields,something_required);
	}
}

function _standard_alternate_field_is_filled_in(field,second_run,force)
{
	var is_set=force || ((field.value!='') && (field.value!='-1')) || ((typeof field.virtual_value!='undefined') && (field.virtual_value!='') && (field.virtual_value!='-1'));

	var radio_button=document.getElementById('choose_'+field.name.replace(/\[\]$/,'')); // Radio button handles field alternation
	if (!radio_button) radio_button=document.getElementById('choose_'+field.name.replace(/\_\d+$/,'_'));
	if (second_run)
	{
		if (radio_button) return radio_button.checked;
	} else
	{
		if (radio_button) radio_button.checked=is_set;
	}
	return is_set;
}

function _standard_alternate_field_create_listeners(field,refreshFunction)
{
	if (typeof field.nodeName!='undefined')
	{
		__standard_alternate_field_create_listeners(field,refreshFunction);
	} else
	{
		var i;
		for (i=0;i<field.length;i++)
		{
			if (typeof field[i].name!='undefined')
				__standard_alternate_field_create_listeners(field[i],refreshFunction);
		}
		field.alternating=true;
	}
	return null;
}

function __standard_alternate_field_create_listeners(field,refreshFunction)
{
	var radio_button=document.getElementById('choose_'+field.name.replace(/\[\]$/,''));
	if (!radio_button) radio_button=document.getElementById('choose_'+field.name.replace(/\_\d+$/,'_'));
	if (radio_button) // Radio button handles field alternation
	{
		add_event_listener_abstract(radio_button,'change',refreshFunction);
	} else // Filling/blanking out handles field alternation
	{
		add_event_listener_abstract(field,'keyup',refreshFunction);
		add_event_listener_abstract(field,'change',refreshFunction);
		field.fakeonchange=refreshFunction;
	}
	field.alternating=true;
}

function _standard_alternate_fields_get_object(field_name)
{
	var field=document.getElementById(field_name);
	if (field) return field;

	// A radio field, so we need to create a virtual field object to return that will hold our value
	var radio_buttons=[],i,j,e; /*JSLINT: Ignore errors*/
	radio_buttons['name']=field_name;
	radio_buttons['value']='';
	for (i=0;i<document.forms.length;i++)
	{
		for (j=0;j<document.forms[i].elements.length;j++)
		{
			e=document.forms[i].elements[j];
			if (!e.name) continue;

			if ((e.name.replace(/\[\]$/,'')==field_name) || (e.name.replace(/\_\d+$/,'_')==field_name))
			{
				radio_buttons.push(e);
				if (e.checked) // This is the checked radio equivalent to our text field, copy the value through to the text field
				{
					radio_buttons['value']=e.value;
				}
				if (e.alternating) radio_buttons.alternating=true;
			}
		}
	}

	if (radio_buttons.length==0) return null;

	return radio_buttons;
}

function _standard_alternate_field_update_editability(chosen,choices,something_required)
{
	for (var i=0;i<choices.length;i++)
	{
		if (choices[i])
			__standard_alternate_field_update_editability(choices[i],chosen,choices[i]!=chosen,choices[i]==chosen,something_required);
	}
}
// NB: is_chosen may only be null if is_locked is false
function __standard_alternate_field_update_editability(field,chosen_field,is_locked,is_chosen,something_required)
{
	if (typeof field.nodeName!='undefined')
	{
		___standard_alternate_field_update_editability(field,chosen_field,is_locked,is_chosen,something_required);
	} else // Radio list
	{
		for (var i=0;i<field.length;i++)
		{
			if (typeof field[i].name!='undefined') // If it is an object, as opposed to some string in the collection
			{
				___standard_alternate_field_update_editability(field[i],chosen_field,is_locked,is_chosen,something_required);
			}
		}
	}
}
function ___standard_alternate_field_update_editability(field,chosen_field,is_locked,is_chosen,something_required)
{
	var radio_button=document.getElementById('choose_'+field.name.replace(/\[\]$/,''));
	if (!radio_button) radio_button=document.getElementById('choose_'+field.name.replace(/\_\d+$/,'_'));

	set_locked(field,is_locked,chosen_field);
	if (something_required)
	{
		set_required(field.name.replace(/\[\]$/,''),is_chosen);
	}
}

function set_locked(field,is_locked,chosen_ob)
{
	var radio_button=document.getElementById('choose_'+field.name.replace(/\[\]$/,''));
	if (!radio_button) radio_button=document.getElementById('choose_'+field.name.replace(/\_\d+$/,'_'));

	// For All-and-not,Line-multi,Compound-Tick,Radio-List,Date/Time: set_locked assumes that the calling code is clever
	// special input types are coded to observe their master input field readonly status)
	var button=document.getElementById('uploadButton_'+field.name.replace(/\[\]$/,''));

	if (is_locked)
	{
		var labels=document.getElementsByTagName('label'),label=null;
		for (var i=0;i<labels.length;i++)
		{
			if (labels[i].getAttribute('for')==chosen_ob.id)
			{
				label=labels[i];
				break;
			}
		}
		if (!radio_button)
		{
			if (label)
			{
				var label_nice=get_inner_html(label).replace('&raquo;','').replace(/^\s*/,'').replace(/\s*$/,'');
				if (field.type=='file')
				{
					set_field_error(field,'{!DISABLED_FORM_FIELD_ENCHANCEDMSG_UPLOAD;^}'.replace(/\\{1\\}/,label_nice));
				} else
				{
					set_field_error(field,'{!DISABLED_FORM_FIELD_ENCHANCEDMSG;^}'.replace(/\\{1\\}/,label_nice));
				}
			} else
			{
				set_field_error(field,'{!DISABLED_FORM_FIELD;^}');
			}
		}
		field.className=field.className.replace(/( input_erroneous($| ))+/g,' ');
	} else
	{
		if (!radio_button)
		{
			set_field_error(field,'');
		}
	}
	field.disabled=is_locked;
	if (button) button.disabled=is_locked;
}

function set_required(field_name,is_required)
{
	var radio_button=document.getElementById('choose_'+field_name);

	if (radio_button)
	{
		if (is_required) radio_button.checked=true;
	} else
	{
		var required_a=document.getElementById('form_table_field_name__'+field_name);
		var required_b=document.getElementById('required_readable_marker__'+field_name);
		var required_c=document.getElementById('required_posted__'+field_name);
		var required_d=document.getElementById('form_table_field_input__'+field_name);
		if (is_required)
		{
			if (required_a) required_a.className='form_table_field_name required';
			if (required_d) required_d.className='form_table_field_input';
			if (required_b) required_b.style.display='inline';
			if (required_c) required_c.value=1;
		} else
		{
			if (required_a) required_a.className='form_table_field_name';
			if (required_d) required_d.className='form_table_field_input';
			if (required_b) required_b.style.display='none';
			if (required_c) required_c.value=0;
		}
	}

	var element=document.getElementById(field_name);

	if (element)
	{
		element.className=element.className.replace(/(input\_[a-z\_]+)_required/g,'$1');

		if (typeof element.swfob!='undefined')
		{
			element.swfob.settings.required=is_required;
		}

		if (is_required) element.className=element.className.replace(/(input\_[a-z\_]+)/g,'$1_required');
	}

	if (!is_required)
	{
		var error=document.getElementById('error__'+field_name);
		if (error) error.style.display='none';
	}
}

// Hide a 'tray' of trs in a form
function toggle_subordinate_fields(pic,help_id)
{
	var new_state,new_state_2,new_state_3,i;
	var field_input=pic.parentNode.parentNode.parentNode;

	var next=field_input.nextSibling;
	if (!next) return;
	while (element_has_class(next,'field_input')!==null) // Sometimes divs or whatever may have errornously been put in a table by a programmer, skip past them
	{
		next=next.nextSibling;
		if (!next) break;
		if (element_has_class(next,'form_table_field_spacer')) // End of section, so no need to keep going
		{
			next=null;
			break;
		}
	}

	if (((!next) && (pic.src.indexOf('expand')!=-1)) || ((next) && (next.style.display=='none'))) /* Expanding now */
	{
		pic.src=((pic.src.indexOf('themewizard.php')!=-1)?pic.src.replace('expand','contract'):'{$IMG;,contract}').replace(/^http:/,window.location.protocol);
		pic.setAttribute('alt','{!CONTRACT;}');
		pic.setAttribute('title','{!CONTRACT;}');
		new_state=(field_input.nodeName.toLowerCase()=='tr')?'table-row':'block';
		new_state_2='block';
		new_state_3='1px dashed';
	} else /* Contracting now */
	{
		pic.src=((pic.src.indexOf('themewizard.php')!=-1)?pic.src.replace('contract','expand'):'{$IMG;,expand}').replace(/^http:/,window.location.protocol);
		pic.setAttribute('alt','{!EXPAND;}');
		pic.setAttribute('title','{!EXPAND;}');
		new_state='none';
		new_state_2='none';
		new_state_3='0';
	}

	// Hide everything until we hit end of section
	var count=0;
	while (field_input.nextSibling!==null)
	{
		field_input=field_input.nextSibling;
		if (typeof field_input.className=='undefined') continue; // E.g. a #text node

		/* Start of next section? */
		if (element_has_class(field_input,'form_table_field_spacer')) break; // End of section

		/* Ok to proceed */
		field_input.style.display=new_state;

		if ((typeof window.fade_transition!='undefined') && (new_state_2!='none') && (count<50/*Performance*/))
		{
			set_opacity(field_input,0.0);
			fade_transition(field_input,100,30,20);
			count++;
		}
	}
	if (typeof help_id=='undefined') var help_id=pic.parentNode.id+'_help';
	var help=document.getElementById(help_id);
	while (help!==null)
	{
		help.style.display=new_state_2;
		help=help.nextSibling;
		if ((help) && (help.nodeName.toLowerCase()!='p')) break;
	}

	trigger_resize();
}

function choose_picture(id,ob,name,event)
{
	var r=document.getElementById(id);
	if (!r) return;
	var e=r.form.elements[name];
	if (e.length<100)
	{
		for (var i=0;i<e.length;i++)
		{
			if (e[i].disabled) continue;
			var img=e[i].parentNode.parentNode.parentNode.getElementsByTagName('img')[0];
			if ((img) && (img!=ob))
			{
				img.parentNode.className=img.parentNode.className.replace(' selected','');
				img.style.outline='0';
				if (!browser_matches('ie8+')) img.style.background='none';
			}
		}
	}

	if (r.disabled) return;
	r.checked=true;
	//if (r.onclick) r.onclick(); causes loop
	if (typeof r.fakeonchange!='undefined' && r.fakeonchange) r.fakeonchange(event);
	if (e.length<100)
	{
		ob.parentNode.className+=' selected';
		if (!browser_matches('opera')) ob.style.outline='1px dotted';
	}
}

function disable_preview_scripts(under)
{
	if (typeof under=='undefined') var under=document;

	var elements,i;
	var no_go=function() {
		window.fauxmodal_alert('{!NOT_IN_PREVIEW_MODE;^}');
		return false;
	};
	elements=under.getElementsByTagName('button');
	for (i=0;i<elements.length;i++)
		elements[i].onclick=no_go;
	elements=under.getElementsByTagName('input');
	for (i=0;i<elements.length;i++)
		if ((elements[i].getAttribute('type')=='button') || (elements[i].getAttribute('type')=='image')) elements[i].onclick=no_go;
	elements=under.getElementsByTagName('a');
	for (i=0;i<elements.length;i++)
		elements[i].target='false_blank'; // Real _blank would trigger annoying CSS. This is better anyway.
}

function _set_up_change_monitor(container,input,container2)
{
	var elements=[];
	if (input)
	{
		elements=[document.getElementById(input)];
	} else
	{
		elements=get_all_form_elements(container);
	}
	if (elements.length>300) return;
	for (var i=0;i<elements.length;i++)
	{
		if (!elements[i]) continue;
		if ((typeof elements[0]!='undefined') || (elements[0].id.indexOf('choose_')!=-1)) continue;
		var func=function () {
			if (find_if_children_set(input?document.getElementById(input).parentNode:container))
			{
				if (container.className.indexOf(' filledin')==-1) container.className+=' filledin';
				if (container2) if (container2.className.indexOf(' filledin')==-1) container2.className+=' filledin';
			} else
			{
				container.className=container.className.replace(/ filledin$/,'');
				if (container2) container2.className=container2.className.replace(/ filledin$/,'');
			}
		};
		add_event_listener_abstract(elements[i],'blur',func );
		add_event_listener_abstract(elements[i],'change',func );
	}
}

function find_if_children_set(container)
{
	var value,blank=true,the_element;
	var elements=get_all_form_elements(container);
	for (var i=0;i<elements.length;i++)
	{
		if (!elements[i]) continue;
		the_element=elements[i];
		if (((the_element.type=='hidden') || ((the_element.style.display=='none') && ((typeof window.is_wysiwyg_field=='undefined') || (!is_wysiwyg_field(the_element))))) && ((!the_element.className) || (!element_has_class(the_element,'hidden_but_needed')))) continue;
		value=clever_find_value(the_element.form,the_element);
		blank=blank && (value=='');
	}
	return !blank;
}

function get_all_form_elements(container)
{
	var i;
	var elements1=container.getElementsByTagName('input');
	var elements2=container.getElementsByTagName('select');
	var elements3=container.getElementsByTagName('textarea');
	var elements=[];
	for (i=0;i<elements1.length;i++) elements.push(elements1[i]);
	for (i=0;i<elements2.length;i++) elements.push(elements2[i]);
	for (i=0;i<elements3.length;i++) elements.push(elements3[i]);
	return elements;
}

function assign_tick_deletion_confirm(name)
{
	document.getElementById(name).onchange=function()
	{
		if (this.checked)
		{
			window.fauxmodal_confirm(
				'{!ARE_YOU_SURE_DELETE;^}',
				function(result)
				{
					if (!result) document.getElementById(name).checked=false;
				}
			);
		}
	}
}

function assign_radio_deletion_confirm(name)
{
	for (var i=1;i<3;i++)
	{
		var e=document.getElementById('j_'+name+'_'+i);
		if (e)
		{
			e.onchange=function()
			{
				if (this.checked)
				{
					window.fauxmodal_confirm(
						'{!ARE_YOU_SURE_DELETE;^}',
						function(result)
						{
							if (!result)
							{
								var e=document.getElementById('j_'+name+'_0');
								if (e) e.checked=true;
							}
						}
					);
				}
			}
		}
	}
}
