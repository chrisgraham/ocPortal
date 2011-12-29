<script type="text/javascript">// <![CDATA[
	window.setTimeout(function () {
		var element;
		if (!window.opener) window.opener=window.parent;
		element=opener.document.getElementById('{FIELD_NAME;}');
		element=ensure1_id(element,'{FIELD_NAME;}');

		var comcode;
	
		if (is_comcode_xml(element))
		{
			comcode='<br /><br />{COMCODE_XML^;/}';
		} else
		{
			comcode='{COMCODE^;/}';
		}

		if ('{$_GET%,save_to_id}'!='')
		{
			var ob=opener.areaedit_editors[element.id].document.$.getElementById('{$_GET%,save_to_id}');
			ob.orig_title=comcode.replace(/^\s*/,'');
			ob.title=comcode.replace(/^\s*/,'');

			if ('{$_POST%,_delete}'=='1')
			{
				ob.parentNode.removeChild(ob);
			}
		
			opener.areaedit_editors[element.id].updateElement();
		} else
		{
			insertTextboxOpener(element,comcode);
			var win=window;
			window.fauxmodal_alert(
				'{!ADDED_COMCODE_ONLY;}',
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

