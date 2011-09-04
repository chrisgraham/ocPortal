<div id="arrow-left">
	<a href="#" onclick="return initialise_image_fader(window.fader_at-1,true);"><img alt="previous image" src="{$IMG*,arrow-left}" /></a>
</div>
<div id="images">
	<a href="{GALLERY_URL*}"><img id="image_fader_{RAND%}" src="{$THUMBNAIL*,{FIRST_URL},465x268,,,,pad,both,#00000000}" alt="" /></a>
</div>
<div id="arrow-right">
	<a href="#" onclick="return initialise_image_fader(window.fader_at+1,true);"><img alt="next image" src="{$IMG*,arrow-right}" /></a>
</div>

<script type="text/javascript">// <![CDATA[
function initialise_image_fader(at,reentrant)
{
	if (reentrant) deinitialise_image_fader();

	if (at=={IMAGES%}) at=0;
	if (at==-1) at={IMAGES%}-1;

	window.fader_at=at;

	var fp_animation=document.getElementById('image_fader_{RAND%}');
	while (fp_animation.previousSibling) fp_animation.parentNode.removeChild(fp_animation.previousSibling);
	var fp_animation_fader=document.createElement('img');
	fp_animation.parentNode.insertBefore(fp_animation_fader,fp_animation);
	fp_animation_fader.style.position='absolute';
	fp_animation_fader.src='{$IMG;,blank}';
	var timing_spot;

	{+START,LOOP,IMAGES}
		var url{_loop_key%}='{$THUMBNAIL;,{_loop_var},465x268,,,,pad,both,#00000000}';
		new Image().src=url{_loop_key%}; // precache
		window.fader_timer_{_loop_key%}=null;
		timing_spot=(({_loop_key%}-at)%{IMAGES%});
		window.fader_init_timer_{_loop_key%}=window.setTimeout(function()
		{
			var func{_loop_key%}=function()
			{
				window.fader_at={_loop_key%};

				fp_animation_fader.src=fp_animation.src;
				setOpacity(fp_animation_fader,1.0);
				nereidFade(fp_animation_fader,0,50,-3);
				setOpacity(fp_animation,0.0);
				nereidFade(fp_animation,100,50,3);
				fp_animation.src=url{_loop_key%};
			};
			timing_spot=(({_loop_key%}-at)%{IMAGES%});
			func{_loop_key%}();
			window.fader_timer_{_loop_key%}=window.setInterval(func{_loop_key%},{MILL%}*{IMAGES});
		},timing_spot*{MILL%});
	{+END}
	
	return false;
}

function deinitialise_image_fader()
{
	{+START,LOOP,IMAGES}
		if (window.fader_init_timer_{_loop_key%})
		{
			window.clearTimeout(window.fader_init_timer_{_loop_key%});
			window.fader_init_timer_{_loop_key%}=null;
		}
		if (window.fader_timer_{_loop_key%})
		{
			window.clearInterval(window.fader_timer_{_loop_key%});
			window.fader_timer_{_loop_key%}=null;
		}
	{+END}
}

addEventListenerAbstract(window,'load',function () {
	initialise_image_fader(0,false);
} );
//]]></script>
