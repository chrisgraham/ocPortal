<div {+START,IF,{$OR,{$NOT,{$BROWSER_MATCHES,ie}},{$BROWSER_MATCHES,ie9+}}}{+START,IF,{$CONFIG_OPTION,tray_support}}{+START,IF,{$JS_ON}}onmouseover="var e=get_elements_by_class_name(this,'hide_button')[0]; if (e) set_opacity(e,1.0);" onmouseout="var e=get_elements_by_class_name(this,'hide_button')[0]; if (e) set_opacity(e,0.4);" {+END}{+END}{+END}class="standardbox_wrap_panel {$?,{$GET,interlock},interlock,}"{+START,IF,{$NEQ,{WIDTH},100%}} style="width: {WIDTH'}"{+END}>
	<div {+START,IF_NON_EMPTY,{TITLE}}id="{TITLE|}" {+END}class="standardbox_classic {$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel}" style="height: {HEIGHT'}; width: {WIDTH'}">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h2 class="standardbox_title_panel">
				{+START,IF,{$CONFIG_OPTION,tray_support}}{+START,IF,{$JS_ON}}
					{+START,IF_IN_ARRAY,tray_open,OPTIONS}
						<a class="standardbox_tray hide_button" href="#" onclick="SetCookie('tray_{TITLE|}',(get_elements_by_class_name(this.parentNode.parentNode,'hide_tag')[0].style.display=='none')?'open':'closed'); hide_tag(this.parentNode.parentNode); /*resize_frame('the_shoutbox');*/ return false;"><img alt="{!CONTRACT}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>
					{+END}
					{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
						<a class="standardbox_tray hide_button" href="#" onclick="SetCookie('tray_{TITLE|}',(get_elements_by_class_name(this.parentNode.parentNode,'hide_tag')[0].style.display=='none')?'open':'closed'); hide_tag(this.parentNode.parentNode); /*resize_frame('the_shoutbox');*/ return false;"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
					{+END}
				{+END}{+END}
				{TITLE}
			</h2>
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
		{$SET,linkbar,0}
		<div class="{$?,{$IS_EMPTY,{TITLE}},standardbox_nt_panel,standardbox_t_panel} standardbox_links_classic community_block_tagline"> 
			{+START,LOOP,LINKS}
				{+START,IF,{$GET,linkbar}}  {+END}{_loop_var}{$SET,linkbar,1}
			{+END}
		</div>
	{+END}
</div>
{$SET,interlock,1}

{+START,IF,{$CONFIG_OPTION,tray_support}}{+START,IF,{$JS_ON}}
	<script type="text/javascript">// <![CDATA[
		var cookie_value=ReadCookie('tray_{TITLE|}');
		var ea=document.getElementById('{TITLE|}');
		if (ea)
		{
			{+START,IF_IN_ARRAY,tray_open,OPTIONS}
			if (cookie_value=='closed') hide_tag(ea,true);
			{+END}
			{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
			if (cookie_value=='open') hide_tag(ea,true);
			{+END}
			{+START,IF,{$OR,{$NOT,{$BROWSER_MATCHES,ie}},{$BROWSER_MATCHES,ie9+}}}
			var e=get_elements_by_class_name(ea,'hide_button')[0];
			if (e) set_opacity(e,0.4);
			{+END}
		}
	//]]></script>
{+END}{+END}

