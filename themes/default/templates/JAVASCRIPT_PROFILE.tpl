"use strict";

function decrypt_data(encrypted_data)
{
	var container=document.createElement('div');
	container.className='comcode_overlay';
	container.className='decryption_overlay';
	container.style.position='absolute';
	container.style.width='300px';
	container.style.left=(get_window_width()/2-200).toString()+'px';
	container.style.top=(get_window_height()/2-100).toString()+'px';

	var title=document.createElement('h2');
	title.appendChild(document.createTextNode('{!encryption:DECRYPT_TITLE;^}'));
	container.appendChild(title);

	var description=document.createElement('p');
	description.appendChild(document.createTextNode('{!encryption:DECRYPT_DESCRIPTION;^}'));
	container.appendChild(description);

	var form=document.createElement('form');
	form.action=window.location.href;
	form.method='post';
	container.appendChild(form);

	var label=document.createElement('label');
	label.setAttribute('for','decrypt');
	label.appendChild(document.createTextNode('{!encryption:DECRYPT_LABEL;^}'));
	form.appendChild(label);

	var space=document.createTextNode(' ');
	form.appendChild(space);

	var input=document.createElement('input');
	input.type='password';
	input.name='decrypt';
	input.id='decrypt';
	form.appendChild(input);

	var proceed_div=document.createElement('div');
	proceed_div.className='proceed_button';

	// Cancel button
	var button=document.createElement('button');
	button.type='button';
	button.appendChild(document.createTextNode('{!INPUTSYSTEM_CANCEL;^}'));
	// Remove the form when it's cancelled
	add_event_listener_abstract(button,'click',function () { document.getElementsByTagName('body')[0].removeChild(container); return false; });
	proceed_div.appendChild(button);

	// Submit button
	button=document.createElement('input');
	button.type='submit';
	button.value='{!encryption:DECRYPT;^}';
	// Hide the form upon submission
	add_event_listener_abstract(button,'click',function () { container.style.display='none'; return true; });
	proceed_div.appendChild(button);

	form.appendChild(proceed_div);

	document.getElementsByTagName('body')[0].appendChild(container);
}
