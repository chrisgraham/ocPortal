{TITLE}

<h2>{!FILES_IN_FOLDER}</h2>

{+START,IF_NON_EMPTY,{FILES}}
	{FILES}
{+END}
{+START,IF_EMPTY,{FILES}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=filedump
	NOTIFICATIONS_ID={PLACE}
	BREAK=1
	RIGHT=1
{+END}

<p class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</p>

{+START,IF_NON_EMPTY,{UPLOAD_FORM}}
	<div class="box box___file_dump_screen"><div class="box_inner">
		<h2>{!FILEDUMP_UPLOAD}</h2>

		{UPLOAD_FORM}
	</div></div>
{+END}

{+START,IF_NON_EMPTY,{CREATE_FOLDER_FORM}}
	<div class="box box___file_dump_screen">
		<h2 class="toggleable_tray_title">
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);"><img alt="{!EXPAND}: {!FILEDUMP_CREATE_FOLDER}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			<a class="toggleable_tray_button" href="#" onclick="return toggleable_tray(this.parentNode.parentNode);">{!FILEDUMP_CREATE_FOLDER}</a>
		</h2>

		<div class="toggleable_tray" style="{$JS_ON,display: none,}" aria-expanded="false">
			{CREATE_FOLDER_FORM}
		</div>
	</div>
{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,IF,{$AND,{$SHOW_DOCS},{$HAS_PRIVILEGE,see_software_docs}}}
	{+START,INCLUDE,STAFF_ACTIONS}
		STAFF_ACTIONS_TITLE={!STAFF_ACTIONS}
		1_URL={$BRAND_BASE_URL*}/docs{$VERSION*}/pg/tut_collaboration
		1_TITLE={!HELP}
		1_REL=help
	{+END}
{+END}
