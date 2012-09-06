<div class="ocf_post_box">
	<div class="wide_table_wrap"><div class="wide_table ocf_topic">
		<div>
			{POST}
		</div>
	</div></div>

	{+START,IF_PASSED,BREADCRUMBS}
		<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>
			{!LOCATED_IN,{BREADCRUMBS}}
		</p></nav>
	{+END}

	{+START,IF_PASSED,URL}
		<p class="shunted_button">
			<a href="{URL*}"><img class="button_pageitem" src="{$IMG*,pageitem/goto}" alt="{!FORUM_POST} #{ID*}" /></a>
		</p>
	{+END}
</div>
