{+START,BOX,{TITLE*},,{$?,{$GET,in_panel},panel,classic},tray_open}
	<{$?,{$VALUE_OPTION,html5},nav,div} id="tag_sphere" style="height: 150px; position:relative; overflow: hidden;"{$?,{$VALUE_OPTION,html5}, role="navigation"}>
		<ul style="margin:0;padding:0;list-style-type:none">
			{+START,LOOP,TAGS}
				<li id="item{_loop_key*}" style="margin:0;padding:0;list-style-type:none"><a rel="tag" href="{LINK*}" style="font-size: {EM*}em">{TAG*}</a></li>
			{+END}
		</ul>
	</{$?,{$VALUE_OPTION,html5},nav,div}>

	{$JAVASCRIPT_INCLUDE,javascript_tag_cloud}

	<script type="text/javascript">// <![CDATA[
		addEventListenerAbstract(window,'load',function () {
			load_tag_cloud(document.getElementById('tag_sphere'));
		} );
	//]]></script>
{+END}
