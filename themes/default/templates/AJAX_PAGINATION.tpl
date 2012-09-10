{$REQUIRE_JAVASCRIPT,javascript_ajax}

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),['[^_]*_start'], { } );

		{$,Infinite scrolling hides the pagination when it comes into view, and auto-loads the next link, appending below the current results}
		{+START,IF,{ALLOW_INFINITE_SCROLL}}
			{+START,IF,{$CONFIG_OPTION,infinite_scrolling}}
				var infinite_scrolling=function (event) {
					var url_stem='{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}';
					var wrapper=document.getElementById('{$GET;,wrapper_id}');
					internalise_infinite_scrolling(url_stem,wrapper);
				};
				add_event_listener_abstract(window,'scroll',infinite_scrolling);
				add_event_listener_abstract(window,'keydown',infinite_scrolling_block);
				add_event_listener_abstract(window,'mousedown',infinite_scrolling_block_hold);
				add_event_listener_abstract(window,'mousemove',function() { infinite_scrolling_block_unhold(infinite_scrolling); } ); // mouseup/mousemove does not work on scrollbar, so best is to notice when mouse moves again (we know we're off-scrollbar then)
				infinite_scrolling();
			{+END}
		{+END}
	} );
//]]></script>
