{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
<div id="{$GET*,wrapper_id}">
	{+START,IF_NON_EMPTY,{ENTRIES}}
		<div class="float_surrounder display_type_{DISPLAY_TYPE*}">
			{ENTRIES}
		</div>
	{+END}

	{+START,IF_EMPTY,{ENTRIES}}
		<p class="nothing_here">
			{!NO_ENTRIES}
		</p>
	{+END}

	{+START,IF_NON_EMPTY,{SORTING}}
		<div class="box category_sorter inline_block"><div class="box_inner">
			{$SET,show_sort_button,1}
			{SORTING}
		</div></div>
	{+END}

	{+START,IF_NON_EMPTY,{PAGINATION}}
		<div class="float_surrounder ajax_block_wrapper_links">
			{PAGINATION}
		</div>
	{+END}

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			{$REQUIRE_JAVASCRIPT,javascript_ajax}
			internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),['[^_]*_start'], { } );
		} );
	//]]></script>
</div>
