{TITLE}

{+START,SET,SUB_CATEGORIES}
	{+START,LOOP,SUB_CATEGORIES}
		<h2>{LETTER*}</h2>

		{+START,IF_NON_EMPTY,{DOWNLOADS}}
			{DOWNLOADS}
		{+END}


		{+START,IF_EMPTY,{DOWNLOADS}}
			<p class="nothing_here">{!NO_ENTRIES}</p>
		{+END}
	{+END}
{+END}
{+START,IF_NON_EMPTY,{$TRIM,{$GET,SUB_CATEGORIES}}}
	{$GET,SUB_CATEGORIES}
{+END}
{+START,IF_EMPTY,{$TRIM,{$GET,SUB_CATEGORIES}}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={SUBMIT_URL*}
	1_TITLE={!ADD_DOWNLOAD}
	1_REL=add
	2_URL={ADD_CAT_URL*}
	2_TITLE={!ADD_DOWNLOAD_CATEGORY}
	2_REL=add
	3_ACCESSKEY=q
	3_URL={EDIT_CAT_URL*}
	3_TITLE={!EDIT_DOWNLOAD_CATEGORY}
	3_REL=edit
{+END}

