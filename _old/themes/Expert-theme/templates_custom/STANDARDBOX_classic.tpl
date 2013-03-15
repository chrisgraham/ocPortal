<div class="standardbox_wrap_classic" style="{+START,IF,{$AND,{$NEQ,{WIDTH},100%},{$NOT,{$BROWSER_MATCHES,ie}}}}width: {WIDTH'}{+END}">
	<div {+START,IF_NON_EMPTY,{TITLE}}id="{TITLE|}" {+END}class="standardbox_classic" style="height: {HEIGHT'}; width: {WIDTH'}">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h3 class="standardbox_title_classic">
				{+START,IF,{EXPAND}}{+START,IF,{$JS_ON}}
					{+START,IF_IN_ARRAY,tray_open,OPTIONS}
						<a class="standardbox_tray hide_button" href="#" onclick="SetCookie('tray_{TITLE|}',(get_elements_by_class_name(this.parentNode.parentNode,'hide_tag')[0].style.display=='none')?'open':'closed'); hide_tag(this.parentNode.parentNode); return false;"><img alt="{!CONTRACT}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>
					{+END}
					{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
						<a class="standardbox_tray hide_button" href="#" onclick="SetCookie('tray_{TITLE|}',(get_elements_by_class_name(this.parentNode.parentNode,'hide_tag')[0].style.display=='none')?'open':'closed'); hide_tag(this.parentNode.parentNode); return false;"><img alt="{!EXPAND}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
					{+END}
				{+END}{+END}
				{+START,IF_NON_EMPTY,{TOPLINK}}{+START,IF,{$JS_ON}}
					{TOPLINK}
				{+END}{+END}
				{TITLE}
			</h3>
		{+END}
		{+START,IF_NON_EMPTY,{META}}
			<div class="standardbox_meta_classic">
				{+START,LOOP,META}
					<div>{KEY}: {VALUE}</div>
				{+END}
			</div>
		{+END}
		{+START,IF,{EXPAND}}{+START,IF,{$JS_ON}}
			{+START,IF_NOT_IN_ARRAY,tray_closed,OPTIONS}
			<div class="standardbox_main_classic hide_tag">
			{+END}
			{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
			<div class="hide_tag standardbox_main_classic" style="display: none">
			{+END}
		{+END}{+END}
		{+START,IF,{$OR,{$NOT,{EXPAND}},{$NOT,{$JS_ON}}}}
			<div class="standardbox_main_classic">
		{+END}
			<div class="float_surrounder">
				{CONTENT}
			</div>
			{+START,IF_NON_EMPTY,{LINKS}}
				{$SET,linkbar,0}
				<div class="standardbox_classic standardbox_links_classic community_block_tagline"> 
					{+START,LOOP,LINKS}
						{+START,IF,{$GET,linkbar}} &middot; {+END}{_loop_var}{$SET,linkbar,1}
					{+END}
				 </div>
			{+END}
		</div>
	</div>
</div>

{+START,IF,{EXPAND}}{+START,IF,{$JS_ON}}
	<script type="text/javascript">// <![CDATA[
		var cookie_value=ReadCookie('tray_{TITLE|}');
		{+START,IF_IN_ARRAY,tray_open,OPTIONS}
		if (cookie_value=='closed') hide_tag(document.getElementById('{TITLE|}'),true);
		{+END}
		{+START,IF_IN_ARRAY,tray_closed,OPTIONS}
		if (cookie_value=='open') hide_tag(document.getElementById('{TITLE|}'),true);
		{+END}
	//]]></script>
{+END}{+END}
