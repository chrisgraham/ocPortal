<div class="cguid_{_GUID*}">
	{+START,IF_NON_EMPTY,{TITLE}}
		<h2>{TITLE*}</h2>
	{+END}

	{+START,IF_NON_EMPTY,{CONTENT}}
		{$,Example carousel layout if the 'carousel' GUID was passed}
		{$,With some basic templating you could also achieve simple lists or tables}
		{+START,IF,{$EQ,{_GUID},carousel}}
			{$REQUIRE_JAVASCRIPT,javascript_dyn_comcode}

			{$SET,carousel_id,{$RAND}}

			<div id="carousel_{$GET*,carousel_id}" class="carousel" style="display: none">
				<div class="move_left" onkeypress="this.onmousedown(event);" onmousedown="carousel_move({$GET*,carousel_id},-30); return false;"></div>
				<div class="move_right" onkeypress="this.onmousedown(event);" onmousedown="carousel_move({$GET*,carousel_id},+30); return false;"></div>

				<div class="main">
				</div>
			</div>

			<div class="carousel_temp" id="carousel_ns_{$GET*,carousel_id}">
				{+START,LOOP,CONTENT}
					{_loop_var}
				{+END}
			</div>

			<script type="text/javascript">// <![CDATA[
				add_event_listener_abstract(window,'load',function () {
					initialise_carousel({$GET,carousel_id});
				} );
			//]]></script>
		{+END}

		{$,Normal sequential box layout}
		{$,With some very basic CSS you could also achieve grid layouts}
		{+START,IF,{$NEQ,{_GUID},carousel}}
			<div class="float_surrounder">
				{+START,LOOP,CONTENT}
					{_loop_var}
				{+END}
			</div>
		{+END}
	{+END}

	{+START,IF_EMPTY,{CONTENT}}
		<p class="nothing_here">{!NO_ENTRIES}</p>
	{+END}

	{+START,IF_PASSED,PAGINATION}
		{+START,IF_NON_EMPTY,{PAGINATION}}
			<div class="pagination_spacing float_surrounder">
				{PAGINATION}
			</div>
		{+END}
	{+END}

	{+START,IF_NON_EMPTY,{SUBMIT_URL}{ARCHIVE_URL}}
		<ul class="horizontal_links associated_links_block_group force_margin">
			{+START,IF_NON_EMPTY,{SUBMIT_URL}}
				<li><a rel="add" href="{SUBMIT_URL*}">{!ADD}</a></li>
			{+END}
			{+START,IF_NON_EMPTY,{ARCHIVE_URL}}
				<li><a href="{ARCHIVE_URL*}" title="{!ARCHIVES}: {TYPE*}">{!ARCHIVES}</a></li>
			{+END}
		</ul>
	{+END}
</div>
