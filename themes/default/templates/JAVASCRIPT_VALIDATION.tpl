/* Validation code and other general code relating to forms */

"use strict";

new Image().src='{$IMG,bottom/loading}'.replace(/^http:/,window.location.protocol);

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
			inputs[i].onkeypress=function(event) { if (!event) event=window.event; if (enter_pressed(event)) submit.onclick(); };
	}
}

function radioValue(radios)
{
	for (var i=0;i<radios.length;i++)
	{
		if (radios[i].checked) return radios[i].value;
	}
	return '';
}

function confirmDelete()
{
	return window.confirm("{!ARE_YOU_SURE_DELETE^#}");
}

function setFieldError(theElement,errorMsg)
{
	var errorElement=null;
	if (typeof theElement.name!='undefined')
	{
		var id=theElement.name;
		errorElement=document.getElementById('error_'+id);
		if (!errorElement)
		{
			if ((errorMsg=='') && (id.indexOf('_hour')!=-1) || (id.indexOf('_minute')!=-1)) return; // Do not blank out as day/month/year (which comes first) would have already done it
			errorElement=document.getElementById('error_'+id.replace(/\_day$/,'').replace(/\_month$/,'').replace(/\_year$/,'').replace(/\_hour$/,'').replace(/\_minute$/,''));
		}
		if (errorElement)
		{
			errorElement.style.display=(errorMsg=='')?'none':'block';
			if (getInnerHTML(errorElement)!=escape_html(errorMsg))
			{
				setInnerHTML(errorElement,'');
				if (errorMsg!='')
				{
					var msgNode=document.createTextNode(errorMsg);
					errorElement.appendChild(msgNode);

					if (typeof window.nereidFade!='undefined')
					{
						setOpacity(errorElement,0.0);
						nereidFade(errorElement,100,30,4);
					}
				}
			}
		}
	}
	if ((typeof window.isWYSIWYGField!='undefined') && (isWYSIWYGField(theElement))) theElement=theElement.parentNode;
	if (errorMsg!='')
	{
		theElement.className=theElement.className+' input_erroneous';
	} else
	{
		theElement.className=theElement.className.replace(/( input_erroneous($| ))+/g,' ');
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
					if (!window.confirm('{!Q_SURE_LOSE^;}')) return false;
				}
			}
			
			if (checkForm(form_cat_selector))
			{
				if (iframe) animateFrameLoad(iframe,'iframe_under');
				form_cat_selector.submit();
			}
			
			return true;
		}
		if ((found.getAttribute('size')>1) || (found.multiple)) found.onclick=found.onchange;
		if (iframe)
		{
			foundButton.style.display='none';
		}
	}
}

