<div class="image-slider">
	<div class="image-wrap">
		<img id="image_fader_{RAND%}" src="{$THUMBNAIL*,{FIRST_URL},418x260,,,,pad,both,#00000000}" width="418" height="260" alt="" />
	</div>
	<div class="thumb-wrap">
		<ul>
			<li class="top-but"><a href="#" onclick="return initialise_image_fader(window.fader_at-1,true);"><img src="{$IMG*,top-but}" width="22" height="15" alt="top" /></a></li>

			{+START,LOOP,IMAGES}{+START,IF,{$LT,{_loop_key},3}}
				<li><a href="#" onclick="return initialise_image_fader({_loop_key%},true);"><img src="{$THUMBNAIL*,{_loop_var},101x67,,,,pad,both,#333333}" width="101" height="67" alt="" /></a></li>
			{+END}{+END}

			<li class="top-but"><a href="#" onclick="return initialise_image_fader(window.fader_at+1,true);"><img src="{$IMG*,bot-but}" width="22" height="15" alt="top" /></a></li>
		</ul>
	</div>
</div>

<script type="text/javascript">// <![CDATA[
function initialise_image_fader(at,reentrant)
{
	if (reentrant) deinitialise_image_fader();

	if (at==3) at=0;
	if (at==-1) at=3-1;

	window.fader_at=at;

	var fp_animation=document.getElementById('image_fader_{RAND%}');
	while (fp_animation.previousSibling) fp_animation.parentNode.removeChild(fp_animation.previousSibling);
	var fp_animation_fader=document.createElement('img');
	fp_animation.parentNode.insertBefore(fp_animation_fader,fp_animation);
	fp_animation_fader.style.position='absolute';
	fp_animation_fader.src='{$IMG;,blank}';
	var timing_spot;

	{+START,LOOP,IMAGES}{+START,IF,{$LT,{_loop_key},3}}
		var url{_loop_key%}='{$THUMBNAIL;,{_loop_var},418x260,,,,pad,both,#00000000}';
		new Image().src=url{_loop_key%}; // precache
		window.fader_timer_{_loop_key%}=null;
		timing_spot=(({_loop_key%}-at)%3);
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
			timing_spot=(({_loop_key%}-at)%3);
			func{_loop_key%}();
			window.fader_timer_{_loop_key%}=window.setInterval(func{_loop_key%},{MILL%}*{IMAGES});
		},timing_spot*{MILL%});
	{+END}{+END}
	
	return false;
}

function deinitialise_image_fader()
{
	{+START,LOOP,IMAGES}{+START,IF,{$LT,{_loop_key},3}}
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
	{+END}{+END}
}

addEventListenerAbstract(window,'load',function () {
	initialise_image_fader(0,false);
} );
//]]></script>
