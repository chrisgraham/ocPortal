<div id="billboard">
	<div class="image_fader_box">
		<a href="{GALLERY_URL*}"><img id="image_fader_{RAND%}" src="{$THUMBNAIL*,{FIRST_URL_FULL},907x298,,,pad,#00000000}" alt="" /></a>
	</div>
</div>
<div class="edge-holders"></div>

<script type="text/javascript">// <![CDATA[
addEventListenerAbstract(window,'load',function () {
	var fp_animation=document.getElementById('image_fader_{RAND%}');
	var fp_animation_fader=document.createElement('img');
	fp_animation.parentNode.insertBefore(fp_animation_fader,fp_animation);
	fp_animation_fader.style.position='absolute';
	fp_animation_fader.src='{$IMG;,blank}';

	{+START,LOOP,IMAGES_FULL}
		var url{_loop_key%}='{$THUMBNAIL;,{_loop_var},907x298,,,pad,#00000000}';
		new Image().src=url{_loop_key%}; // precache
		window.setTimeout(function()
		{
			var func{_loop_key%}=function()
			{
				fp_animation_fader.src=fp_animation.src;
				setOpacity(fp_animation_fader,1.0);
				nereidFade(fp_animation_fader,0,50,-3);
				setOpacity(fp_animation,0.0);
				nereidFade(fp_animation,100,50,3);
				fp_animation.src=url{_loop_key%};
			};
			if ({_loop_key%}!=0) func{_loop_key%}();
			window.setInterval(func{_loop_key%},{MILL%}*{IMAGES});
		},{_loop_key%}*{MILL%});
	{+END}
} );
//]]></script>
