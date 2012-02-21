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
{+END}

<br />

<div class="required_field_warning"><span class="required_star">*</span> {!REQUIRED}</div>

{+START,BOX,{!FILEDUMP_UPLOAD},,med}
	{UPLOAD_FORM}
{+END}

{+START,IF_NON_EMPTY,{CREATE_FOLDER_FORM}}
	<br />
	<div class="standardbox_wrap_classic lightborder">
		<div class="standardbox_classic">
			<div class="standardbox_title_light toggle_div_title">
				{!FILEDUMP_CREATE_FOLDER}
				<a class="hide_button" href="#" onclick="event.returnValue=false; toggleSectionInline('create_folder','block'); return false;"><img id="e_create_folder" alt="{!EXPAND}: {!FILEDUMP_CREATE_FOLDER}" title="{!EXPAND}" src="{$IMG*,expand}" /></a>
			</div>
		</div>

		<div class="toggler_main standardbox_main_classic" id="create_folder" style="{$JS_ON,display: none,}">
			{CREATE_FOLDER_FORM}
		</div>
	</div>
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
