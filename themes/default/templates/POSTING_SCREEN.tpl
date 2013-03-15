{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

{+START,IF_PASSED,TEXT}
	{+START,IF_NON_EMPTY,{TEXT}}
		<div>
			{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}<p>{+END}{TEXT}{+START,IF,{$NOT,{$IN_STR,{TEXT},<p>,<div>,<ul>,<ol>,<h2>,<h3>,<p ,<div ,<ul ,<ol ,<h2 ,<h3 }}}</p>{+END}
		</div>
	{+END}
{+END}

{POSTING_FORM}

{+START,IF_PASSED,REVISION_HISTORY}
	{REVISION_HISTORY}
{+END}

