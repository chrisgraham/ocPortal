{TITLE}

<p{$?,{$VALUE_OPTION,html5}, role="alert"}>
	{MESSAGE*}
</p>

{+START,IF,{$_GET,keep_fatalistic}}
	{+START,BOX}
		{!MAYBE_NOT_FATAL}
	{+END}
{+END}

{+START,IF_PASSED,WEBSERVICE_RESULT}
	<br />

	<h2>Expanded advice</h2>

	{WEBSERVICE_RESULT}

	<br />
{+END}

<h2>{!STACK_TRACE}</h2>

{TRACE}

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		if ((typeof window.trigger_resize!='undefined') && (window.top!=window)) trigger_resize();
	} );
//]]></script>
