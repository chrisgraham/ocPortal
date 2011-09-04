<div class="standardbox_wrap_panel {$?,{$GET,interlock},interlock,}"{+START,IF,{$NEQ,{WIDTH},100%}} style="width: {WIDTH'}"{+END}>
	<div {+START,IF_NON_EMPTY,{TITLE}}id="{TITLE|}" {+END}class="standardbox_classic {$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel}" style="height: {HEIGHT'}; width: {WIDTH'}">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h4 class="standardbox_title_panel">
				{+START,IF,{$CONFIG_OPTION,tray_support}}{+START,IF,{$JS_ON}}
					{+START,IF_IN_ARRAY,tray_open,OPTIONS}
						<a class="standardbox_tray hide_button" href="#" onclick="SetCookie('tray_{TITLE|}',(get_elements_by_class_name(this.parentNode.parentNode,'hide_tag')[0].style.display=='none')?'open':'closed'); hideTag(this.parentNode.parentNode); /*resizeFrame('the_shoutbox');*/ return false;"><img title="" alt="{!EXPAND}/{!CONTRACT}" src="{$IMG*,contract}" /></a>
					{+END}
					{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
						<a class="standardbox_tray hide_button" href="#" onclick="SetCookie('tray_{TITLE|}',(get_elements_by_class_name(this.parentNode.parentNode,'hide_tag')[0].style.display=='none')?'open':'closed'); hideTag(this.parentNode.parentNode); /*resizeFrame('the_shoutbox');*/ return false;"><img title="" alt="{!EXPAND}/{!CONTRACT}" src="{$IMG*,expand}" /></a>
					{+END}
				{+END}{+END}
				{TITLE}
			</h4>
		{+END}
		{+START,IF_NON_EMPTY,{META}}
			<div class="standardbox_meta_classic">
				{+START,LOOP,META}
					<div>{KEY}: {VALUE}</div>
				{+END}
			</div>
		{+END}
		{+START,IF,{$CONFIG_OPTION,tray_support}}{+START,IF,{$JS_ON}}
			{+START,IF_NOT_IN_ARRAY,tray_closed,OPTIONS}
			<div class="standardbox_main_classic hide_tag">
			{+END}
			{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
			<div class="hide_tag standardbox_main_classic" style="display: none">
			{+END}
		{+END}{+END}
		{+START,IF,{$OR,{$NOT,{$CONFIG_OPTION,tray_support}},{$NOT,{$JS_ON}}}}
			<div class="standardbox_main_classic">
		{+END}
			{CONTENT}
		</div>
	</div>

	{+START,IF_NON_EMPTY,{LINKS}}
		<div class="{$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel} standardbox_links_classic community_block_tagline">
			{+START,LOOP,LINKS}
				{_loop_var}
			{+END}
		</div>
	{+END}
</div>
{$SET,interlock,_true}

{+START,IF,{$CONFIG_OPTION,tray_support}}{+START,IF,{$JS_ON}}
	<script type="text/javascript">// <![CDATA[
		var cookie_value=ReadCookie('tray_{TITLE|}');
		{+START,IF_IN_ARRAY,tray_open,OPTIONS}
		if (cookie_value=='closed') hideTag(document.getElementById('{TITLE|}'),true);
		{+END}
		{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
		if (cookie_value=='open') hideTag(document.getElementById('{TITLE|}'),true);
		{+END}
	//]]></script>
{+END}{+END}

