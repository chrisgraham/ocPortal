{TITLE}

{LEADER}

{+START,IF_NON_EMPTY,{PROMOTION_INFO}}
	<p>{PROMOTION_INFO}</p>
{+END}

{$SET,bound_catalogue_entry,{$CATALOGUE_ENTRY_FOR,group,{ID}}}
{+START,IF_NON_EMPTY,{$GET,bound_catalogue_entry}}{$CATALOGUE_ENTRY_ALL_FIELD_VALUES,{$GET,bound_catalogue_entry}}{+END}

<div class="sliverised_page">
	{+START,IF_NON_EMPTY,{PRIMARY_MEMBERS}}
		{PRIMARY_MEMBERS}
		<br />
	{+END}

	{+START,IF_NON_EMPTY,{SECONDARY_MEMBERS}}
		{SECONDARY_MEMBERS}
		<br />
	{+END}

	{+START,IF_NON_EMPTY,{PROSPECTIVE_MEMBERS}}
		{PROSPECTIVE_MEMBERS}
		<br />
	{+END}

	{+START,IF_EMPTY,{PRIMARY_MEMBERS}{SECONDARY_MEMBERS}{PROSPECTIVE_MEMBERS}}
		<p class="nothing_here">{!NO_MEMBERS}</p>
	{+END}

	{+START,IF_EMPTY,{PRIMARY_MEMBERS}{SECONDARY_MEMBERS}{PROSPECTIVE_MEMBERS}}
		<p class="nothing_here">{!NO_ENTRIES}</p>
	{+END}

	{+START,IF_NON_EMPTY,{ADD_URL}}
		{+START,BOX,{!ADD_MEMBER_TO_GROUP},,light}
			<form title="{!ADD_MEMBER_TO_GROUP}" onsubmit="if (checkFieldForBlankness(this.elements['username'],event)) { disable_button_just_clicked(this); return true; } return false;" action="{ADD_URL*}" method="post">
				<div>
					<label for="vga_username">{!USERNAME}: </label>
					<input maxlength="80" onkeyup="update_ajax_member_list(this,null,false,event);" alt="{!USERNAME}" type="text" id="vga_username" name="username" value="" />
					<input class="button_pageitem" type="submit" value="{!ADD_MEMBER_TO_GROUP}" />
				</div>
			</form>
		{+END}
		<br />
	{+END}

	{+START,IF_NON_EMPTY,{APPLY_URL}}
		<p>&raquo; <a href="{APPLY_URL*}">{APPLY_TEXT*}</a></p>
		<br />
	{+END}
</div>

{+START,INCLUDE,NOTIFICATION_BUTTONS}
	NOTIFICATIONS_TYPE=ocf_member_joined_group
	NOTIFICATIONS_ID={ID}
	BREAK=1
	RIGHT=1
{+END}

{+START,IF_PASSED,FORUM}{+START,IF_NON_EMPTY,{FORUM}}
	<h2>{!ACTIVITY}</h2>

	{$BLOCK,block=main_forum_topics,param={FORUM}}

	{+START,IF,{$CONFIG_OPTION,show_screen_actions}}{+START,IF_PASSED,_TITLE}{$BLOCK,failsafe=1,block=main_screen_actions,title={$META_DATA,title}}{+END}{+END}
{+END}{+END}

{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
{+START,INCLUDE,STAFF_ACTIONS}
	1_URL={EDIT_URL*}
	1_TITLE={!EDIT}
	1_ACCESSKEY=q
	1_REL=edit
{+END}
