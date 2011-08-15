{TITLE}

{+START,IF_NON_EMPTY,{PRE}}
	<div{$?,{$VALUE_OPTION,html5}, itemprop="description"}>
		{+START,IF,{$NOT,{$IN_STR,{PRE},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}<p>{+END}{PRE}{+START,IF,{$NOT,{$IN_STR,{PRE},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}</p>{+END}
	</div>
{+END}

{+START,IF_NON_EMPTY,{CONTENT}}
<ul class="actions_list"{$?,{$VALUE_OPTION,html5}, itemprop="significantLinks"}>
	{CONTENT}
</ul>
{+END}
{+START,IF_EMPTY,{CONTENT}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

{+START,IF_NON_EMPTY,{POST}}
	{+START,IF,{$NOT,{$IN_STR,{POST},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}<p>{+END}{POST}{+START,IF,{$NOT,{$IN_STR,{POST},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}</p>{+END}
{+END}

