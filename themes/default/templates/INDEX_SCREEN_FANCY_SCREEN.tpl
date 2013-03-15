{TITLE}

<p itemprop="description">
	{PRE}
</p>

{+START,IF_NON_EMPTY,{CONTENT}}
<ul itemprop="significantLinks">
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

