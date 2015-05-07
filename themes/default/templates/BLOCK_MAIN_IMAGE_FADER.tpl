{$SET,RAND,{$RAND}}

<div class="gallery_tease_pic_wrap"><div class="gallery_tease_pic">
	<div class="box box___gallery_tease_pic"><div class="box_inner">
		<div class="float_surrounder">
			<div class="gallery_tease_pic_pic">
				<div class="img_thumb_wrap">
					<a href="{GALLERY_URL*}"><img class="img_thumb" id="image_fader_{$GET,RAND}" src="{FIRST_URL*}" alt="" /></a>
				</div>
			</div>

			<h2>{!MEDIA}</h2>

			<div class="gallery_tease_pic_teaser" id="image_fader_scrolling_text_{$GET,RAND}">
			</div>
		</div>
	</div></div>
</div></div>

<noscript>
	{+START,LOOP,HTML}
		{_loop_var}
	{+END}
</noscript>

<script type="text/javascript">// <![CDATA[
	add_event_listener_abstract(window,'load',function () {
		var fp_animation=document.getElementById('image_fader_{$GET,RAND}');
		var fp_animation_fader=document.createElement('img');
		var tease_scrolling_text=document.getElementById('image_fader_scrolling_text_{$GET,RAND}');
		fp_animation_fader.className='img_thumb';
		fp_animation.parentNode.insertBefore(fp_animation_fader,fp_animation);
		fp_animation.parentNode.style.position='relative';
		fp_animation.parentNode.style.display='block';
		fp_animation_fader.style.position='absolute';
		fp_animation_fader.src='{$IMG;,blank}';

		var period_in_msecs=50;
		increment=3;
		if (period_in_msecs*100/increment>{MILL%})
		{
			period_in_msecs={MILL%}*increment/100;
			period_in_msecs*=0.9; // A little give
		}

		{+START,LOOP,HTML}
			var html{_loop_key%}='{_loop_var;^}';
			{+START,IF,{$EQ,{_loop_key},0}}
				if (tease_scrolling_text) set_inner_html(tease_scrolling_text,html{_loop_key%});
			{+END}
		{+END}
		{+START,LOOP,IMAGES}
			var url{_loop_key%}='{_loop_var;}';
			new Image().src=url{_loop_key%}; // precache
			window.setTimeout(function()
			{
				var func{_loop_key%}=function()
				{
					fp_animation_fader.src=fp_animation.src;
					set_opacity(fp_animation_fader,1.0);
					fade_transition(fp_animation_fader,0,period_in_msecs,increment*-1);
					set_opacity(fp_animation,0.0);
					fade_transition(fp_animation,100,period_in_msecs,increment);
					fp_animation.src=url{_loop_key%};
					fp_animation_fader.style.left=((find_width(fp_animation_fader.parentNode)-fp_animation_fader.width)/2)+'px';
					fp_animation_fader.style.top=((find_height(fp_animation_fader.parentNode)-fp_animation_fader.height)/2)+'px';
					if (tease_scrolling_text)
					{
						set_inner_html(tease_scrolling_text,html{_loop_key%});
					}
				};
				if ({_loop_key%}!=0) func{_loop_key%}();
				window.setInterval(func{_loop_key%},{MILL%}*{IMAGES});
			},{_loop_key%}*{MILL%});
		{+END}
	} );
//]]></script>
