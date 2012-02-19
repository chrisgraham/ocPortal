{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
<div id="{$GET*,wrapper_id}">
	<div class="gallery_media_expose_wrap">
		{IMAGES}
	</div>

	{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
		<br />
		<div class="float_surrounder">
			{RESULTS_BROWSER}
		</div>
	{+END}

	<script type="text/javascript">// <![CDATA[
		addEventListenerAbstract(window,'load',function () {
			{$JAVASCRIPT_INCLUDE,javascript_ajax}
			internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),['mge_start'],{});
		} );
	//]]></script>
</div>
