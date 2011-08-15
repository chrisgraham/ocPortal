<script type="text/javascript">// <![CDATA[
	var element;
	element=opener.document.getElementById('{FIELD_NAME;}');
	element=ensure_true_id(element,'{FIELD_NAME;}');

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
	} else
	{
		insertTextboxOpener(element,comcode);
		window.alert('{!ADDED_COMCODE_ONLY;}');
	}

	window.close();
//]]></script>

