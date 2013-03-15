{$SET,RAND_ID_JUMPING,rand{$RAND}}

{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}

<div class="inline" id="comcodejumping{$GET,RAND_ID_JUMPING}"></div>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		var my_id=parseInt(Math.random()*10000);
		jumper_parts[my_id]=[{PARTS/}''];
		jumper_pos[my_id]=1;
		var comcodejumping=document.getElementById('comcodejumping{$GET,RAND_ID_JUMPING}');
		set_inner_html(comcodejumping,'<span id="'+my_id+'">'+jumper_parts[my_id][0]+'<\/span>');

		window.setInterval(function() { jumper_tick(my_id); },{TIME%});
	} );
//]]></script>

<noscript>
	{FULL*}
</noscript>

