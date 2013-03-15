<section class="box box___block_side_tag_cloud"><div class="box_inner">
	<h3>{TITLE*}</h3>

	<nav id="tag_sphere" style="height: 150px; position:relative; overflow: hidden;" role="navigation">
		<ul style="margin:0;padding:0;list-style-type:none">
			{+START,LOOP,TAGS}
				<li id="item{_loop_key*}" style="margin:0;padding:0;list-style-type:none"><a rel="tag" href="{LINK*}" style="font-size: {EM*}em">{TAG*}</a></li>
			{+END}
		</ul>
	</nav>

	{$REQUIRE_JAVASCRIPT,javascript_tag_cloud}

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			load_tag_cloud(document.getElementById('tag_sphere'));
		} );
	//]]></script>
</div></section>
