<div class="wide_table_wrap"><div class="wide_table ocf_topic">
	<div>
		{POST}
	</div>
</div></div>

{+START,IF_PASSED,URL}{+START,IF_NON_EMPTY,{URL}}
	<p class="right">
		<a href="{URL*}"><img class="button_pageitem" src="{$IMG*,pageitem/goto}" alt="{!FORUM_POST} #{ID*}" /></a>
	</p>
{+END}{+END}

{+START,IF_PASSED,BREADCRUMBS}
	<nav class="breadcrumbs" itemprop="breadcrumb" role="navigation"><p>
		<img class="breadcrumbs_img" src="{$IMG*,breadcrumbs}" alt="&gt; " title="{!YOU_ARE_HERE}" />
		{BREADCRUMBS}
	</p></nav>
{+END}
