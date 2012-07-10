{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}

{$SET,carousel_id,{$RAND}}

<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
	<div class="move_left" onkeypress="this.onmousedown(event);" onmousedown="carousel_move({$GET*,carousel_id},-{SCROLL_AMOUNT%}); return false;"></div>
	<div class="move_right" onkeypress="this.onmousedown(event);" onmousedown="carousel_move({$GET*,carousel_id},+{SCROLL_AMOUNT%}); return false;"></div>

	<div class="main">
	</div>
</div>

<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
	{CONTENT}
</div>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		initialise_carousel({$GET,carousel_id});
	} );
//]]></script>
