"use strict";

// ===========
// Multi-field
// ===========

function copy_dates(theStub)
{
	if (theStub!='end') return;

	var i,j,theForm,theElement,v;
	for (i=0;i<document.forms.length;i++)
	{
		theForm=document.forms[i];
		for (j=0;j<theForm.elements.length;j++)
		{
			theElement=theForm.elements[j];
			if (theElement.name.substring(0,6)=='start_')
			{
				v=theElement.value;
				if (theElement.name=='start_hour')
				{
					if (v!=24) v++;
				}
				theForm.elements[theElement.name.replace(/start\_/gi,'end_')].value=v;
			}
		}
	}
}

function change_stubbed(theStub,value)
{
	var i,j,theForm,theElement;
	for (i=0;i<document.forms.length;i++)
	{
		theForm=document.forms[i];
		for (j=0;j<theForm.elements.length;j++)
		{
			theElement=theForm.elements[j];
			if (theElement.name.substring(0,theStub.length+1)==theStub+'_')
			{
				theElement.disabled=!value;
			}
		}
	}
}

function deselect_alt_url(form)
{
	if (typeof form.elements['alt_url']!='undefined')
	{
		form.elements['alt_url'].value='';
	}
}

function _ensure_next_field(event)
{
	if (typeof event=='undefined') var event=window.event;
	if (!key_pressed(event,9)) ensure_next_field(this);
}

function ensure_next_field(thisField)
{
	var mid=thisField.id.lastIndexOf('_');
	var nameStub=thisField.id.substring(0,mid+1);

	var thisNum=thisField.id.substring(mid+1,thisField.id.length)-0;

	var nextNum=thisNum+1;
	var nextField=document.getElementById(nameStub+nextNum);
	var name=nameStub+nextNum;
	var thisId=thisField.id;
	if (!nextField)
	{
		nextNum=thisNum+1;
		thisField=document.getElementById(thisId);
		var nextFieldWrap=document.createElement('div');
		nextFieldWrap.className='constrain_field';
		var nextField;
		if (thisField.nodeName.toLowerCase()=='textarea')
		{
			nextField=document.createElement('textarea');
		} else
		{
			nextField=document.createElement('input');
			nextField.setAttribute('size',thisField.getAttribute('size'));
		}
		nextField.className=thisField.className.replace(/\_required/g,'');
		if (thisField.form.elements['label_for__'+nameStub+'0'])
		{
			var nextLabel=document.createElement('input');
			nextLabel.setAttribute('type','hidden');
			nextLabel.value=thisField.form.elements['label_for__'+nameStub+'0'].value+' ('+(nextNum+1)+')';
			nextLabel.name='label_for__'+nameStub+nextNum;
			nextFieldWrap.appendChild(nextLabel);
		}
		nextField.setAttribute('tabindex',thisField.getAttribute('tabindex'));
		nextField.setAttribute('id',nameStub+nextNum);
		if (thisField.onfocus) nextField.onfocus=thisField.onfocus;
		if (thisField.onblur) nextField.onblur=thisField.onblur;
		if (thisField.onkeyup) nextField.onkeyup=thisField.onkeyup;
		nextField.onkeypress=_ensure_next_field;
		if (thisField.onchange) nextField.onchange=thisField.onchange;
		if (typeof thisField.onrealchange!='undefined') nextField.onchange=thisField.onrealchange;
		if (thisField.nodeName.toLowerCase()!='textarea')
		{
			nextField.setAttribute('type','text');
		}
		nextField.value='';
		nextField.name=((thisField.name.indexOf('[]')==-1)?(nameStub+nextNum):thisField.name);
		nextFieldWrap.appendChild(nextField);
		var br=document.createElement('br');
		nextFieldWrap.appendChild(br);
		thisField.parentNode.parentNode.insertBefore(nextFieldWrap,thisField.parentNode.nextSibling);
	}
}

function _ensure_next_field_upload(event)
{
	if (typeof event=='undefined') var event=window.event;
	if (!key_pressed(event,9)) ensure_next_field_upload(this);
}

function ensure_next_field_upload(thisField)
{
	var mid=thisField.name.lastIndexOf('_');
	var nameStub=thisField.name.substring(0,mid+1);
	var thisNum=thisField.name.substring(mid+1,thisField.name.length)-0;

	var nextNum=thisNum+1;
	var nextField=document.getElementById('multi_'+nextNum);
	var name=nameStub+nextNum;
	var thisId=thisField.id;

	if (!nextField)
	{
		nextNum=thisNum+1;
		thisField=document.getElementById(thisId);
		var nextField=document.createElement('input');
		nextField.className='input_upload';
		nextField.setAttribute('id','multi_'+nextNum);
		nextField.onchange=_ensure_next_field_upload;
		nextField.setAttribute('type','file');
		nextField.name=nameStub+nextNum;
		var br=document.createElement('br');
		thisField.parentNode.appendChild(br);
		thisField.parentNode.appendChild(nextField);
	}
}

