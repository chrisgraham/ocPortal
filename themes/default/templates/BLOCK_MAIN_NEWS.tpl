{$SET,wrapper_id,ajax_block_wrapper_{$RAND%}}
<div id="{$GET*,wrapper_id}">
	<section class="box box___block_main_news"><div class="box_inner compacted_subbox_stream">
		{+START,IF,{$NOT,{BLOG}}}{+START,IF_NON_EMPTY,{TITLE}}
			<h3>{TITLE}</h3>
		{+END}{+END}

		{CONTENT}

		{+START,IF_NON_EMPTY,{BRIEF}}
			<div>
				<h2>{$?,{BLOG},{!BLOG_OLDER_NEWS},{!OLDER_NEWS}}</h2>

				{BRIEF}
			</div>
		{+END}

		{+START,IF_PASSED,PAGINATION}
			{+START,IF_NON_EMPTY,{PAGINATION}}
				<div class="float_surrounder ajax_block_wrapper_links">
					{PAGINATION}
				</div>
			{+END}
		{+END}

		{+START,IF_NON_EMPTY,{ARCHIVE_URL}{SUBMIT_URL}{RSS_URL}{ATOM_URL}}
			<ul class="horizontal_links associated_links_block_group force_margin">
				{+START,IF_NON_EMPTY,{ARCHIVE_URL}}
					<li><a rel="archives" href="{ARCHIVE_URL*}">{!VIEW_ARCHIVE}</a></li>
				{+END}
				{+START,IF_NON_EMPTY,{SUBMIT_URL}}
					<li><a rel="add" href="{SUBMIT_URL*}">{$?,{BLOG},{!ADD_NEWS_BLOG},{!ADD_NEWS}}</a></li>
				{+END}
				{+START,IF_NON_EMPTY,{RSS_URL}}
					<li><a href="{RSS_URL*}"><abbr title="Really Simple Syndication">RSS</abbr></a></li>
				{+END}
				{+START,IF_NON_EMPTY,{ATOM_URL}}
					<li><a href="{ATOM_URL*}">Atom</a></li>
				{+END}
			</ul>
		{+END}
	</div></section>

	<script type="text/javascript">// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			{$REQUIRE_JAVASCRIPT,javascript_ajax}
			internalise_ajax_block_wrapper_links('{$FACILITATE_AJAX_BLOCK_CALL;,{BLOCK_PARAMS}}',document.getElementById('{$GET;,wrapper_id}'),['[^_]*_start'], { } );
		} );
	//]]></script>
</div>
