{TITLE}

{+START,IF_PASSED,DESCRIPTION}
	<div>{DESCRIPTION}</div>
{+END}

{+START,IF_PASSED,SUB_TITLE}
	<h2>{SUB_TITLE}</h2>
{+END}

{CONTENT}

{+START,IF_PASSED,PAGINATION}
	{+START,IF_NON_EMPTY,{PAGINATION}}
		<div class="pagination_spacing float_surrounder">
			{PAGINATION}
		</div>
	{+END}
{+END}
