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
			<a class="buttons__goto button_pageitem" href="{URL*}"><span>{!FORUM_POST} #{ID*}</span></a>
		</p>
	{+END}
</div>
