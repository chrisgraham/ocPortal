{$REQUIRE_CSS,menu__sitemap}
{$REQUIRE_JAVASCRIPT,javascript_menu_sitemap}

{+START,IF,{$NOT,{$JS_ON}}}
	<nav class="menu_type__sitemap" role="navigation">
		<ul itemprop="significantLinks">
			{CONTENT}
		</ul>
	</nav>
{+END}

{+START,IF,{$JS_ON}}
	{$SET,menu_sitemap_id,menu_sitemap_{$RAND}}

	<nav id="{$GET*,menu_sitemap_id}" class="menu_type__sitemap" role="navigation">
		<div aria-busy="true" class="spaced">
			<div class="ajax_loading vertical_alignment">
				<img src="{$IMG*,loading}" title="{!LOADING}" alt="{!LOADING}" />
				<span>{!LOADING}</span>
			</div>
		</div>
	</nav>

	<script>// <![CDATA[
		add_event_listener_abstract(window,'load',function () {
			generate_menu_sitemap('{$GET;/,menu_sitemap_id}',[{CONTENT/}]);
		} );
	//]]></script>
{+END}
