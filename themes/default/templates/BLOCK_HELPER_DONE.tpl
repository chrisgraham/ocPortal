<script type="text/javascript">// <![CDATA[
	var element;
	element=opener.document.getElementById('{FIELD_NAME;}');
	element=ensure1_id(element,'{FIELD_NAME;}');

	var comcode;
	
	if (is_comcode_xml(element))
	{
		comcode='<br /><br />{COMCODE_XML^;/}';
	} else
	{
		comcode='\n\n{COMCODE^;/}';
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
		window.alert('{!ADDED_COMCODE_ONLY;}');
	}

	window.close();
//]]></script>

