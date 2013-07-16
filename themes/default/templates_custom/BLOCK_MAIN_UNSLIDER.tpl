{$REQUIRE_JAVASCRIPT,javascript_jquery}
{$REQUIRE_JAVASCRIPT,javascript_unslider}

<script src="//use.typekit.net/vgf3zbf.js"></script>
<script>try { Typekit.load(); } catch(e){}</script>

{+START,IF_NON_EMPTY,{WIDTH}}<div style="width: {WIDTH*}">{+END}
	<div id="unslider" class="unslider{+START,IF_EMPTY,{WIDTH}{HEIGHT}} responsive{+END}"{+START,IF_NON_EMPTY,{HEIGHT}} style="height: {HEIGHT*}"{+END}>
		<ul>
			{+START,LOOP,PAGES}
				<li>
					{$LOAD_PAGE,_unslider_{_loop_var}}
				</li>
			{+END}
		</ul>
	</div>
{+START,IF_PASSED,WIDTH}</div>{+END}

<script>// <![CDATA[
	$('#unslider').unslider({
		fluid: {$?,{FLUID},true,false},
		dots: {$?,{BUTTONS},true,false},
		delay: {$?,{$IS_EMPTY,{DELAY}},false,{DELAY%}},
		speed: {SPEED%}
	});
//]]></script>
