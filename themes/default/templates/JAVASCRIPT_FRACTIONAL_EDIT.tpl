"use strict";

function fractional_edit(event,object,url,raw_text,edit_param_name,was_double_click)
{
	if (typeof was_double_click=='undefined') var was_double_click=false;

	if (raw_text.length>255) return null; // Cannot process this

	if ((magic_keypress(event)) || (was_double_click))
	{
		cancel_bubbling(event);
		if (typeof event.preventDefault!='undefined') event.preventDefault();

		// Position form
		var width=find_width(object);
		if (width<160) width=160;
		var x=find_pos_x(object);
		var y=find_pos_y(object);

		// Record old JS events
		object.old_onclick=object.onclick;
		object.old_ondblclick=object.ondblclick;
		object.old_onkeypress=object.onkeypress;

		// Create form
		var form=document.createElement('form'); // The form is never submitted actually: we use XMLHttpRequest
		form.method='post';
		form.action=url;
		form.style.display='inline';
		var input=document.createElement('input');
		input.setAttribute('maxlength','255');
		input.style.position='absolute';
		input.style.left=(x)+'px';
		input.style.top=(y)+'px';
		input.style.width=width+'px';
		input.style.margin=0;
		var to_copy=['border','padding-top','border-top','border-right','border-bottom','padding-left','border-left','font-size','font-weight','font-style'];
		for (var i=0;i<to_copy.length;i++)
		{
			input.style[to_copy[i]]=abstract_get_computed_style(object.parentNode,to_copy[i]);
		}
		input.name=edit_param_name;
		if (typeof object.raw_text!='undefined')
		{
			input.value=object.raw_text; // Our previous text edited in this JS session
		} else
		{
			object.raw_text=raw_text;
			input.value=raw_text; // What was in the DB when the screen loaded
		}
		form.onsubmit=function(event) { return false; };

		var cleanup_function=function() {
			object.onclick=object.old_onclick;
			object.ondblclick=object.old_ondblclick;
			object.onkeypress=object.old_onkeypress;

			if (input.form.parentNode)
			{
				input.onblur=null; // So don't get recursion
				input.form.parentNode.removeChild(input.form);
			}
		};

		var cancel_function=function() {
			cleanup_function();

			window.fauxmodal_alert('{!FRACTIONAL_EDIT_CANCELLED;^}',null,'{!FRACTIONAL_EDIT;^}');

			return false;
		};

		var save_function=function() {
			// Call AJAX request
			var response=do_ajax_request(input.form.action,false,input.name+'='+window.encodeURIComponent(input.value));

			// Some kind of error?
			if ((response.responseText=='') || (response.responseText.length>200) || (!response.responseText))
			{
				var session_test_url='{$FIND_SCRIPT_NOHTTP;,confirm_session}';
				var session_test_ret=do_ajax_request(session_test_url+keep_stub(true));

				if ((session_test_ret.responseText!='') && (session_test_ret.responseText!=null)) // If it failed, see if it is due to a non-confirmed session
				{
					confirm_session(
						function(result)
						{
							if (result)	save_function();
						}
					);
				} else
				{
					window.fauxmodal_alert('{!ERROR_FRACTIONAL_EDIT;^}',null,'{!FRACTIONAL_EDIT;^}');
				}
			} else // Success
			{
				object.raw_text=input.value;
				set_inner_html(object,response.responseText);
			}

			cleanup_function();

			return false;
		};

		// If we activate it again, we actually treat this as a cancellation
		object.onclick=object.ondblclick=function(event)
			{
				if (typeof event=='undefined') var event=window.event;

				cancel_bubbling(event);
				if (typeof event.preventDefault!='undefined') event.preventDefault();

				if (magic_keypress(event)) cleanup_function();

				return false;
			}

		// Cancel or save actions
		input.onkeyup=function(event) // Not using onkeypress because that only works for actual represented characters in the input box
			{
				if (typeof event=='undefined') var event=window.event;

				if ((key_pressed(event,[27],true)) && (this.value!='')) // Cancel (escape key)
				{
					return cancel_function();
				}

				if ((enter_pressed(event)) && (this.value!='')) // Save
				{
					return save_function();
				}

				return null;
			}
		input.onblur=function(event)
			{
				if (this.value!='') save_function(); else cancel_function();
			}

		// Add in form
		form.appendChild(input);
		var website_inner=document.getElementById('main_website_inner'); // So x/y positioning is correct
		if (!website_inner) website_inner=document.body;
		website_inner.appendChild(form);
		input.focus();
		input.select();
		return false;
	}

	return null;
}

