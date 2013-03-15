{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}

<div class="box box___standardbox_accordion"{+START,IF_NON_EMPTY,{WIDTH}} style="width: {WIDTH*}"{+END}>
	{+START,IF_NON_EMPTY,{TITLE}}
		<h3 class="toggleable_tray_title" onkeypress="this.onclick(event);" onclick="this.getElementsByTagName('a')[0].onclick(event);">
			{+START,IF_NOT_IN_ARRAY,OPTIONS,tray_open}
				{+START,IF,{$JS_ON}}<a class="toggleable_tray_button" href="#" onclick="return accordion(this.parentNode.parentNode);"><img alt="{!EXPAND}: {$STRIP_TAGS,{TITLE}}" title="{!EXPAND}" src="{$IMG*,expand}" /></a> {+END}
			{+END}
			{+START,IF_IN_ARRAY,OPTIONS,tray_open}
				{+START,IF,{$JS_ON}}<a class="toggleable_tray_button" href="#" onclick="return accordion(this.parentNode.parentNode);"><img alt="{!CONTRACT}: {$STRIP_TAGS,{TITLE}}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a> {+END}
			{+END}

			{+START,IF_NON_EMPTY,{TOP_LINKS}}{+START,IF,{$JS_ON}}
				{TOP_LINKS}
			{+END}{+END}

			{+START,IF,{$JS_ON}}<a class="toggleable_tray_button" href="#" onclick="return accordion(this.parentNode.parentNode);">{TITLE}</a>{+END}
			{+START,IF,{$NOT,{$JS_ON}}}{TITLE}{+END}
		</h3>
	{+END}
	<div class="toggleable_tray"{+START,IF_NOT_IN_ARRAY,OPTIONS,tray_open}{+START,IF,{$JS_ON}} style="display: none" aria-expanded="false"{+END}{+END}>
		{+START,IF_NON_EMPTY,{META}}
			<div class="meta_details" role="contentinfo">
				<dl class="meta_details_list">
					{+START,LOOP,META}
						<dt class="field_name">{KEY}:</dt> <dd>{VALUE}</dd>
					{+END}
				</dl>
			</div>
		{+END}

		{$PARAGRAPH,{CONTENT}}

		{+START,IF_NON_EMPTY,{LINKS}}
			<ul class="horizontal_links associated_links_block_group">
				{+START,LOOP,LINKS}
					<li>{_loop_var}</li>
				{+END}
			</ul>
		{+END}
	</div>
</div>