function do_form_submit(form)
{
	if (!checkForm(form,false)) return false;

	if ((typeof form.old_action!='undefined') && (form.old_action)) form.setAttribute('action',form.old_action);
	if ((typeof form.old_target!='undefined') && (form.old_target)) form.setAttribute('target',form.old_target);
	if (!form.getAttribute('target')) form.setAttribute('target','_top');

	{$,Remove any stuff that is only in the form for previews if doing a GET request}
	if (form.getAttribute('method').toLowerCase()=='get')
	{
   	var i=0,name,elements=[];
   	for (i=0;i<form.elements.length;i++)
   	{
   		elements.push(form.elements[i]);
   	}
   	for (i=0;i<elements.length;i++)
   	{
   		name=elements[i].name;
   		if ((name.substr(0,11)=='label_for__') || (name.substr(0,14)=='tick_on_form__') || (name.substr(0,9)=='comcode__') || (name.substr(0,9)=='require__'))
   		{
   			elements[i].parentNode.removeChild(elements[i]);
   		}
   	}
	}
	if (form.onsubmit)
	{
		var ret=form.onsubmit();
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
	if ((window.checkForm) && (!checkForm(form,true))) return false;

	var old_action=form.getAttribute('action');

	if ((has_separate_preview) || (window.has_separate_preview))
	{
		form.setAttribute('action',old_action+'&preview=1');
		return true;
	}

	if (!form.old_action) form.old_action=old_action;
	form.setAttribute('action',/*maintain_theme_in_link - no, we want correct theme images to work*/(preview_url)+((form.old_action.indexOf('&uploading=1')!=-1)?'&uploading=1':''));
	var old_target=form.getAttribute('target');
	if (!old_target) old_target='_top'; {$,not _self due to edit screen being a frame itself}
	if (!form.old_target) form.old_target=old_target;
	form.setAttribute('target','preview_iframe');
	document.getElementById('submit_button').style.display='inline';
	//window.setInterval('resizeFrame(\'preview_iframe\','+(window.top.scrollY+window.top.getWindowHeight())+')',1500);
	var pf=document.getElementById('preview_iframe');

	{$,Do our loading-animation}
	window.setInterval(trigger_resize,500);  {$,In case its running in an iframe itself}
	animateFrameLoad(pf,'preview_iframe',50);

	/* input.value not readable on most modern web browsers, and this code is not maintained
	var inputs=form.elements,input;
	for (var i=0;i<inputs.length-1;i++)
	{
		input=inputs[i];
		if ((input.type=='file') && (!input.name.match(/file\d*$/)) && (input.className.indexOf('previews')==-1) && (!input.disabled) && (input.value!=''))
		{
			input.disabled=true;
			window.setTimeout('document.getElementById(\''+input.id+'\').disabled=false;',500);
		}
	}*/

	return true;
}

function cleverFindValue(theForm,theElement)
{
	var myValue=(typeof window.getTextbox=='undefined')?theElement.value:getTextbox(theElement);
	if (theElement.getAttribute('type')=='radio')
	{
		myValue='';
		for (var i=0;i<theForm.elements.length;i++)
		{
			if ((theForm.elements[i].checked) && (theForm.elements[i].name==theElement.name))
				myValue=theForm.elements[i].value;
		}
	}
	if ((theElement.nodeName.toLowerCase()=='select') && (theElement.selectedIndex>=0))
	{
		myValue=theElement.options[theElement.selectedIndex].value;
		if ((myValue=='') && (theElement.getAttribute('size')>1)) myValue='-1'; // Fudge, as we have selected something explicitly that is blank
	}
	if (myValue===null) myValue='';
	return myValue;
}

function checkField(theElement,theForm,forPreview)
{
	var i,theClass,required,myValue,erroneous=false,errorMsg='',regexp,totalFileSize=0,alerted=false,errorElement=null;

	if (((theElement.type=='hidden') || ((theElement.style.display=='none') && ((typeof window.isWYSIWYGField=='undefined') || (!isWYSIWYGField(theElement))))) && ((!theElement.className) || (theElement.className.indexOf('hidden_but_needed')==-1)))
	{
		return null;
	}

	// Test file sizes
	if ((theElement.type=='file') && (theElement.files) && (theElement.files.item) && (theElement.files.item(0)) && (theElement.files.item(0).fileSize))
		totalFileSize+=theElement.files.item(0).fileSize;

	// Test file types
	if ((theElement.type=='file') && (theElement.value) && (theElement.name!='file_novalidate'))
	{
		var valid_types='{$VALID_FILE_TYPES;}'.split(/,/);
		var type_ok=false;
		var theFileType=theElement.value.indexOf('.')?theElement.value.substr(theElement.value.lastIndexOf('.')+1):'{!NONE^;}';
		for (var k=0;k<valid_types.length;k++)
		{
			if (valid_types[k].toLowerCase()==theFileType.toLowerCase()) type_ok=true;
		}
		if (!type_ok)
		{
			errorMsg="{!INVALID_FILE_TYPE^#,xx1xx,{$VALID_FILE_TYPES}}".replace(/xx1xx/g,theFileType).replace(/<[^>]*>/g,'').replace(/&[lr][sd]quo;/g,"'").replace(/,/g,', ');
			if (!alerted) window.alert(errorMsg);
			alerted=true;
		}
	}

	// Fix up bad characters
	if ((browser_matches('ie')) && (theElement.value) && (theElement.nodeName.toLowerCase()!='select'))
	{
		bad_word_chars=[8216,8217,8220,8221];
		fixed_word_chars=["'","'",'"','"'];
		for (i=0;i<bad_word_chars.length;i++)
		{
			regexp=new RegExp(String.fromCharCode(bad_word_chars[i]),'gm');
			theElement.value=theElement.value.replace(regexp,fixed_word_chars[i]);
		}
	}

	theClass=firstClassName(theElement.className);

	if ((!forPreview) && (theElement.name=='delete') && (((theClass=='input_radio') && (theElement.value!='0')) || (theClass=='input_tick')) && (theElement.checked)) {
		erroneous = !confirmDelete();
			return [erroneous,theElement,0,true]; // Because we're deleting, errors do not matter
	}

	// Find whether field is required and value of it
	required=theElement.className.indexOf('_required');
	myValue=cleverFindValue(theForm,theElement);

	if ((required!=-1) && ((myValue.replace(/&nbsp;/g,' ').replace(/<br\s*\/?>/g,' ').replace(/\s/g,'')=='') || (myValue=='****')))
	{
		errorMsg="{!REQUIRED_NOT_FILLED_IN^#}";
	} else
	{
		if ((theElement.className.indexOf('date')!=-1) && (theElement.name.match(/\_(day|month|year)$/)) && (myValue!=''))
		{
			var day=theForm.elements[theElement.name.replace(/\_(day|month|year)$/,'_day')].options[theForm.elements[theElement.name.replace(/\_(day|month|year)$/,'_day')].selectedIndex].value;
			var month=theForm.elements[theElement.name.replace(/\_(day|month|year)$/,'_month')].options[theForm.elements[theElement.name.replace(/\_(day|month|year)$/,'_month')].selectedIndex].value;
			var year=theForm.elements[theElement.name.replace(/\_(day|month|year)$/,'_year')].options[theForm.elements[theElement.name.replace(/\_(day|month|year)$/,'_year')].selectedIndex].value;
			var source_date=new Date(year,month-1,day);
			if (year!=source_date.getFullYear()) errorMsg="{!NOT_A_DATE^#}";
			if (month!=source_date.getMonth()+1) errorMsg="{!NOT_A_DATE^#}";
			if (day!=source_date.getDate()) errorMsg="{!NOT_A_DATE^#}";
		}
		if (((theClass=='input_email') || (theClass=='input_email_required')) && (myValue!='') && (myValue!='****') && (!myValue.match(/^[a-zA-Z0-9\._\-\+]+@[a-zA-Z0-9\._\-]+$/)))
		{
			errorMsg="{!NOT_A_EMAIL^#}".replace('xxx',myValue);
		}
		if (((theClass=='input_username') || (theClass=='input_username_required')) && (myValue!='') && (myValue!='****') && (window.do_ajax_field_test) && (!do_ajax_field_test('{$FIND_SCRIPT_NOHTTP;,username_exists}?username='+encodeURIComponent(myValue))))
		{
			errorMsg="{!NOT_USERNAME^#}".replace('xxx',myValue);
		}
		if (((theClass=='input_codename') || (theClass=='input_codename_required')) && (myValue!='') && (myValue!='****') && (!myValue.match(/^[a-zA-Z0-9\-\.\_]*$/)))
		{
			errorMsg="{!NOT_CODENAME^#}".replace('xxx',myValue);
		}
		if (((theClass=='input_integer') || (theClass=='input_integer_required')) && (myValue!='') && (myValue!='****') && (parseInt(myValue,10)!=myValue-0))
		{
			errorMsg="{!NOT_INTEGER^#}".replace('xxx',myValue);
		}
		if (((theClass=='input_float') || (theClass=='input_float_required')) && (myValue!='') && (myValue!='****') && (parseFloat(myValue)!=myValue-0))
		{
			errorMsg="{!NOT_FLOAT^#}".replace('xxx',myValue);
		}
	}

	setFieldError(theElement,errorMsg);
	if ((errorMsg!='') && (!erroneous))
	{
		erroneous=true;
		errorElement=theElement;
	}
	
	return [erroneous,errorElement,totalFileSize,alerted];
}

function checkForm(theForm,forPreview)
{
	var j,theElement,erroneous=false,totalFileSize=0,alerted=false,errorElement=null,checkResult;
	for (j=0;j<theForm.elements.length;j++)
	{
		if (!theForm.elements[j]) continue;
		
		if (theForm.elements[j].nodeName.toLowerCase()=='object') continue; // IE9 being weird!

		theElement=theForm.elements[j];

		checkResult=checkField(theElement,theForm,forPreview);
		if (checkResult!=null)
		{
			erroneous=checkResult[0] | erroneous;
			if (!errorElement) errorElement=checkResult[1];
			totalFileSize+=checkResult[2];
			alerted=checkResult[3] | alerted;
			
			if (checkResult[0])
			{
				theElement.onblur=function(theElement) { return function(event,no_recurse) {
					var checkResult=checkField(theElement,theForm,forPreview);
					if ((checkResult!=null) && (!checkResult[0]))
					{
						setFieldError(theElement,'');
					}

					if ((!no_recurse) && (theElement.className.indexOf('date')!=-1) && (theElement.name.match(/\_(day|month|year)$/)))
					{
						var e=document.getElementById(theElement.id.replace(/\_(day|month|year)$/,'_day'));
						if (e!=theElement) e.onblur(event,true);
						var e=document.getElementById(theElement.id.replace(/\_(day|month|year)$/,'_month'));
						if (e!=theElement) e.onblur(event,true);
						var e=document.getElementById(theElement.id.replace(/\_(day|month|year)$/,'_year'));
						if (e!=theElement) e.onblur(event,true);
					}
				} }(theElement);
			}
		}
	}
	
	if ((totalFileSize>0) && (theForm.elements['MAX_FILE_SIZE']))
	{
		if (totalFileSize>theForm.elements['MAX_FILE_SIZE'].value)
		{
			if (!erroneous)
			{
				errorElement=theElement;
				erroneous=true;
			}
			if (!alerted)
			{
				window.alert("{!TOO_MUCH_FILE_DATA^#}".replace(new RegExp('\\\\{'+'1'+'\\\\}','g'),Math.round(totalFileSize/1024)).replace(new RegExp('\\\\{'+'2'+'\\\\}','g'),Math.round(theForm.elements['MAX_FILE_SIZE'].value/1024)));
			}
			alerted=true;
		}
	}

	if (erroneous)
	{
		if (!alerted) window.alert("{!IMPROPERLY_FILLED_IN^#}");
		var posy=findPosY(errorElement,true);
		if (posy==0)
		{
			posy=findPosY(errorElement.parentNode,true);
		}

		if (posy!=0)
			smoothScroll(posy-50,null,null,function() { try { errorElement.focus(); } catch(e) {}; /* Can have exception giving focus on IE for invisible fields */ } );
	}

	return !erroneous;
}

// Do dynamic setLocked/setRequired such that one of these must be set, but only one may be
function standardAlternateFields(_a,_b,_c,non_actually_required)
{
	if (!non_actually_required) non_actually_required=false; // Just to make sure it's a nice boolean

	// Get field objects
	var a=_standardAlternateFieldsGet(_a);
	var b=_standardAlternateFieldsGet(_b);
	var c;
	if (_c) c=_standardAlternateFieldsGet(_c); // Third alternate is optional

	// Set up listening if not already...
	if (((a) && (!a.alternating)) || ((b) && (!b.alternating)) || ((c) && (!c.alternating))) // It is actually allowed for a single alternator, if circumstances have made the other one non-present (such as having GD support meaning a thumbnail isn't needed)
	{
		var selfFunction=function (e) { standardAlternateFields(_a,_b,_c,non_actually_required); } ; // We'll re-call ourself to do any fiddling

		_standardAlternateFieldEventSet(a,selfFunction);
		_standardAlternateFieldEventSet(b,selfFunction);
		_standardAlternateFieldEventSet(c,selfFunction);
	}

	// Now, look at what is set, and disable/enable/require/non-require appropriately
	if ((a) && (((a.value!='') && (a.value!='-1')) || ((a.virtual_value) && (a.virtual_value!='') && (a.virtual_value!='-1'))))
		return _standardAlternateFieldsSet(a,b,c,non_actually_required);
	if ((b) && (((b.value!='') && (b.value!='-1')) || ((b.virtual_value) && (b.virtual_value!='') && (b.virtual_value!='-1'))))
		return _standardAlternateFieldsSet(b,a,c,non_actually_required);
	if ((c) && (((c.value!='') && (c.value!='-1')) || ((c.virtual_value) && (c.virtual_value!='') && (c.virtual_value!='-1'))))
		return _standardAlternateFieldsSet(c,a,b,non_actually_required);
	// Nothing set...
	if (a) _standardAlternateFieldSet(a,null,false,true,non_actually_required);
	if (b) _standardAlternateFieldSet(b,null,false,true,non_actually_required);
	if (c) _standardAlternateFieldSet(c,null,false,true,non_actually_required);
	return null;
}

function _standardAlternateFieldEventSet(a,selfFunction)
{
	if (a)
	{
		if (typeof a.name!='undefined')
		{
			addEventListenerAbstract(a,"keyup",selfFunction);
			addEventListenerAbstract(a,"change",selfFunction);
			a.fakeonchange=selfFunction;
			a.alternating=true;
		} else
		{
			var i;
			for (i=0;i<a.length;i++)
			{
				addEventListenerAbstract(a[i],"keyup",selfFunction);
				addEventListenerAbstract(a[i],"change",selfFunction);
				a[i].fakeonchange=selfFunction;
				a[i].alternating=true;
			}
			a.alternating=true;
		}
	}
	return null;
}

function _standardAlternateFieldsGet(x)
{
	if (x.indexOf('*')==-1) // A normal field
	{
		return document.getElementById(x);
	}
	
	// A radio field ('*'), so we need to create a virtual field object to return that will hold our value
	x=x.substr(0,x.length-1);
	var _x=[],i,j,c=0,e;
	_x['value']='';
	for (i=0;i<document.forms.length;i++)
	{
		for (j=0;j<document.forms[i].elements.length;j++)
		{
			e=document.forms[i].elements[j];
			if (e.name==x)
			{
				_x[c]=e;
				if (e.checked) // This is the checked radio equivalent to our text field, copy the value through to the text field
				{
					_x['value']=e.value;
				}
				if (e.alternating) _x.alternating=true;
				c++;
			}
		}
	}

	return _x;
}

/*
For this function...
a is what is chosen
b is what was not chosen [or null if not so many choices]
c is what was not chosen [or null if not so many choices]
*/
function _standardAlternateFieldsSet(a,b,c,non_actually_required)
{
	if (a) _standardAlternateFieldSet(a,a,false,true,non_actually_required);
	if (b) _standardAlternateFieldSet(b,a,true,false,non_actually_required);
	if (c) _standardAlternateFieldSet(c,a,true,false,non_actually_required);
}

/*
Selected may only be null if locked is false
*/
function _standardAlternateFieldSet(us,selected,locked,required,non_actually_required)
{
	if (typeof us.name!='undefined')
	{
		setLocked(us.name,locked,selected);
		if (!non_actually_required) setRequired(us.name,required);
		var tr=us;
		while ((tr) && (tr.nodeName.toLowerCase()!='tr'))
		{
			tr=tr.parentNode;
		}
		if ((tr) && (tr.nodeName.toLowerCase()=='tr'))
			setOpacity(tr,locked?0.3:1.0);
	} else
	{
		if (us[0])
		{
			if (!non_actually_required) setRequired(us[0].name,required);
		}

		var i;
		for (i=0;i<us.length;i++)
		{
			if (us[i].id) // If it is an object, as opposed to some string in the collection
			{
				setLocked(us[i].id,locked,selected);
				if (!non_actually_required) setRequired(us[i].id,required);
				var tr=us[i];
				while ((tr) && (tr.nodeName.toLowerCase()!='tr'))
				{
					tr=tr.parentNode;
				}
				if ((tr) && (tr.nodeName.toLowerCase()=='tr'))
					setOpacity(tr,locked?0.3:1.0);
			}
		}
	}
}

function setLocked(name,locked,selected)
{
	// For All-and-not,Line-multi,Compound-Tick,Radio-List,Date/Time: setLocked assumes that the calling code is clever
	// special input types are coded to observe their master input field readonly status)
	var element=document.getElementById(name);
	if (element)
	{
		if (locked)
		{
			var labels=document.getElementsByTagName('label'),label=null;
			for (var i=0;i<labels.length;i++)
			{
				if (labels[i].getAttribute('for')==selected.id)
				{
					label=labels[i];
					break;
				}
			}
			if (label)
			{
				var label_nice=getInnerHTML(label).replace('&raquo;','').replace('»','').replace(/^\s*/,'').replace(/\s*$/,'');
				if (element.type=='file')
				{
					setFieldError(element,'{!DISABLED_FORM_FIELD_ENCHANCEDMSG_UPLOAD^;}'.replace(/\\{1\\}/,label_nice));
				} else
				{
					setFieldError(element,'{!DISABLED_FORM_FIELD_ENCHANCEDMSG^;}'.replace(/\\{1\\}/,label_nice));
				}
			} else
			{
				setFieldError(element,'{!DISABLED_FORM_FIELD^;}');
			}
			element.className=element.className.replace(/( input_erroneous($| ))+/g,' ');
		} else
		{
			setFieldError(element,'');
		}
		element.disabled=locked;
	}
}

function setRequired(name,required)
{
	var element=document.getElementById(name);
	var required_a=document.getElementById('requirea__'+name);
	var required_b=document.getElementById('requireb__'+name);
	var required_c=document.getElementById('requirec__'+name);
	var required_d=document.getElementById('required__'+name);
	if (element) element.className=element.className.replace(/(input\_[a-z\_]+)_required/g,'$1');
	if (required)
	{
		if (element) element.className=element.className.replace(/(input\_[a-z\_]+)/g,'$1_required');
		if (required_a) required_a.className='de_th dottedborder_barrier_a_required';
		if (required_d) required_d.className='dottedborder_barrier_b_required';
		if (required_b) required_b.style.display='inline';
		if (required_c) required_c.value=1;
	} else
	{
		var error=document.getElementById('error__'+name);
		if (error) error.style.display='none';
		if (required_a) required_a.className='de_th dottedborder_barrier_a_nonrequired';
		if (required_d) required_d.className='dottedborder_barrier_b_nonrequired';
		if (required_b) required_b.style.display='none';
		if (required_c) required_c.value=0;
	}
	if (element)
	{
		if (typeof element.swfob!='undefined') element.swfob.settings.required=required;
	}
}

// Hide a 'tray' of trs in a form
function toggleSubordinateFields(pic,help_id)
{
	var new_state,new_state_2,new_state_3,i;
	var tr=pic.parentNode.parentNode.parentNode;
	
	var next=tr.nextSibling;
	if (!next) return;
	while (next.nodeName.toLowerCase()!='tr') // Sometimes divs or whatever may have errornously been put in a table by a programmer, skip past them
	{
		next=next.nextSibling;
		if (!next) break;
		if (next.className=='form_screen_field_spacer') // End of section, so no need to keep going
		{
			next=null;
			break;
		}
	}

	if (((!next) && (pic.src.indexOf('expand')!=-1)) || ((next) && (next.style.display=='none'))) {$,Expanding now}
	{
		pic.src=((pic.src.indexOf("themewizard.php")!=-1)?pic.src.replace("expand","contract"):"{$IMG,contract}").replace(/^http:/,window.location.protocol);
		pic.setAttribute('alt','{!CONTRACT;}');
		pic.setAttribute('title','{!CONTRACT;}');
		new_state=browser_matches('ie')?'block':'table-row';
		new_state_2='block';
		new_state_3='1px dashed';
	} else {$,Contracting now}
	{
		pic.src=((pic.src.indexOf("themewizard.php")!=-1)?pic.src.replace("contract","expand"):"{$IMG,expand}").replace(/^http:/,window.location.protocol);
		pic.setAttribute('alt','{!EXPAND;}');
		pic.setAttribute('title','{!EXPAND;}');
		new_state='none';
		new_state_2='none';
		new_state_3='0';
	}
	
	// Hide everything until we hit end of section
	var count=0;
	while (tr.nextSibling)
	{
		tr=tr.nextSibling;
		if (tr.nodeName.toLowerCase()!='tr') continue;

		{$,Start of next section?}
		if (tr.className=='form_screen_field_spacer') break; // End of section
		
		{$,Ok to proceed}
		tr.style.display=new_state;
		if (browser_matches('ie6'))
		{
			for (i=0;i<tr.cells.length;i++) // Work around IE6 bug (the table borders do not hide so you need to turn them off for hidden cells)
			{
				tr.cells[i].style.border=new_state_3;
				tr.cells[i].style.display=new_state;
			}
		}

		if ((typeof window.nereidFade!='undefined') && (new_state_2!='none') && (count<50/*Performance*/))
		{
			setOpacity(tr,0.0);
			nereidFade(tr,100,30,4);
			count++;
		}
	}
	if (!help_id) help_id=pic.parentNode.id+'_help';
	var help=document.getElementById(help_id);
	while (help)
	{
		help.style.display=new_state_2;
		help=help.nextSibling;
		if ((help) && (help.nodeName.toLowerCase()!='p')) break;
	}
	
	trigger_resize();
}

function choose_picture(id,ob,name)
{
	var r=document.getElementById(id);
	if (!r) return;
	var e=r.form.elements[name];
	if (e.length<100)
	{
		for (var i=0;i<e.length;i++)
		{
			var img=e[i].parentNode.parentNode.parentNode.getElementsByTagName('img')[0];
			if ((img) && (img!=ob))
			{
				img.style.outline='0';
				if (!browser_matches('ie8+')) img.style.background='none';
				if (!browser_matches('no_alpha_ie_with_opacity'))
				{
					setOpacity(img.parentNode,0.5);
					img.parentNode.onmouseover=function(img) { return function()
					{
						setOpacity(img.parentNode,1.0);
					} } (img);
					img.parentNode.onmouseout=function(img) { return function()
					{
						setOpacity(img.parentNode,0.5);
					} } (img);
				}
			}
		}
	}

	r.checked=true;
	//if (r.onclick) r.onclick(); causes loop
	ob.parentNode.onmouseover=function() {};
	ob.parentNode.onmouseout=function() {};
	if (typeof r.fakeonchange!='undefined' && r.fakeonchange) r.fakeonchange();
	if (e.length<100)
	{
		if (!browser_matches('no_alpha_ie_with_opacity')) setOpacity(ob.parentNode,1.0);
		ob.style.outline='1px dotted';
		if (!browser_matches('ie8+')) ob.style.background='green';
	}
}

function disable_preview_scripts(under)
{
	if (!under) under=document;

	var elements,i;
	var no_go=function() {
		window.alert('{!NOT_IN_PREVIEW_MODE^;}');
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

function setUpChangeMonitor(container,input,container2)
{
	var elements=[];
	if (input)
	{
		elements=[document.getElementById(input)];
	} else
	{
		elements=getAllFormElements(container);
	}
	if (elements.length>300) return;
	for (var i=0;i<elements.length;i++)
	{
		if (!elements[i]) continue;
		var func=function () {
			if (findIfChildrenSet(input?document.getElementById(input).parentNode:container))
			{
				if (container.className.indexOf(' filledin')==-1) container.className+=' filledin';
				if (container2) if (container2.className.indexOf(' filledin')==-1) container2.className+=' filledin';
			} else
			{
				container.className=container.className.replace(/ filledin$/,'');
				if (container2) container2.className=container2.className.replace(/ filledin$/,'');
			}
		};
		addEventListenerAbstract(elements[i],'blur',func );
		addEventListenerAbstract(elements[i],'change',func );
	}
}

function findIfChildrenSet(container)
{
	var value,blank=true,theElement;
	var elements=getAllFormElements(container);
	for (var i=0;i<elements.length;i++)
	{
		if (!elements[i]) continue;
		theElement=elements[i];
		if (((theElement.type=='hidden') || ((theElement.style.display=='none') && ((typeof window.isWYSIWYGField=='undefined') || (!isWYSIWYGField(theElement))))) && ((!theElement.className) || (theElement.className.indexOf('hidden_but_needed')==-1))) continue;
		value=cleverFindValue(theElement.form,theElement);
		blank=blank & (value=='');
	}
	return !blank;
}

function getAllFormElements(container)
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
