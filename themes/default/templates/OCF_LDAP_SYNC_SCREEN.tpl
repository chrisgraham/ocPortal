{TITLE}

<p>
	{!LDAP_INTRO}
</p>

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	<div>
		<p>
			{!LDAP_SYNC_GROUPS_ADD}
		</p>

		<div class="standard_indent">
			{GROUPS_ADD}
			{+START,IF_EMPTY,{GROUPS_ADD}}
				<p class="nothing_here">{!NONE}</p>
			{+END}
		</div>
	</div>

	<div>
		<p>
			{!LDAP_SYNC_GROUPS_DELETE}
		</p>

		<div class="standard_indent">
			{GROUPS_DELETE}
			{+START,IF_EMPTY,{GROUPS_DELETE}}
				<p class="nothing_here">{!NONE}</p>
			{+END}
		</div>
	</div>

	<div>
		<p>
			{!LDAP_SYNC_MEMBERS_DELETE}
		</p>

		<div class="standard_indent">
			{MEMBERS_DELETE}
			{+START,IF_EMPTY,{MEMBERS_DELETE}}
				<p class="nothing_here">{!NONE}</p>
			{+END}
		</div>
	</div>

	<p class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
	</p>
</form>

