<div class="box box___block_main_image_fader"><div class="box_inner">
	{$SET,RAND,{$RAND}}

	<div class="image_fader_box">
		<a href="{GALLERY_URL*}"><img id="image_fader_{$GET,RAND}" src="{FIRST_URL*}" alt="" /></a>
	</div>

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			var fp_animation=document.getElementById('image_fader_{$GET,RAND}');
			var fp_animation_fader=document.createElement('img');
			fp_animation.parentNode.insertBefore(fp_animation_fader,fp_animation);
			fp_animation_fader.style.position='absolute';
			fp_animation_fader.src='{$IMG;,blank}';

			{+START,LOOP,IMAGES}
				var url{_loop_key%}='{_loop_var;}';
				new Image().src=url{_loop_key%}; // precache
				window.setTimeout(function()
				{
					var func{_loop_key%}=function()
					{
						fp_animation_fader.src=fp_animation.src;
						set_opacity(fp_animation_fader,1.0);
						thumbnail_fade(fp_animation_fader,0,50,-3);
						set_opacity(fp_animation,0.0);
						thumbnail_fade(fp_animation,100,50,3);
						fp_animation.src=url{_loop_key%};
					};
					if ({_loop_key%}!=0) func{_loop_key%}();
					window.setInterval(func{_loop_key%},{MILL%}*{IMAGES});
				},{_loop_key%}*{MILL%});
			{+END}
		} );
	//]]></script>
</div></div>
