<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="solidborder wide_table ocf_topic">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 130px" />
			<col style="width: 100%" />
		</colgroup>
	{+END}

	<tbody>
		{POST}
	</tbody>
</table></div>

<p class="right">
	<a href="{URL*}"><img class="button_pageitem page_icon" src="{$IMG*,pageitem/goto}" title="" alt="{!FORUM_POST} #{ID*}" /></a>
</p>

<p class="breadcrumbs_always non_accessibility_redundancy">
	<img class="breadcrumbs_img" src="{$IMG*,treenav}" alt="&gt; " title="{!YOU_ARE_HERE}" />
	{TREE}
</p>
