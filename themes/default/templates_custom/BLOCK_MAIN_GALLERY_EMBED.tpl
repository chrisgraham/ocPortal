{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

{$SET,carousel_id,{$RAND}}

<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
	<div class="move_left" onmousedown="carousel_move({$GET*,carousel_id},-47); return false;" onmouseover="this.className='move_left move_left_hover';" onmouseout="this.className='move_left';"></div>
	<div class="move_right" onclick="carousel_prepare_load_more_{$GET*,carousel_id}({$GET*,carousel_id});" onmousedown="carousel_move({$GET*,carousel_id},+47); return false;" onmouseover="this.className='move_right move_right_hover';" onmouseout="this.className='move_right';"></div>

	<div class="main" id="carousel_{$GET*,carousel_id}_container">
	</div>
</div>

<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
{+END}
	{IMAGES}

{+START,IF,{$NEQ,{$COMMA_LIST_GET,{BLOCK_PARAMS},raw},1}}
</div>

<script type="text/javascript">// <![CDATA[
	addEventListenerAbstract(window,'load',function () {
		initialise_carousel({$GET,carousel_id});
	} );

	var current_loading_from_pos_{$GET*,carousel_id}={$_GET%,mge_start,0};

	function carousel_prepare_load_more_{$GET*,carousel_id}(carousel_id)
	{
		var ob=document.getElementById('carousel_ns_'+carousel_id);

		if (ob.parentNode.scrollLeft+findWidth(ob)*1.5<ob.scrollWidth) return; // Not close enough to need more results

		current_loading_from_pos_{$GET*,carousel_id}+={MAX%};

		call_block(
			'{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS},raw=.*}'+'&mge_start='+current_loading_from_pos_{$GET*,carousel_id},
			'raw=1',
			ob,
			true
		);
	}
//]]></script>
{+END}