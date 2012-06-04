"use strict";

function fractional_edit(event,object,url,edit_text,edit_param_name)
{
	if (magic_keypress(event))
	{
		// Bubbling needs to be stopped because shift+click will open a new window on some lower event handler (in firefox anyway)
		cancel_bubbling(event);

		require_javascript("javascript_ajax");

		var width=find_width(object);
		if (width<180) width=180;
		var x=find_pos_x(object);
		var y=find_pos_y(object);

		object.old_onclick=object.onclick;
		object.old_onkeypress=object.onkeypress;

		var form=document.createElement('form'); // The form is never submitted actually: we use XMLHttpRequest
		form.method='post';
		form.action=url;
		form.style.display='inline';
		var input=document.createElement('input');
		input.style.position='absolute';
		input.style.left=(x-1)+'px';
		input.style.top=(y-1)+'px';
		input.style.width=width+'px';
		input.name=edit_param_name;
		input.value=edit_text;
		input.onkeypress=function (event)
			{
				if (typeof event=='undefined') var event=window.event;
				if ((enter_pressed(event)) && (this.value!=''))
				{
					if (typeof window.do_ajax_request=='undefined')
					{
						window.setTimeout(function () { input.onkeypress(event); } ,100);
						return false;
					}

					var response=do_ajax_request(input.form.action,false,input.name+'='+window.encodeURIComponent(input.value));
					input.form.parentNode.removeChild(input.form);
					object.onclick=object.old_onclick;
					object.onkeypress=object.old_onkeypress;
					if ((response.responseText=='') || (response.responseText.length>200) || (!response.responseText))
					{
						if (response.responseText.length>200)
						{
							//require_javascript('javascript_more');
							//while (!window.window_r)
							//{
							//}
							//window_r(response.responseText);
							document.write(response.responseText);
						}

						var session_test_url='{$FIND_SCRIPT_NOHTTP;,confirm_session}';
						var session_test_ret=do_ajax_request(session_test_url+keep_stub(true));

						if ((session_test_ret.responseText!='') && (session_test_ret.responseText!=Null)) // If it failed, see if it is due to a non-confirmed session
						{
							confirm_session(
								false,
								function(result)
								{
									if (result)
										input.onkeypress(event);
								}
							);
						} else
						{
							window.fauxmodal_alert('{!ERROR_FRACTIONAL_EDIT^;}');
						}
					} else
					{
						set_inner_html(object,response.responseText);
					}

					return false;
				}

				return true;
			}

		object.onkeypress=function () { };
		object.onclick=function (event)
			{
				if (typeof event=='undefined') var event=window.event;

				// Bubbling needs to be stopped because shift+click will open a new window on some lower event handler (in firefox anyway)
				cancel_bubbling(event);

				if (magic_keypress(event))
				{
					object.onclick=object.old_onclick;
					object.onkeypress=object.old_onkeypress;
				}

				return false;
			}
		var remove_function=function (event)
			{
				if (typeof event=='undefined') var event=window.event;

				if (magic_keypress(event))
				{
					form.parentNode.removeChild(form);
				}

				return true;
			}
		input.onclick=remove_function;
		input.onblur=function (event)
			{
				if (form.parentNode)
				{
					form.parentNode.removeChild(form);
					window.fauxmodal_alert('{!FRACTIONAL_EDIT_CANCELLED^;}');
				}
			}

		form.appendChild(input);
		document.body.appendChild(form);
		input.focus();
		return false;
	}

	return true;
}

