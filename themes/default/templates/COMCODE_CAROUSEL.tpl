{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

{$SET,carousel_id,{$RAND}}

<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
	<div class="move_left" onmousedown="carousel_move({$GET*,carousel_id},-{SCROLL_AMOUNT%}); return false;" onmouseover="this.className='move_left move_left_hover';" onmouseout="this.className='move_left';"></div>
	<div class="move_right" onmousedown="carousel_move({$GET*,carousel_id},+{SCROLL_AMOUNT%}); return false;" onmouseover="this.className='move_right move_right_hover';" onmouseout="this.className='move_right';"></div>

	<div class="main">
	</div>
</div>

<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
	{CONTENT}
</div>

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		initialise_carousel({$GET,carousel_id});
	} );
//]]></script>
