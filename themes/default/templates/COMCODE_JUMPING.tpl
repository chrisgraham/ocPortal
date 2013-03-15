{$SET,RAND_ID_JUMPING,rand{$RAND}}

{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}
<div class="inline" id="comcodejumping{$GET%,RAND_ID_JUMPING}">&nbsp;</div>
<script type="text/javascript">// <![CDATA[
addEventListenerAbstract(window,'load',function () {
	var my_id=parseInt(Math.random()*10000);
	jumper_parts[my_id]=[{PARTS/}''];
	jumper_pos[my_id]=1;
	var comcodejumping=document.getElementById('comcodejumping{$GET%,RAND_ID_JUMPING}');
	setInnerHTML(comcodejumping,'<span id="'+my_id+'">'+jumper_parts[my_id][0]+'<\/span>');

	window.setInterval(function() { jumper_tick(my_id); },{TIME%});
} );
//]]></script>
<noscript>
	{FULL*}
</noscript>

