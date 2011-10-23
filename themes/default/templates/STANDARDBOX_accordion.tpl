{$JAVASCRIPT_INCLUDE,javascript_dyn_comcode}

<div class="medborder">
	<div id="{TITLE|}" style="height: {HEIGHT'}; width: {WIDTH'}">
		{+START,IF_NON_EMPTY,{TITLE}}
			<h3 class="standardbox_title_classic" onkeypress="this.onclick(event);" onclick="this.getElementsByTagName('a')[0].onclick(event);">
				{+START,IF_NOT_IN_ARRAY,tray_open,OPTIONS}
					{+START,IF,{$JS_ON}}<a class="standardbox_tray hide_button" href="#" onclick="accordion(this.parentNode.parentNode); cancelBubbling(event,this); return false;"><img alt="{!EXPAND}: {$STRIP_TAGS,{TITLE}}" title="{!EXPAND}" src="{$IMG*,expand}" /></a> {+END}
				{+END}
				{+START,IF_IN_ARRAY,tray_open,OPTIONS}
					{+START,IF,{$JS_ON}}<a class="standardbox_tray hide_button" href="#" onclick="accordion(this.parentNode.parentNode); cancelBubbling(event,this); return false;"><img alt="{!CONTRACT}: {$STRIP_TAGS,{TITLE}}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a> {+END}
				{+END}
				{TITLE}
			</h3>
		{+END}
		<div class="hide_tag medborder_box"{+START,IF_NOT_IN_ARRAY,tray_open,OPTIONS}{+START,IF,{$JS_ON}} style="display: none"{+END}{+END}>
			{+START,IF_NON_EMPTY,{META}}
				<div class="medborder_detailhead_wrap">
					<div class="medborder_detailhead">
						{+START,LOOP,META}
							<div>{KEY}: {VALUE}</div>
						{+END}
					</div>
				</div>
			{+END}
			<div class="standardbox_main_classic"><div class="float_surrounder">
				{CONTENT}
			</div></div>
			{+START,IF_NON_EMPTY,{LINKS}}
				{$SET,linkbar,0}
				<div class="standardbox_links_classic community_block_tagline"> [
					{+START,LOOP,LINKS}
						{+START,IF,{$GET,linkbar}} &middot; {+END}{_loop_var}{$SET,linkbar,1}
					{+END}
				] </div>
			{+END}
		</div>
	</div>
</div>
