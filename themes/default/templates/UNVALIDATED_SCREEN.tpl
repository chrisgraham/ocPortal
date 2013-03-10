{TITLE}

{+START,IF_PASSED,UNVALIDATED_PAGE_TEXT}
	<p>
		{!UNVALIDATED_PAGE_TEXT}
	</p>
{+END}

{+START,IF_NON_EMPTY,{SECTIONS}}
	<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>

	{SECTIONS}
{+END}

{+START,IF_EMPTY,{SECTIONS}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}
