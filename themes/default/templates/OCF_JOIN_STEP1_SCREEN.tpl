{TITLE}

<p>
	{!DESCRIPTION_I_AGREE_RULES}
</p>

{+START,BOX}
	{RULES}
{+END}

<form title="{!PRIMARY_PAGE_FORM}" class="ocf_join_1" method="post" action="{URL*}">
	<p>
		<label for="confirm"><input type="checkbox" id="confirm" name="confirm" value="1" onclick="document.getElementById('proceed_button').disabled=!this.checked;" />{!I_AGREE_RULES}</label>
	</p>

	{+START,IF_NON_EMPTY,{GROUP_SELECT}}
		<label for="additional_group">{!CHOOSE_JOIN_USERGROUP}
			<select id="additional_group" name="additional_group">
				{GROUP_SELECT}
			</select>
		</label>
		<br />
	{+END}

	<p>
		{+START,IF,{$JS_ON}}
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" disabled="disabled" id="proceed_button" />
		{+END}
		{+START,IF,{$NOT,{$JS_ON}}}
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" id="proceed_button" />
		{+END}
	</p>
</form>

{+START,IF_NON_EMPTY,{GENERATE_HOST}}
	{+START,BOX,{!REMOTE_MEMBERS},,light}
		{!DESCRIPTION_IS_REMOTE_MEMBER,{GENERATE_HOST}}
	{+END}
{+END}

