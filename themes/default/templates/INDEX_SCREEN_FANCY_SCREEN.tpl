{TITLE}

<p{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
	{PRE}
</p>

{+START,IF_NON_EMPTY,{CONTENT}}
<ul{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
	{CONTENT}
</ul>
{+END}
{+START,IF_EMPTY,{CONTENT}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

<p>
	{POST}
</p>

