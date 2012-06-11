<div id="{TITLE|}" class="box box___standardbox_default"{+START,IF_NON_EMPTY,{WIDTH}} style="width: {WIDTH*}"{+END}>
	{+START,IF_NON_EMPTY,{TITLE}}
		{+START,IF_IN_ARRAY,OPTIONS,tray_open,tray_closed}
			<h3 class="toggleable_tray_title">
				{+START,IF,{$JS_ON}}
					{+START,IF_IN_ARRAY,OPTIONS,tray_open}
						<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{TITLE|}');"><img alt="{!CONTRACT}: {$STRIP_TAGS,{TITLE}}" title="{!CONTRACT}" src="{$IMG*,contract}" /></a>
					{+END}
					{+START,IF_IN_ARRAY,OPTIONS,tray_closed}
						<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{TITLE|}');"><img alt="{!EXPAND}: {$STRIP_TAGS,{TITLE}}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
					{+END}
				{+END}

				{+START,IF_NON_EMPTY,{TOP_LINKS}}{+START,IF,{$JS_ON}}
					{TOP_LINKS}
				{+END}{+END}

				<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode,false,'{TITLE|}');">{TITLE}</a>
			</h3>
		{+END}
	{+END}

	{+START,IF_IN_ARRAY,OPTIONS,tray_open}
	<div class="toggleable_tray">
	{+END}
	{+START,IF_IN_ARRAY,OPTIONS,tray_closed}
	<div class="toggleable_tray" style="display: none" aria-expanded="false">
	{+END}
	{+START,IF_NOT_IN_ARRAY,OPTIONS,tray_open,tray_closed}
	<div class="box_inner">
	{+END}
		{+START,IF_NOT_IN_ARRAY,OPTIONS,tray_open,tray_closed}{+START,IF_NON_EMPTY,{TITLE}}
			<h3>{TITLE}</h3>
		{+END}{+END}

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

{+START,IF_IN_ARRAY,OPTIONS,tray_open,tray_closed}{+START,IF,{$JS_ON}}
	<script type="text/javascript">// <![CDATA[
		handle_tray_cookie_setting('{TITLE|}');
	//]]></script>
{+END}{+END}
