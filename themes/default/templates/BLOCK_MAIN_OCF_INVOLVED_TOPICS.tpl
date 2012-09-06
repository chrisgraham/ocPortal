{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
<div id="{$GET*,wrapper_id}">
	{TOPICS}

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			{$REQUIRE_JAVASCRIPT,javascript_ajax}
			internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),['[^_]*_start'], { } );
		} );
	//]]></script>
</div>
