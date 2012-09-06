{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
<div id="{$GET*,wrapper_id}">
	{+START,IF_NON_EMPTY,{GALLERIES}}
		<div class="box box___download_category_screen"><div class="box_inner compacted_subbox_stream">
			<div>
				{GALLERIES}
			</div>
		</div></div>
	{+END}
	{+START,IF_EMPTY,{GALLERIES}}
		<p class="nothing_here">{!NO_ENTRIES}</p>
	{+END}

	{+START,IF_NON_EMPTY,{PAGINATION}}
		<div class="float_surrounder ajax_block_wrapper_links">
			{PAGINATION}
		</div>
	{+END}

	{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
	{+START,INCLUDE,STAFF_ACTIONS}
		1_URL={ADD_GALLERY_URL*}
		1_TITLE={!ADD_GALLERY}
		1_REDIRECT_HASH=galleries
		2_URL={ADD_IMAGE_URL*}
		2_TITLE={!ADD_IMAGE}
		2_REDIRECT_HASH=galleries
		3_URL={ADD_VIDEO_URL*}
		3_TITLE={!ADD_VIDEO}
		3_REDIRECT_HASH=galleries
	{+END}

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			{$REQUIRE_JAVASCRIPT,javascript_ajax}
			internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),['[^_]*_start'], { } );
		} );
	//]]></script>
</div>
