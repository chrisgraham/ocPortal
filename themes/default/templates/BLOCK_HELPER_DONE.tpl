{$REQUIRE_CSS,swfupload}

<div aria-busy="true" class="spaced" id="loading_space">
	<div class="ajax_loading vertical_alignment">
		<img id="loading_image" src="{$IMG*,loading}" title="{!LOADING}" alt="{!LOADING}" />
		<span>{!LOADING}</span>
	</div>
</div>

<script>// <![CDATA[
	window.returnValue=true;

	var element;
	var target_window=window.opener?window.opener:window.parent;
	element=target_window.document.getElementById('{FIELD_NAME;/}');
	if (!element)
	{
		target_window=target_window.frames['iframe_page'];
		element=target_window.document.getElementById('{FIELD_NAME;/}');
	}
	element=ensure_true_id(element,'{FIELD_NAME;/}');
	var is_wysiwyg=target_window.is_wysiwyg_field(element);

	var loading_space=document.getElementById('loading_space');

	function shutdown_overlay()
	{
		var win=window;

		window.setTimeout(function() { // Close master window in timeout, so that this will close first (issue on Firefox) / give chance for messages
			if (typeof win.faux_close!='undefined')
				win.faux_close();
			else
				win.close();
		}, 200);
	}

	function dispatch_block_helper()
	{
		var comcode,comcode_semihtml;
		comcode='{COMCODE;^/}';
		comcode_semihtml='{COMCODE_SEMIHTML;^/}';
		var win=window;
		if ('{SAVE_TO_ID;/}'!='')
		{
			var ob=target_window.wysiwyg_editors[element.id].document.$.getElementById('{$_GET%,save_to_id}');

			{+START,IF,{DELETE}}
				ob.parentNode.removeChild(ob);
			{+END}
			{+START,IF,{$NOT,{DELETE}}}
				var input_container=document.createElement('div');
				set_inner_html(input_container,comcode_semihtml.replace(/^\s*/,''));
				ob.parentNode.replaceChild(input_container.childNodes[0],ob);
			{+END}

			target_window.wysiwyg_editors[element.id].updateElement();

			shutdown_overlay();
		} else
		{
			if ((element.value.indexOf(comcode_semihtml)==-1) || (comcode.indexOf('[attachment')==-1)) // Don't allow attachments to add twice
			{
				target_window.insert_textbox(element,comcode,target_window.document.selection?target_window.document.selection:null,true,comcode_semihtml);
			}

			var message='';
			if (comcode.indexOf('[attachment')==0)
			{
				if (comcode.indexOf('[attachment_safe')==0)
				{
					if (is_wysiwyg)
					{
						var post='';
						var form=element.form;
						for (var i=0;i<form.elements.length;i++)
						{
							if (!form.elements[i].disabled)
								post+='&'+form.elements[i].name+'='+window.encodeURIComponent(target_window.clever_find_value(form,form.elements[i]));
						}

						var preview_ret=target_window.do_ajax_request(target_window.form_preview_url+'&js_only=1',null,post);
						target_window.set_inner_html(loading_space,preview_ret.responseText);
						message='';//'{!ADDED_COMCODE_ONLY_SAFE_ATTACHMENT_INSTANT;}'; Not really needed
					} else
					{
						message='{!ADDED_COMCODE_ONLY_SAFE_ATTACHMENT;}';
					}
				} else
				{
					//message='{!ADDED_COMCODE_ONLY_ATTACHMENT;}';	Kind of states the obvious
				}
			} else
			{
				//message='{!ADDED_COMCODE_ONLY;}';	Kind of states the obvious
			}

			target_window.insert_comcode_tag=function(rep_from,rep_to) { // We define as a temporary global method so we can clone out the tag if needed (e.g. for multiple attachment selections)
				var _comcode_semihtml=comcode_semihtml;
				var _comcode=comcode;
				if (typeof rep_from!='undefined')
				{
					_comcode_semihtml=_comcode_semihtml.replace(rep_from,rep_to);
					_comcode=_comcode.replace(rep_from,rep_to);
				}
			};
			target_window.insert_comcode_tag();

			if (message!='')
			{
				window.fauxmodal_alert(
					message,
					function() {
						shutdown_overlay();
					}
				);
			} else
			{
				shutdown_overlay();
			}
		}
	}

	var attached_event_action=false;

	{$,WYSIWYG-editable attachments must be synched}
	{+START,IF,{$EQ,{BLOCK},attachment_safe}}
		{+START,IF,{$PREG_MATCH,^new_\d+$,{TAG_CONTENTS}}}
			var field='file{$SUBSTR;/,{TAG_CONTENTS},4}';
			var upload_element=target_window.document.getElementById(field);
			if ((typeof upload_element.swfob!='undefined') && (is_wysiwyg))
			{
				var ob=upload_element.swfob;
				if (ob.state==target_window.plupload.STARTED)
				{
					ob.bind('FileUploaded',dispatch_block_helper);
					ob.bind('Error',shutdown_overlay);

					// Keep copying the upload indicator
					var progress=get_inner_html(target_window.document.getElementById('fsUploadProgress_'+field));
					window.setInterval(function() {
						set_inner_html(loading_space,progress);
						document.getElementById('loading_space').className='spaced flash';
					},100);

					attached_event_action=true;
				}
			}
		{+END}
	{+END}

	if (!attached_event_action)
	{
		window.setTimeout(dispatch_block_helper,1000); // Delay it, so if we have in a faux popup it can set up faux_close
	}
//]]></script>

