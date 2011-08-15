{TITLE}

{+START,IF_PASSED,TEXT}
	<div>
		{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>}}}</p>{+END}
	</div>
{+END}

{RESULTS_TABLE}

{+START,IF_PASSED,FORM}
	{FORM}
{+END}
