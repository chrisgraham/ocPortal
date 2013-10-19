{$SET,splurgh_id,splurgh_{$RAND}}

<div class="splurgh" id="{$GET,splurgh_id}"></div>
<script>// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		splurgh('{$GET,splurgh_id}','{KEY_NAME;/}','{URL_STUB;/}',0,-1,0,'{SPLURGH;/}','');
	} );
//]]></script>
<noscript>
	{!JAVASCRIPT_REQUIRED}
</noscript>

