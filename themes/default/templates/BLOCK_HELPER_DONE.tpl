<div aria-busy="true" class="spaced">
	<div class="ajax_loading vertical_alignment">
		<img id="loading_image" src="{$IMG*,loading}" title="{!LOADING}" alt="{!LOADING}" />
		<span>{!LOADING}</span>
	</div>
</div>

<script>// <![CDATA[
	window.returnValue=true;

	window.setTimeout(function () {
		var element;
		var target_window=window.opener?window.opener:window.parent;
		element=target_window.document.getElementById('{FIELD_NAME;/}');
		if (!element)
		{
			target_window=target_window.frames['iframe_page'];
			element=target_window.document.getElementById('{FIELD_NAME;/}');
		}
		element=ensure_true_id(element,'{FIELD_NAME;/}');

		var comcode,comcode_semihtml;
		comcode='{COMCODE;^/}';
		comcode_semihtml='{COMCODE_SEMIHTML;^/}';
		var win=window;
		if ('{$_GET%,save_to_id}'!='')
		{
			var ob=target_window.wysiwyg_editors[element.id].document.$.getElementById('{$_GET%,save_to_id}');

			if ('{$_POST%,_delete}'=='1')
			{
				ob.parentNode.removeChild(ob);
			} else
			{
				var input_container=document.createElement('div');
				set_inner_html(input_container,comcode_semihtml.replace(/^\s*/,''));
				ob.parentNode.replaceChild(input_container.childNodes[0],ob);
			}

			target_window.wysiwyg_editors[element.id].updateElement();

			window.setTimeout(function() {
				if (typeof win.faux_close!='undefined')
					win.faux_close();
				else
					win.close();
			}, 1000);
		} else
		{
			var message='';
			if (comcode.indexOf('[attachment')==0)
			{
				if (comcode.indexOf('[attachment_safe')==0)
				{
					message='{!ADDED_COMCODE_ONLY_SAFE_ATTACHMENT;}';
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

				if ((element.value.indexOf(comcode_semihtml)==-1) || (comcode.indexOf('[attachment')==-1)) // Don't allow attachments to add twice
				{
					target_window.insert_textbox(element,_comcode,target_window.document.selection?target_window.document.selection:null,true,_comcode_semihtml);
				}
			};
			target_window.insert_comcode_tag();

			if (message!='')
			{
				window.fauxmodal_alert(
					message,
					function() {
						window.setTimeout(function() { // Close master window in timeout, so that this will close first (issue on Firefox)
							if (typeof win.faux_close!='undefined')
								win.faux_close();
							else
								win.close();
						},0);
					}
				);
			} else
			{
				if (typeof win.faux_close!='undefined')
					win.faux_close();
				else
					win.close();
			}
		}
	},1000 ); // Delay it, so if we have in a faux popup it can set up faux_close
//]]></script>

