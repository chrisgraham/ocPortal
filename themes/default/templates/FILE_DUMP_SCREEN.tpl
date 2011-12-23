{TITLE}

<h2>{!FILES_IN_FOLDER}</h2>

{+START,IF_NON_EMPTY,{FILES}}
	{FILES}
{+END}
{+START,IF_EMPTY,{FILES}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

<br />

<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>

{+START,BOX,{!FILEDUMP_UPLOAD},,med}
	{UPLOAD_FORM}
{+END}

{+START,IF_NON_EMPTY,{CREATE_FOLDER_FORM}}
	<br />
	{+START,BOX,{!FILEDUMP_CREATE_FOLDER},,light}
		{CREATE_FOLDER_FORM}
	{+END}
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,IF,{$AND,{$SHOW_DOCS},{$HAS_SPECIFIC_PERMISSION,see_software_docs}}}
	{+START,INCLUDE,STAFF_ACTIONS}
		STAFF_ACTIONS_TITLE={!STAFF_ACTIONS}
		1_URL={$BRAND_BASE_URL*}/docs{$VERSION*}/pg/tut_collaboration
		1_TITLE={!HELP}
		1_REL=help
	{+END}
{+END}
