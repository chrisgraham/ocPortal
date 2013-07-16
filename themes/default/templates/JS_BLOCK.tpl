{$REQUIRE_JAVASCRIPT,javascript_ajax}

{$SET,js_block_id,js_block_{$RAND%}}

<div id="{$GET%,js_block_id}" aria-busy="true">
	<!-- Block will load in here -->
</div>

<script>// <![CDATA[
	add_event_listener_abstract(window,'real_load',function () {
		call_block('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}','',document.getElementById('{$GET%,js_block_id}'));
	} );
//]]></script>
