{$REQUIRE_JAVASCRIPT,javascript_jquery}
{$REQUIRE_JAVASCRIPT,javascript_unslider}

<div id="unslider" class="unslider">
	<ul>
		{+START,LOOP,PAGES}
			<li>
				<div style="background-image: url('img/sunset.jpg');">
					{$LOAD_PAGE,_unslider_{_loop_var}}
				</div>
			</li>
		{+END}
	</ul>
</div>

<script type="text/javascript">// <![CDATA[
	$('#unslider').unslider({
		fluid: {$?,{FLUID},true,false},
		dots: {$?,{DOTS},true,false},
		delay: {DELAY%},
		speed: {SPEED%}
	});
//]]></script>
