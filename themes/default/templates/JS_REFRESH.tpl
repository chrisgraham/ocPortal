<script type="text/javascript">// <![CDATA[
	function refresh(form_name)
	{
		document.getElementById(form_name).submit();
	}

	var timer=setTimeout(function() { refresh('{FORM_NAME;;}'); }, 2500);
//]]></script>

