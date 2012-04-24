<script type="text/javascript">// <![CDATA[
	var post=window.parent.document.getElementById('post');

	// Replace Comcode
	top.setTextbox(post,'{NEW_POST_VALUE/^;}','{NEW_POST_VALUE_HTML/^;}');

	// Remove attachment uploads
	var inputs=post.form.elements,btn;
	var i,done_one=false;
	for (i=0;i<inputs.length;i++)
	{
		if (((inputs[i].type=='file') || ((inputs[i].type=='text') && (inputs[i].disabled))) && (inputs[i].value!='') && (inputs[i].name.match(/file\d+/)))
		{
			if (typeof inputs[i].swfob!='undefined')
			{
				if ((inputs[i].value!='-1') && (inputs[i].value!=''))
				{
					if (!done_one) window.fauxmodal_alert('{!javascript:ATTACHMENT_SAVED;^}');
					done_one=true;
				}
				
				if (typeof inputs[i].swfob.setButtonDisabled!='undefined')
				{
					inputs[i].swfob.setButtonDisabled(false);
				} else
				{
					top.document.getElementById('uploadButton_'+inputs[i].name).disabled=true;
				}
				inputs[i].value='-1';
			} else
			{
				try
				{
					inputs[i].value='';
				}
				catch (e) { };
			}
			if (typeof inputs[i].form.elements['hidFileID_'+inputs[i].name]!='undefined')
				inputs[i].form.elements['hidFileID_'+inputs[i].name].value='';
		}
	}
//]]></script>


