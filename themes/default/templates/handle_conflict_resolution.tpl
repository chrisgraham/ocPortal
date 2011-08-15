{+START,IF_PASSED,PING_URL}{+START,IF_NON_EMPTY,{PING_URL}}
	<script type="text/javascript">// <![CDATA[
		addEventListenerAbstract(window,"load",function() {
			load_XML_doc('{PING_URL;}');
			window.setInterval(function() { load_XML_doc('{PING_URL^;}',function() {} ); },12000);
		} );
	//]]></script>
{+END}{+END}

