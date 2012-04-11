<div{$?,{$VALUE_OPTION,html5}, aria-busy="true"} class="spaced">
	<div class="ajax_tree_list_loading">
		<img id="loading_image" class="inline_image_2" src="{$IMG*,bottom/loading}" title="{!LOADING^;}" alt="{!LOADING^;}" />
		{!LOADING}
	</div>
</div>

<script type="text/javascript">// <![CDATA[
	window.returnValue=true;

	window.setTimeout(function () {
		var element;
		var target_window=window.opener?window.opener:window.parent;
		element=target_window.document.getElementById('{FIELD_NAME;}');
		if (!element)
		{
			target_window=target_window.frames['iframe_page'];
			element=target_window.document.getElementById('{FIELD_NAME;}');
		}
		element=ensure_true_id(element,'{FIELD_NAME;}');

		var comcode,comcode_semihtml;
		if (is_comcode_xml(element))
		{
			comcode='<br /><br />{COMCODE_XML/^;}';
			comcode_semihtml=comcode;
		} else
		{
			comcode='{COMCODE/^;}';
			comcode_semihtml='{COMCODE_SEMIHTML/^;}';
		}
		var win=window;
		if ('{$_GET%,save_to_id}'!='')
		{
			var ob=target_window.areaedit_editors[element.id].document.$.getElementById('{$_GET%,save_to_id}');
			var input_container=document.createElement('div');
			setInnerHTML(input_container,comcode_semihtml.replace(/^\s*/,''));
			ob.parentNode.replaceChild(input_container.childNodes[0],ob);

			if ('{$_POST%,_delete}'=='1')
			{
				ob.parentNode.removeChild(ob);
			}
		
			target_window.areaedit_editors[element.id].updateElement();

			if (typeof win.faux_close!='undefined')
				win.faux_close();
			else
				win.close();
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
					message='{!ADDED_COMCODE_ONLY_ATTACHMENT;}';
				}
			} else
			{
				message='{!ADDED_COMCODE_ONLY;}';
			}

			target_window.insertTextbox(element,comcode,target_window.document.selection?target_window.document.selection:null,true,comcode_semihtml);
			window.fauxmodal_alert(
				message,
				function() {
					if (typeof win.faux_close!='undefined')
						win.faux_close();
					else
						win.close();
				}
			);
		}
	},1000 ); // Delay it, so if we have in a faux popup it can set up faux_close
//]]></script>

